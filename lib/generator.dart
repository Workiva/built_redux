import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class BuiltReduxGenerator extends Generator {
  @override
  Future<String> generate(Element element, BuildStep buildStep) async {
    if (element is ClassElement && needsReduxActions(element)) {
      log.info('Generating action classes for ${element.name}');
      return generateActions(element);
    }

    return null;
  }
}

bool needsReduxActions(ClassElement classElement) => needsGen(classElement, 'ReduxActions');

bool needsGen(ClassElement classElement, String type) =>
    classElement.allSupertypes.any((interfaceType) => interfaceType.name == type) &&
    !classElement.displayName.startsWith('_\$');

generateActions(ClassElement element) {
  var initializerCode =
      "class _\$${element.name} extends ${element.name}{\nfactory _\$${element.name}() => new _\$${element.name}._();\n_\$${element.name}._() : super._();\nsyncWithStore(dispatcher);\n}";
  var nameCode = "class ${element.name}Names {\n\n}";
  var syncWithStoreCode = 'syncWithStore(dispatcher) {\n\n}';
  for (var e in element.fields) {
    var fieldName = e.name;
    var ele = e.type.element;
    var typeName = ele.name;

    if (ele is ClassElement && typeName == 'ActionDispatcher') {
      nameCode = nameCode.replaceFirst(
        '\n',
        '\nstatic ActionName $fieldName = new ActionName<${_getActionDispatcherGenericType(e)}>(\'${element.name}-$fieldName\');\n',
      );

      var actionDispatcher =
          '\n${e.toString()} = new ActionDispatcher<${_getActionDispatcherGenericType(e)}>(\'${element.name}-$fieldName\');\n';
      if (!actionDispatcher.startsWith('\nfinal')) actionDispatcher = '\nfinal $actionDispatcher';
      initializerCode = initializerCode.replaceFirst('\n', actionDispatcher);
      syncWithStoreCode =
          syncWithStoreCode.replaceFirst('\n', '\n$fieldName.syncWithStore(dispatcher);');
    } else if (ele is ClassElement && needsReduxActions(ele)) {
      initializerCode = initializerCode.replaceFirst('\n', '${e.toString()} = new $typeName();');
      syncWithStoreCode =
          syncWithStoreCode.replaceFirst('\n', '\n$fieldName.syncWithStore(dispatcher);');
    }
  }
  initializerCode = initializerCode.replaceFirst('syncWithStore(dispatcher);', syncWithStoreCode);
  return '$initializerCode\n\n$nameCode';
}

// TODO: find a better way
_getActionDispatcherGenericType(FieldElement e) => e.toString().substring(
      e.toString().indexOf('<') + 1,
      e.toString().indexOf('>'),
    );
