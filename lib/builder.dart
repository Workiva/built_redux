import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:built_value_generator/built_value_generator.dart';

import 'generator.dart';

Builder builtRedux(BuilderOptions options) => new PartBuilder([
      new BuiltReduxGenerator(),
      new BuiltValueGenerator(),
    ],
        generatedExtension: '.g.dart',
        header: options.config['header'] as String);
