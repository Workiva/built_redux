import 'package:barback/barback.dart';
import 'package:analyzer/analyzer.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';

import 'dart:async';
import 'dart:io';

final Iterable<String> builtCollectionNames = [
  "BuiltList",
  "BuiltMap",
  "BuiltSet",
];

class BuiltStoreTransformer extends Transformer {
  final BarbackSettings _settings;
  BuiltStoreTransformer.asPlugin(this._settings);

  @override
  String get allowedExtensions => ".dart";

  /// Converts [id] to a "package:" URI.
  ///
  /// This will return a schemeless URI if [id] doesn't represent a library in
  /// `lib/`.
  static Uri idToPackageUri(AssetId id) {
    if (!id.path.startsWith('lib/')) {
      return new Uri(path: id.path);
    }

    return new Uri(
        scheme: 'package', path: p.url.join(id.package, id.path.replaceFirst('lib/', '')));
  }

  @override
  Future apply(Transform transform) async {
    var primaryInputContents = await transform.primaryInput.readAsString();
    var builtReducers = getBuiltReducers();

    SourceFile sourceFile = new SourceFile(
      primaryInputContents,
      url: idToPackageUri(transform.primaryInput.id),
    );

    TransformedSourceFile transformedFile = new TransformedSourceFile(sourceFile);

    // Do not try to transform the source if it doesn't import built_redux
    if (!importsBuiltReducer(primaryInputContents)) return;

    // Parse the source file on its own and use the resultant AST to...
    var unit = parseCompilationUnit(
      primaryInputContents,
      suppressErrors: true,
      name: transform.primaryInput.id.path,
      parseFunctionBodies: false,
    );
    for (CompilationUnitMember d in unit.declarations) {
      if (d is! ClassDeclaration) continue;
      var cd = d as ClassDeclaration;

      // var metadatas = cd.metadata.map((e) => e.name.name);
      // print("metas are $metadatas");
      // if (metadatas.contains('ReduxActions')) generateActions(transformedFile, cd);

      var superclass = cd.extendsClause?.superclass;
      if (superclass == null) continue;
      var name = superclass.name.name;
      if (name == 'ReduxActions') generateActions(transformedFile, cd);
      if (name == 'BuiltReducer') {
        String reduceChildrenBody =
            "\n\n  @override\n  reduceChildren(dynamic b, Action<dynamic> a) {\n  }";

        for (ClassMember m in cd.members) {
          if (m is! MethodDeclaration) continue;
          var md = m as MethodDeclaration;

          if (!md.isGetter || md.returnType == null) continue;

          if (builtReducers.contains(md.returnType.name.name))
            reduceChildrenBody =
                reduceChildrenBody.replaceFirst("{", "{\n    ${md.name}.reduce(b.${md.name}, a);");

          // if (md.returnType.typeArguments != null &&
          //     md.returnType.typeArguments.arguments != null &&
          //     md.returnType.typeArguments.arguments.length > 0 &&
          //     isBuiltReducer(
          //       md.returnType.typeArguments.arguments.first.name.name,
          //       unit.declarations,
          //     )) {
          //   print("IS BUILT ${md.returnType.typeArguments.arguments.first.name.name}");
          // var element = md.returnType.typeArguments.arguments.first.type.element;
          // if (element is ClassElement) {
          //   var x = element as ClassElement;
          //   print(x.allSupertypes);
          // }
          // }
          // print(md.returnType.typeArguments.arguments.elementAt(0).type.isSubtypeOf(BuiltReducer));

          // if (builtCollectionNames.contains(md.returnType.name.name))
          //   reduceChildrenBody = reduceChildrenBody.replaceFirst(
          //       "{", "{\n    ${md.name}.forEach((k,v) => v.reduce(a));");
        }

        transformedFile.insert(
            transformedFile.sourceFile.location(cd.members.endToken.end), reduceChildrenBody);
      }
    }
    print(transformedFile.getTransformedText());
    if (transformedFile.isModified) {
      // Output the transformed source.

      transform.addOutput(
          new Asset.fromString(transform.primaryInput.id, transformedFile.getTransformedText()));
    } else {
      // Output the unmodified input.
      transform.addOutput(transform.primaryInput);
    }
  }
}

generateActions(TransformedSourceFile transformedFile, ClassDeclaration cd) {
  var initializerCode = "\n    ";
  for (ClassMember m in cd.members) {
    if (m is! FieldDeclaration) continue;
    var v = m as FieldDeclaration;

    // TODO: make actions final if they are not already
    if (v.fields.type == null) continue;

    var returnType = v.fields.type.name.name;
    var name = v.fields.variables.first.name.name;

    if (returnType == 'ActionMgr') {
      transformedFile.insert(
        transformedFile.sourceFile.location(v.endToken.previous.end),
        " = new ActionMgr('${cd.name}-$name')",
      );
      initializerCode += '$name.syncWithStore(dispatcher),\n    ';
    } else {
      initializerCode += '$name = new ${returnType}(dispatcher),\n    ';
    }
  }

  transformedFile.insert(
    transformedFile.sourceFile.location(cd.getConstructor(null).separator.end),
    initializerCode,
  );
}

Iterable<String> getBuiltReducers() {
  var builtReducers = ['BuiltReducer'];

  Directory base = new Directory(p.url.join(Directory.current.path, 'lib'));
  var files = base.listSync(recursive: true);
  for (var f in files) {
    if (f is! File) continue;

    var unit = parseCompilationUnit(
      new File(f.path).readAsStringSync(),
      suppressErrors: true,
      parseFunctionBodies: false,
    );

    for (CompilationUnitMember d in unit.declarations) {
      if (d is! ClassDeclaration) continue;
      var cd = d as ClassDeclaration;
      var superclass = cd.extendsClause?.superclass;
      if (superclass == null) continue;
      var name = superclass.name.name;
      if (name == 'BuiltReducer') builtReducers.add(cd.name.name);
    }
  }
  return builtReducers;
}

absoluteToPackage(String path) {
  List<String> parts = path.split('/');
  final int idxOfLib = parts.indexOf('lib');
  final String beforeLib = parts[idxOfLib - 1];
  var rest = "";
  for (int i = idxOfLib + 1; i < parts.length; i++) rest += '/${parts[i]}';
  return new Uri(scheme: 'package', path: '${beforeLib}${rest}');
}

// Uri idToPackageUri(String filePath) {
//   print('path is ${filePath}');
//   if (!id.path.startsWith('lib/')) {
//     return new Uri(path: id.path);
//   }
//
//
//   return new Uri(
//       scheme: 'package', path: p.url.join(id.package, id.path.replaceFirst('lib/', '')));
// }

// Uri uriBase(AssetId id) {
//   if (!id.path.startsWith('lib/')) {
//     return new Uri(path: id.path.sp);
//   }
//
//   return new Uri(scheme: 'package', path: p.url.join(id.package, id.path.replaceFirst('lib/', '')));
// }

// bool isBuiltReducer(String name, NodeList<CompilationUnitMember> declarations) {
//   for (CompilationUnitMember d in declarations) {
//     if (d is! ClassDeclaration) continue;
//     var cd = d as ClassDeclaration;
//
//     if (cd.name.name != name) continue;
//     if (cd.implementsClause == null || cd.implementsClause.interfaces == null) return false;
//
//     for (TypeName tn in cd.implementsClause.interfaces)
//       if (tn.name.name == 'BuiltReducer') return true;
//   }
//
//   return false;
// }

bool importsBuiltReducer(String source) => source.contains("package:built_redux");
