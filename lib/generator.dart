import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class BuiltReduxGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final result = new StringBuffer();
    for (final element in library.allElements) {
      if (element is ClassElement && _needsReduxActions(element)) {
        log.info('Generating action classes for ${element.name}');
        result.writeln(_generateActions(element));
      }

      if (element is ClassElement && _isBuiltReducer(element)) {
        log.info('Generating reduce children classes for ${element.name}');
        result.writeln(_generateReducer(element));
      }
    }

    return result.toString();
  }
}

bool _needsReduxActions(ClassElement classElement) =>
    _hasSuperType(classElement, 'ReduxActions');

bool _isBuiltReducer(ClassElement classElement) {
  final declaration = classElement.computeNode().toString();
  return declaration.contains('extends ${classElement.name}Reducer') ||
      declaration.contains('extends Object with ${classElement.name}Reducer');
}

bool _hasSuperType(ClassElement classElement, String type) =>
    classElement.allSupertypes
        .any((interfaceType) => interfaceType.name == type) &&
    !classElement.displayName.startsWith('_\$');

bool _isActionDispatcher(Element element) =>
    element is ClassElement && element.name == 'ActionDispatcher';

bool _isGeneratedDispatcherFinal(String dispatcherCode) =>
    dispatcherCode.startsWith('\nfinal') || dispatcherCode.startsWith('final');

String _generateActions(ClassElement element) {
  var defaultFunctionDeclaration =
      '@override void syncWithStore(Dispatcher dispatcher)';
  var initializerCode = '''
class _\$${element.name} extends ${element.name}{
  factory _\$${element.name}() => new _\$${element.name}._();
  
  _\$${element.name}._() : super._();
  
  $defaultFunctionDeclaration;
}''';

  var nameCode = 'class ${element.name}Names {\n}';
  var syncWithStoreCode = '$defaultFunctionDeclaration{\n}';
  for (var e in element.fields) {
    var fieldName = e.name;
    var ele = e.type.element;
    var typeName = ele.name;

    if (_isActionDispatcher(ele)) {
      var genericType = _getActionDispatcherGenericType(e);
      // generate the action name
      nameCode = _appendCode(
        nameCode,
        'static final ActionName<${genericType}> $fieldName = new ActionName<${genericType}>(\'${element.name}-$fieldName\');\n',
      );

      // generate the dispatcher
      var actionDispatcher =
          '\n${e.type.name}<${genericType}> ${e.name} = new ActionDispatcher<${genericType}>(\'${element.name}-$fieldName\');\n';

      // if it was not declared final make it final
      if (!_isGeneratedDispatcherFinal(actionDispatcher))
        actionDispatcher = '\nfinal $actionDispatcher';

      // append the action dispatcher to the class definition
      initializerCode = _appendCode(initializerCode, actionDispatcher);

      // append the sync function for this dispatcher
      syncWithStoreCode = _appendCode(
        syncWithStoreCode,
        '$fieldName.syncWithStore(dispatcher);',
      );
    } else if (ele is ClassElement && _needsReduxActions(ele)) {
      // this is a nested instance of redux actions
      // generate the instantiation
      initializerCode = _appendCode(
        initializerCode,
        'final $e = new $typeName();',
      );

      // append the sync function for this set of actions
      syncWithStoreCode = _appendCode(
        syncWithStoreCode,
        '\n$fieldName.syncWithStore(dispatcher);',
      );
    }
  }

  initializerCode = initializerCode.replaceFirst(
      '$defaultFunctionDeclaration;', syncWithStoreCode);
  return '$initializerCode\n\n$nameCode';
}

String _getActionDispatcherGenericType(FieldElement e) {
  var typeArgument =
      (e.type as InterfaceType).typeArguments.first as ParameterizedType;
  // generic type has generic type parameters?
  if (typeArgument.typeArguments.isEmpty ||
      typeArgument.typeArguments.every((ta) => ta.name == 'dynamic')) {
    return typeArgument.name;
  }
  return '${typeArgument.name}<${typeArgument.typeArguments.join(',')}>';
}

String _generateReducer(ClassElement element) {
  const reduceChildrenMatcher = '**reduceChildrenMatcher**';
  var builtName = element.name;
  var builderName = '${element.name}Builder';
  var nameCode = '''
abstract class ${builtName}Reducer implements BuiltReducer<$builtName, $builderName> {
  Map<String, Reducer<dynamic, $builtName, $builderName>>
      get reducer => null;

  void reduce(
      $builtName state, Action<dynamic> a, $builderName builder) {
    if (reducer != null) {
      final handler = reducer[a.name];
      if (handler != null) handler(state, a, builder);
    }
    reduceChildren(state, a, builder);
  }

  void reduceChildren($builtName state, Action<dynamic> a, $builderName builder) { 
    $reduceChildrenMatcher 
  }
}
''';

  var reduceChildrenContent = '';
  for (var e in element.fields) {
    var ele = e.type.element;
    if (ele is ClassElement && _isBuiltReducer(ele)) {
      String brName = e.name;
      reduceChildrenContent +=
          'state.$brName.reduce(state.$brName, a, builder.$brName);';
    }
  }

  return _replaceMatcher(
    reduceChildrenMatcher,
    nameCode,
    reduceChildrenContent,
  );
}

String _appendCode(String before, String newCode) =>
    before.replaceFirst('\n', '\n$newCode');

String _replaceMatcher(String matcher, String before, String newCode) =>
    before.replaceFirst(matcher, '$newCode');
