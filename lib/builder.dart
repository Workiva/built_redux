import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

Builder builtRedux(BuilderOptions _) => new SharedPartBuilder([
      new BuiltReduxGenerator(),
    ], 'built_redux');
