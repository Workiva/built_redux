# Setup

built_value and built_redux both rely on build_runner for code generation.

1. Add the `built_redux` package as a dependency in your `pubspec.yaml`.
  
  ```yaml
  dependencies:
    built_redux: 8.0.0-dev.0
    built_value: ^5.2.0
  dev_dependencies:
    build_runner: ^0.7.9
    built_value_generator: ^5.2.0
  ```

2. add a build.yaml to the root of your repo that contains the following:

  ```yaml
  targets:
    $default:
      builders:
        built_value_generator|built_value:
          enabled: false
  ```

3. Use build runner to build the generated files by executing `pub run build_runner build`
