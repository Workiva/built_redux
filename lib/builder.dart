import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

Builder builtRedux(BuilderOptions options) => new PartBuilder([
      new BuiltReduxGenerator(),
    ],
        generatedExtension: '.built_redux.g.dart',
        requireLibraryDirective: false);
