import 'package:barback/barback.dart';
import 'package:analyzer/analyzer.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';
import 'dart:async';
import 'dart:io';

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

      var superclass = cd.extendsClause?.superclass;
      if (superclass == null) continue;
      var name = superclass.name.name;
      if (name == 'BuiltReducer') {
        String reduceChildrenBody =
            "\n\n  @override\n  reduceChildren(dynamic state, Action<dynamic> a, dynamic builder) {\n }";

        for (ClassMember m in cd.members) {
          if (m is! MethodDeclaration) continue;
          var md = m as MethodDeclaration;

          if (!md.isGetter || md.returnType == null) continue;

          if (builtReducers.contains(md.returnType.name.name))
            reduceChildrenBody = reduceChildrenBody.replaceFirst(
                "{", "{\n    ${md.name}.reduce(state.${md.name}, a, builder.${md.name});");
        }

        transformedFile.insert(
            transformedFile.sourceFile.location(cd.members.endToken.end), reduceChildrenBody);
      }
    }

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

Iterable<String> getBuiltReducers() {
  var builtReducers = ['BuiltReducer'];

  Directory libBase = new Directory(p.url.join(Directory.current.path, 'lib'));
  var files = libBase.listSync(recursive: true);
  Directory testBase = new Directory(p.url.join(Directory.current.path, 'test'));
  files.addAll(testBase.listSync(recursive: true));
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

bool importsBuiltReducer(String source) => source.contains("package:built_redux");
