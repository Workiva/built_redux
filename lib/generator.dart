import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Generator for Enum Class and Built Values.
///
/// See https://github.com/google/built_value.dart/tree/master/example
class BuiltReduxGenerator extends Generator {
  @override
  Future<String> generate(Element element, BuildStep buildStep) async {
    if (element is ClassElement && needsReduxActions(element)) {
      log.info('Generating action classes for ${element.name}');
      return generateActions(element);
      //   print(element.source);
      // var unit = element.computeNode();
      // var name = element.name;
      //   // unit..fields.removeWhere((field) => field.name == 'reducer');
      //   // unit.members.removeWhere((m) => m.element.name);
      //   // for (ClassMember m in cd.members) {
      //   //   if (m is! MethodDeclaration) continue;
      //   //   var md = m as MethodDeclaration;
      //   //   if (!md.isGetter || md.returnType == null) continue;
      //   //   if (md.name =)
      //   // }
      //   // var reducerGetter = unit.getField("reducer").toSource();
      //   // reducerGetter.beginToken.
      // var source = unit.toSource();
      // return source.replaceRange(
      //   source.length - 3,
      //   source.length - 2,
      //   generateReduceChildren(element),
      // );
      // return unit
      //     .toSource()
      //     .replaceFirst(name, '_\$$name extends $name')
      //     .replaceFirst("extends BltReducer", "implements Built")
      //     .replaceFirst(
      //       unit.getMethod("reducers").toSource(),
      //       "", //generateReduceChildren(element),
      //     );
    }

    return null;
  }
}

bool needsBuiltRedux(ClassElement classElement) => needsGen(classElement, 'BltReducer');

bool needsReduxActions(ClassElement classElement) => needsGen(classElement, 'ReduxActions');
//
bool needsGen(ClassElement classElement, String type) =>
    classElement.allSupertypes.any((interfaceType) => interfaceType.name == type) &&
    !classElement.displayName.startsWith('_\$');

String generateReduceChildren(ClassElement element) {
  String reduceChildrenBody =
      "\n\n  @override\n  reduceChildren(dynamic b, Action<dynamic> a) {\n  }";

  for (var e in element.fields) {
    var ele = e.type.element;
    if (ele is ClassElement && needsGen(ele, 'BltReducer')) {
      reduceChildrenBody =
          reduceChildrenBody.replaceFirst("{", "{\n    ${e.name}.reduce(b.${e.name}, a);");
    }
  }

  return reduceChildrenBody;
}

generateActions(ClassElement element) {
  var initializerCode =
      "class _\$${element.name} extends ${element.name}{\nfactory _\$${element.name}() => new _\$${element.name}._();\n_\$${element.name}._() : super._();\nsyncWithStore(dispatcher);\n}";
  var nameCode = "class ${element.name}Names {\n\n}";
  var syncWithStoreCode = 'syncWithStore(dispatcher) {\n\n}';
  for (var e in element.fields) {
    var fieldName = e.name;
    var ele = e.type.element;
    var typeName = ele.name;

    if (ele is ClassElement && typeName == 'ActionMgr') {
      // log.shout(_getGenericBounds(e));
      nameCode = nameCode.replaceFirst(
        '\n',
        '\nstatic ActionName $fieldName = new ActionName<${_getActionMgrGenericType(e)}>(\'$fieldName\');\n',
      );

      var actionMgr =
          '\n${e.toString()} = new ActionMgr<${_getActionMgrGenericType(e)}>(\'$fieldName\');\n';
      if (!actionMgr.startsWith('\nfinal')) actionMgr = '\nfinal $actionMgr';
      initializerCode = initializerCode.replaceFirst('\n', actionMgr);
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
  // for (ClassMember m in cd.members) {
  //   if (m is! FieldDeclaration) continue;
  //   var v = m as FieldDeclaration;
  //
  //   // TODO: make actions final if they are not already
  //   if (v.fields.type == null) continue;
  //
  //   var returnType = v.fields.type.name.name;
  //   var name = v.fields.variables.first.name.name;
  //
  //   if (returnType == 'ActionMgr') {
  //     transformedFile.insert(
  //       transformedFile.sourceFile.location(v.endToken.previous.end),
  //       " = new ActionMgr('${cd.name}-$name')",
  //     );
  //     initializerCode += '$name.syncWithStore(dispatcher),\n    ';
  //   } else {
  //     initializerCode += '$name = new ${returnType}(dispatcher),\n    ';
  //   }
  // }
  //
  // transformedFile.insert(
  //   transformedFile.sourceFile.location(cd.getConstructor(null).separator.end),
  //   initializerCode,
  // );
}

// TODO: find a better way
_getActionMgrGenericType(FieldElement e) => e.toString().substring(
      e.toString().indexOf('<') + 1,
      e.toString().indexOf('>'),
    );
