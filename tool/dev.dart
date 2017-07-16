library tool.dev;

import 'package:dart_dev/dart_dev.dart' show dev, config;

main(List<String> args) async {
  const directories = const <String>[
    'lib/',
    'lib/src/',
    'test/unit/',
  ];

  config.format..lineLength = 100;

  config.analyze
    ..strong = true
    ..fatalWarnings = false
    ..entryPoints = directories;

  config.test
    ..concurrency = 1
    ..unitTests = [
      'test/unit/',
    ];

  config.coverage
    ..html = true
    ..reportOn = ['lib/'];

  await dev(args);
}
