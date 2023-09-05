## 8.0.4
* open analyzer range to 5

## 8.0.3
* reopen analyzer range

## 8.0.2
* only use nndb in generator if nndb feature is enabled. prevents build issues for non nndb consumers

## 8.0.1
* updated analyzer range to allow 2.x.x
* add gh action workflow

## 8.0.0
* updated analyzer, source_gen, build, build_test dependency ranges
* fix nnbd issues in generator
* set sdk range lower bound to 2.12.0
  
## 8.0.0-nullsafety.0
* add tests that generate actions with nullable generics
* fixed issue where ++ does not work on builder value
* address deprecations in generator
* **Breaking changes**:
  * The argements to `ActionDispatcher.call` are no longer optional. when dispatching an action a payload a value must be provided. if the payload type is nullable null must be explicitly provided. append a `?` to the `ActionDispatcher` type parameter for any actions that can be dispatched with a null payload, e.g. `ActionDispatcher<int?>`.
  * Remove previously deprecated test method

## 7.5.11
* allow analyzer 0.39.0
* make dispatcher name public
* fix documentation typo

## 7.5.10
* add workiva_analysis_options
* remove usage of new keyword in code and examples
* bump various dependencies lower bounds

## 7.5.9
* add type_annotate_public_apis lint ignore to generated files

## 7.5.8

* rework generator to lift analyzer version constraint.
* open analyzer range
* generator now uses source parsing to resolve action generic types which allows any unresolved type to be used as an action payload.
* generated actions classes now use type inference.
* bump built_value lower bound to 6.1.4 since it is impossible for pub to resolve to anything lower due to the build dependency constraint.

## 7.5.7
open built value range
restrict analyzer to less than 0.38.3, issue was introduced in 0.38.3 patch

## 7.5.6
add dart2js:noInline annotations

## 7.5.5
update analyzer dependency to allow '>=0.33.0 <0.39.0'

## 7.5.4
update analyzer dependency to allow '>=0.33.0 <0.37.0'
fix type in built_redux_test_utils.dart

## 7.5.3
update analyzer dependency to allow '>=0.33.0 <0.36.0'

## 7.5.2
update analyzer dependency to allow ^0.33.0

## 7.5.1
update build dependencies

## 7.5.0

* allow 4.x.x of built_collection
* added combineReducerBuilder to NestedReducerBuilder
* added a NestedMiddlewareBuilder

## 7.4.5

* open sdk range to dart 2!
* update built_value and source_gen dependencies
* use SharedPartBuilder rather than PartBuilder in the generator

## 7.4.4-dev

* use typedef names in action generator

## 7.4.3-dev

* update dependency range on analyzer
* update dependency range on test
* fix broken test caused by dart 2's new asyc behavior

## 7.4.2

* add lint ignores to generated files

## 7.4.1-dev

* open sourc-gen range
* run tests on the dev compiler

## 7.4.1

* fix cast issues around store changes in dart 2
* open analyzer version range

## 7.4.0-dev

* add build.yaml and build.dart to comply with build_runner 0.7.x

With the dev tag you can consume the latest versions of built_value, build, and build_runner that are only compatable with dart 2.

In order to migrate:

* remove your old build scripts
* update your pubspec to include

```yaml
  build_runner: ^0.7.9
```

* add a build.yaml to the root of your repo that contains the following:

```yaml
targets:
  $default:
    builders:
      built_value_generator|built_value:
        enabled: false
```

* run `pub run build_runner build`.

The build script is only a temporary measure until https://github.com/dart-lang/source_gen/issues/319 is resolved.


## 7.4.0

* add built_redux_test_utils library - exposes an expectDispatched function for expecting a given action gets dispatched asynchronously
* add combine to MiddlewareBuilder class - lets you combine middleware builders
* add toString to Action class
* add example
* add docs

## 7.3.3

* add changelog
* update readme to include link to todoMVC repo

## 7.3.2

* open dependency range on the build package

## 7.3.1

* open dependency range on the built_collection package

## 7.3.0

* dispose is now awaitable

## 7.2.0

* Added actionStream stream to the store api so one can listen to changes resulting from a specific action name.
* Fixed issues called out my adding implicit-dynamic and implicit-cast rules.

## 7.1.0

* Added reducer builders for all collection types in built_collection. This means you can now write reducers that rebuild just a collection. Examples: https://github.com/davidmarne/built_redux/blob/master/test/unit/collection_models.dart
* The action generator now supports inheritance, meaning one can now have action classes extend one another. AbstractReducerBuilder was added as means of merging a reducer builder defined to rebuild the abstract pieces of state. Examples: https://github.com/davidmarne/built_redux/blob/7.1.0/test/unit/inheritance_test_models.dart for examples

## 7.0.0

