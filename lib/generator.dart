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
    }

    return result.toString();
  }
}

bool _needsReduxActions(ClassElement classElement) =>
    _hasSuperType(classElement, 'ReduxActions');

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
      '@override void setDispatcher(Dispatcher dispatcher)';
  var initializerCode = '''
class _\$${element.name} extends ${element.name}{
  factory _\$${element.name}() => new _\$${element.name}._();
  
  _\$${element.name}._() : super._();
  
  $defaultFunctionDeclaration;
}''';

  var nameCode = 'class ${element.name}Names {\n}';
  var setDispatcherCode = '$defaultFunctionDeclaration{\n}';
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
      setDispatcherCode = _appendCode(
        setDispatcherCode,
        '$fieldName.setDispatcher(dispatcher);',
      );
    } else if (ele is ClassElement && _needsReduxActions(ele)) {
      // this is a nested instance of redux actions
      // generate the instantiation
      initializerCode = _appendCode(
        initializerCode,
        'final $e = new $typeName();',
      );

      // append the sync function for this set of actions
      setDispatcherCode = _appendCode(
        setDispatcherCode,
        '\n$fieldName.setDispatcher(dispatcher);',
      );
    }
  }

  initializerCode = initializerCode.replaceFirst(
      '$defaultFunctionDeclaration;', setDispatcherCode);
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

  final typeArguments =
      typeArgument.typeArguments.map((ta) => ta.toString()).toList();

  // hack for thunks/repatches or any other type argument list where
  // any given argument is a Built and the proceding is a Builder
  // and the builder is dynamic in the typeArguments list becauses it is
  // yet to be generated. This is complex and a bit awkward but
  // it is written this way to be very careful not to make any unintended
  // changes the the typeArguments list.
  final boundParams = typeArgument.typeParameters.map((e) => e.bound);
  for (int i = 0; i < boundParams.length; i++) {
    // get the bound param at this spot
    final b = boundParams.elementAt(i);

    // if it is a Built and there is another argument after it
    // check if it is supposed to be a Builder
    if (b != null &&
        b.name.startsWith('Built') &&
        i != boundParams.length - 1) {
      final next = boundParams.elementAt(i + 1);
      if (next != null && next.name.startsWith('Builder')) {
        // if it is a builder replace typeArguments at this location as
        // the Built's name + Builder
        typeArguments.replaceRange(
          i + 1,
          i + 2,
          ['${typeArguments.elementAt(i)}Builder'],
        );
      }
    }
  }

  return '${typeArgument.name}<${typeArguments.join(',')}>';
}

String _appendCode(String before, String newCode) =>
    before.replaceFirst('\n', '\n$newCode');
