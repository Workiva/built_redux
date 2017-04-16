import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:built_redux/generator.dart';

/// Build the generated files in the built_value chat example.
Future main(List<String> args) async {
  await build(
      new PhaseGroup.singleAction(
          new GeneratorBuilder([
            new BuiltValueGenerator(),
            new BuiltReduxGenerator(),
          ]),
          new InputSet('example', const ['lib/**/*.dart'])),
      deleteFilesByDefault: true);
}
