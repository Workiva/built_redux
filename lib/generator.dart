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

      if (element is ClassElement && _needsReduceChildren(element)) {
        log.info('Generating reduce children classes for ${element.name}');
        result.writeln(_generateReduceChildren(element));
      }
    }

    return result.toString();
  }
}

bool _needsReduxActions(ClassElement classElement) =>
    _hasSuperType(classElement, 'ReduxActions');

bool _needsReduceChildren(ClassElement classElement) =>
    _isBuiltReducer(classElement) && _containsNestedReducers(classElement);

bool _isBuiltReducer(ClassElement classElement) =>
    _hasSuperType(classElement, 'BuiltReducer');

bool _hasSuperType(ClassElement classElement, String type) =>
    classElement.allSupertypes
        .any((interfaceType) => interfaceType.name == type) &&
    !classElement.displayName.startsWith('_\$');

bool _containsNestedReducers(ClassElement classElement) {
  // TODO: warn if classElement doesn't mix in its withChildren
  for (var e in classElement.fields) {
    var ele = e.type.element;
    if (ele is ClassElement && _isBuiltReducer(ele)) return true;
  }
  return false;
}

bool _isActionDispatcher(Element element) =>
    element is ClassElement && element.name == 'ActionDispatcher';

bool _isGeneratedDispatcherFinal(String dispatcherCode) =>
    dispatcherCode.startsWith('\nfinal') || dispatcherCode.startsWith('final');

String _generateActions(ClassElement element) {
  var initializerCode =
      "class _\$${element.name} extends ${element.name}{\nfactory _\$${element.name}() => new _\$${element.name}._();\n_\$${element.name}._() : super._();\nsyncWithStore(dispatcher);\n}";
  var nameCode = "class ${element.name}Names {\n\n}";
  var syncWithStoreCode = 'syncWithStore(dispatcher) {\n\n}';
  for (var e in element.fields) {
    var fieldName = e.name;
    var ele = e.type.element;
    var typeName = ele.name;

    if (_isActionDispatcher(ele)) {
      // generate the action name
      nameCode = _appendCode(
        nameCode,
        'static final ActionName<${_getActionDispatcherGenericType(e)}> $fieldName = new ActionName<${_getActionDispatcherGenericType(e)}>(\'${element.name}-$fieldName\');\n',
      );

      // generate the dispatcher
      var actionDispatcher =
          '\n${e.toString()} = new ActionDispatcher<${_getActionDispatcherGenericType(e)}>(\'${element.name}-$fieldName\');\n';

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
        'final ${e.toString()} = new $typeName();',
      );

      // append the sync function for this set of actions
      syncWithStoreCode = _appendCode(
        syncWithStoreCode,
        '\n$fieldName.syncWithStore(dispatcher);',
      );
    }
  }

  initializerCode = initializerCode.replaceFirst(
      'syncWithStore(dispatcher);', syncWithStoreCode);
  return '$initializerCode\n\n$nameCode';
}

// TODO: find a better way
String _getActionDispatcherGenericType(FieldElement e) =>
    e.toString().substring(
          e.toString().indexOf('<') + 1,
          e.toString().lastIndexOf('>'),
        );

List<DartType> _getBVTypes(ClassElement element) {
  for (var st in element.allSupertypes) {
    if (st.name == 'BuiltReducer') return st.typeArguments;
  }
  throw new Exception(
      'No typeArguments on BuiltReducer for element ${element.name}');
}

String _generateReduceChildren(ClassElement element) {
  var types = _getBVTypes(element);
  var nameCode =
      "class ${element.name}ReduceChildren {reduceChildren(${types[0].name} state, Action<dynamic> a, ${types[0].name}Builder builder) {\n }}";
  for (var e in element.fields) {
    var ele = e.type.element;
    if (ele is ClassElement && _isBuiltReducer(ele)) {
      String brName = e.name;
      nameCode = _appendCode(
          nameCode, 'state.$brName.reduce(state.$brName, a, builder.$brName);');
    }
  }
  return nameCode;
}

String _appendCode(String before, String newCode) =>
    before.replaceFirst('\n', '\n$newCode');
