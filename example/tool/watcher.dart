import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Start a watcher that automatically builds the generated files in the
/// built_value chat example on changes.
Future main(List<String> args) async {
  watch(
      new PhaseGroup.singleAction(
          new GeneratorBuilder([
            new BuiltValueGenerator(),
          ]),
          new InputSet('example', const ['lib/reducers/*.dart'])),
      deleteFilesByDefault: true);
}