* **Breaking changes**:
  * A breaking change in behavior was made to action dispatchers. Before action dispatchers executed the middleware/reducers asynchronously, but they now execute synchronously.

For example you may have:

```dart
int getCount(store) {
  print(store.state.count); // prints 0
  store.actions.increment(1);
  print(store.state.count); // would print 1 if actions were sync, 0 if async
  return store.state.count; // would return 1 if actions were sync, 0 if async
}
```

Before this function would return 0 because the state update that occurs from actions.increment would be processed in a future task.
Now this function will return 1 because the state update that occurs from actions.increment is processed in the current task

## 6.0.0

Removes the BuiltReducer interface and the generated BuiltReducer implementation in favor of building a reducer function and passing it to the store at instantiation.

* **Breaking changes**:
  * Store now takes a reducer
  * Nested reducers need to be built with the NestedReducerBuilder and merged wth the main ReducerBuilder using ReducerBuilder.addNestedReducer
  * Models no longer implement BuiltReducer
    * Remove references to the reducer on your models
  * Renamed ActionDispatcher.syncWithStore to setDispatcher
  * Renamed SubStateChange to SubstateChange


Reasoning:

* Decouples your models and reducers.
* Requires less generated code.
* Reducing requires less map look ups. Previously N map look ups were required where N was the number of BuiltReducers in your state tree. Now only 1 map look up is required per action dispatched.


Examples:

* Example model change. Remove the generated BuiltReducer mixin and the reducer getter

Before:

```dart
  abstract class Counter extends Object
     with CounterReducer
     implements Built<Counter, CounterBuilder> {
   int get count;

   get reducer => _reducer;

   Counter._();
   factory BaseCounter() => new _$BaseCounter._(count: 1);
 }
```

After:

```dart
  abstract class Counter implements Built<Counter, CounterBuilder> {
   int get count;

   Counter._();
   factory BaseCounter() => new _$BaseCounter._(count: 1);
 }
```

* Example nested reducer change. Change NestedCounter's reducer builder to a NestedReducerBuilder. Pass the NestedReducerBuilder mapper functions from the main state/builder to the nested state/builder.

Before

```dart

// Built Reducer
abstract class BaseCounter extends Object
    with BaseCounterReducer
    implements Built<BaseCounter, BaseCounterBuilder> {
  int get count;

  BuiltList<int> get indexOutOfRangeList;

  NestedCounter get nestedCounter;

  @override
  get reducer => _baseReducer;

  // Built value constructor
  BaseCounter._();
  factory BaseCounter() => new _$BaseCounter._(
        count: 1,
        nestedCounter: new NestedCounter(),
      );
}

final _baseReducer = (new ReducerBuilder<BaseCounter, BaseCounterBuilder>()
      ..add(BaseCounterActionsNames.increment, _baseIncrement)
      ..add(BaseCounterActionsNames.decrement, _baseDecrement))
    .build();

abstract class NestedCounter extends Object
    with NestedCounterReducer
    implements Built<NestedCounter, NestedCounterBuilder> {
  int get count;

  get reducer => _nestedReducer;

  // Built value constructor
  NestedCounter._();
  factory NestedCounter() => new _$NestedCounter._(count: 1);
}

final _nestedReducer =  (new ReducerBuilder<NestedCounter, NestedCounterBuilder>()
          ..add(NestedCounterActionsNames.increment, _nestedIncrement)
          ..add(NestedCounterActionsNames.decrement, _nestedDecrement))
        .build();

```

After

```dart
abstract class BaseCounter implements Built<BaseCounter, BaseCounterBuilder> {
  int get count;

  NestedCounter get nestedCounter;

  BaseCounter._();
  factory BaseCounter() => new _$BaseCounter._(
        count: 1,
        nestedCounter: new NestedCounter(),
      );
}

// the reducer passed to the store
final reducer = (new ReducerBuilder<BaseCounter, BaseCounterBuilder>()
      ..add(BaseCounterActionsNames.increment, _baseIncrement)
      ..add(BaseCounterActionsNames.decrement, _baseDecrement)
      ..combineNested(_nestedReducer))
    .build();

abstract class NestedCounter implements Built<NestedCounter, NestedCounterBuilder> {
  int get count;

  // Built value constructor
  NestedCounter._();
  factory NestedCounter() => new _$NestedCounter._(count: 1);
}

final _nestedReducer = new NestedReducerBuilder<BaseCounter, BaseCounterBuilder,
    NestedCounter, NestedCounterBuilder>(
  (state) => state.nestedCounter,
  (builder) => builder.nestedCounter,
)
  ..add(NestedCounterActionsNames.increment, _nestedIncrement)
  ..add(NestedCounterActionsNames.decrement, _nestedDecrement);
```