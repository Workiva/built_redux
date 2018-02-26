# Setup

built_value and built_redux both rely on code generation.

1. Add the `built_redux` package as a dependency in your `pubspec.yaml`.
  ```yaml
  dependencies:
    built_redux: ^7.0.0
    built_value: ^5.0.0
  dev_dependencies:
    build_runner: ^0.6.0
    built_value_generator: '>=4.1.0 < 6.0.0'
    source_gen: ^0.7.0
  ```

2. Create a script to run generators for generating built_values and built_redux action classes.
  ```dart
  import 'dart:async';

  import 'package:build_runner/build_runner.dart';
  import 'package:built_value_generator/built_value_generator.dart';
  import 'package:source_gen/source_gen.dart';
  import 'package:built_redux/generator.dart';

  Future main(List<String> args) async {
    await build([
      new BuildAction(
          new PartBuilder([
            new BuiltValueGenerator(),
            new BuiltReduxGenerator(),
          ]),
          // your lib name here
          'built_redux',
          // tweak the files that invoke the generator here
          inputs: const ['lib/**/*.dart'])
    ], deleteFilesByDefault: true);
  }
  ```

3. Run the build script from the command line to generate your built_values and built_redux action classes by running `dart [build script name].dart`
