# Setup

built_value and built_redux both rely on build_runner for code generation.

1. Add the `built_redux` package as a dependency in your `pubspec.yaml`.
  
  ```yaml
  dependencies:
    built_redux: ^7.4.5
    built_value: '>=6.8.2 <8.0.0'
  dev_dependencies:
    build_runner: ^0.9.0
    built_value_generator: ^6.0.0
  ```

2. Use build runner to build the generated files by executing `pub run build_runner build`
