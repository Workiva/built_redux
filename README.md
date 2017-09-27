# built_redux

[![Pub](https://img.shields.io/pub/v/built_redux.svg)](https://pub.dartlang.org/packages/built_redux)
[![codecov.io](http://codecov.io/github/davidmarne/built_redux/coverage.svg?branch=master)](http://codecov.io/github/davidmarne/built_redux?branch=master)

built_redux is a state management library written in dart that enforces immutability.
built_redux is not only an implementation of [redux][redux_git], but also a framework for building middleware and reducers in a type safe manner.

Inspired by [redux][redux_git]

Built using [built_value][built_value_git]

## Framework bindings & examples

[flutter][flutter]

[react-dart][react-dart]

[angular2][angular2]

## Using it in your project

> __If you are not familiar with Redux or built_value__
>
> Since built_redux follows the same architecture as redux we encourage you to
> gain familiarity with it by reading [the redux docs][redux_docs].
>
> Since built_redux requires the use of built_value we encourage you to
> gain familiarity with it by reading [this blog post][built_value_blog].

1. Add the `built_redux` package as a dependency in your `pubspec.yaml`.

  ```yaml
  dependencies:
    built_redux: "^6.0.0"
  ```

2. Create a script to run generators for generating built_values and built_redux action classes.
  ```dart
  import 'dart:async';

  import 'package:build_runner/build_runner.dart';
  import 'package:built_value_generator/built_value_generator.dart';
  import 'package:source_gen/source_gen.dart';
  import 'package:built_redux/generator.dart';

  /// Build the generated files in the built_value chat example.
  Future main(List<String> args) async {
    await build([
      new BuildAction(
          new PartBuilder([
            new BuiltValueGenerator(),
            new BuiltReduxGenerator(),
          ]),
          'built_redux',
          inputs: const ['test/unit/test_counter.dart'])
    ], deleteFilesByDefault: true);
  }
  ```

3. Run the build script from the command line to generate your built_values and built_redux action classes
  ```dart tool/build.dart```

### Writing a built_redux store

```dart
import 'package:built_redux/built_redux.dart';

 // This is a an implementation of ReduxActions. Actions are what middleware and ui
 // components invoke a change to the redux store's state. By extending ReduxActions
 // the built_redux generator will generate the required boilerplate to create
 // each action and an ActionNames class.
  abstract class CounterActions extends ReduxActions {
   ActionDispatcher<int> increment;
   ActionDispatcher<int> decrement;

   // factory to create on instance of the generated implementation of CounterActions
   CounterActions._();
   factory CounterActions() => new _$CounterActions();
 }

  // This is a built value. It is an immutable model that implements the Built interface.
  // All of the state in your redux store is contained in a single built value model.
  abstract class Counter {
   /// [count] value of the counter
   int get count;

   // Built value constructor. The factory is returning the default state
   Counter._();
   factory BaseCounter() => new _$BaseCounter._(count: 1);
 }


// These are reducer functions. They have a (state, action, builder) => void signature.
// They describes how an action transforms the state into the next state by applying changes to the builder supplied.
// You are required to use the builder passed, calling state.rebuild will NOT update the state in your redux store.
increment(Counter state, Action<int> action, CounterBuilder builder) =>
  builder.count = state.count + action.payload;

decrement(Counter state, Action<int> action, CounterBuilder builder) =>
  builder.count = state.count - action.payload;

 // This is a reducer builder. Use of ReducerBuilder is not required, however it
 // is strongly recommended as it gives you static type checking to make sure
 // the payload for action name provided is the same as the expected payload
 // for the action provided to your reducer. Calling .build() returns a reducer function
 // that can be passed to our store.
 var reducer =  (new ReducerBuilder<Counter, CounterBuilder>()
      ..add(CounterActionsNames.increment, increment)
      ..add(CounterActionsNames.decrement, decrement)).build();

// Create a Redux store holding the state of your app.
// Its API contains three getters: stream, state, and actions.
var store = new Store<Counter, CounterBuilder, CounterActions>(
  reducer,
  new Counter(),
  new CounterActions(),
);

// You can use stream.listen() to update the UI in response to state changes.
store.stream.listen((_) => print(store.state.count));

// The only way to mutate the internal state is to dispatch an action.
store.actions.increment(1);
// 1
store.actions.increment(2);
// 3
store.actions.decrement(1);
// 2
```

### Nested Reducers

Nested reducers can be built to handle rebuilding built values that are
nesting within the main model. This is nice for organization and scoping actions to a specific peice of your application's state.

```dart
// the main model
abstract class BaseCounter implements Built<BaseCounter, BaseCounterBuilder> {
  int get count;

  // Also a built_value
  NestedCounter get nestedCounter;

  // Built value constructor. The factory is returning the default state
  BaseCounter._();
  factory BaseCounter() => new _$BaseCounter._(
    count: 1,
    nestedCounter: new NestedCounter(),
  );
}

// the nested model
abstract class NestedCounter implements Built<NestedCounter, NestedCounterBuilder> {
  int get count;

  // Built value constructor. The factory is returning the default state
  NestedCounter._();
  factory NestedCounter() => new _$NestedCounter._(
    count: 1,
  );
}

// create a nested reducer builder
final nestedReducer = new NestedReducerBuilder<BaseCounter, BaseCounterBuilder,
    NestedCounter, NestedCounterBuilder>(
  (state) => state.nestedCounter, // maps the app state to the nested state
  (builder) => builder.nestedCounter, // maps the app builder to the nested builder
)..add(NestedCounterActionsNames.increment, _nestedIncrement);

// actions registered only rebuild the nested state
// notice the state and builder types are of NestedCounter and NestedCounterBuilder
_nestedIncrement(NestedCounter state, Action<int> action, NestedCounterBuilder builder) =>
  builder.count = state.count + action.payload;

// now use ReducerBuilder.addNestedReducer to add it to your main reducer
var reducer = (new ReducerBuilder<Counter, CounterBuilder>()
      ..add(CounterActionsNames.increment, increment)
      ..add(CounterActionsNames.decrement, decrement)
      ..addNestedReducer(nestedReducer)).build();

```

Nested actions can also be used to help organize actions for nested reducers. First define your actions:

```dart
abstract class NestedActions extends ReduxActions {
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;

  // factory to create on instance of the generated implementation of NestedActions
  NestedActions._();
  factory NestedActions() => new _$NestedActions();
}
```

Then add them to your main action class like so:

```dart
abstract class CounterActions extends ReduxActions {
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;

  NestedActions nestedActions;

  // factory to create on instance of the generated implementation of CounterActions
  CounterActions._();
  factory CounterActions() => new _$CounterActions();
}
```

Check the usage:

```dart
// only print the nested counter's count
store.stream.listen((_) => print(store.state.nestedCounter.count));

// The only way to mutate the internal state is to dispatch an action.
store.actions.nestedActions.increment(1);
// 1
store.actions.increment(2);
// 1
```

### Writing middleware

```dart
 // Define specific actions to be handled by this middleware
 // A middleware can also listen to and perform side effects on any actions defined elsewhere
 abstract class DoubleAction extends ReduxActions {
  ActionDispatcher<int> increment;

  DoubleAction._();
  factory DoubleAction() => new _$DoubleAction();
}

 // This is a middleware builder. Use of MiddlewareBuilder is not required, however
 // just like ReducerBuilder it is strongly recommended as it gives you static type checking to make sure
 // the payload for action name provided is the same as the expected payload
 // for the action provided to your reducer. It will also call next(action) for you
 // if an action not handled by this middleware is received. Calling .build() returns the
 // middleware function that can be passed to your store at instantiation.
 var doubleMiddleware =  (new MiddlewareBuilder<Counter, CounterBuilder, CounterActions>()
      ..add(DoubleActionNames.increment, _doubleIt)).build();

_doubleIt(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<int> action) {
  api.actions.increment(action.payload * 2);
}
```

You will notice that MiddlewareBuilder's generics are Counter and CounterActions.
These are the same types as the defaultState and actions classes passed when
the store was instantiated. In order for DoubleActions to be handled by redux
you must add it to definition of CounterActions like so

```dart
abstract class CounterActions extends ReduxActions {
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;

  DoubleActions doublerActions;

  // factory to create on instance of the generated implementation of CounterActions
  CounterActions._();
  factory CounterActions() => new _$CounterActions();
}
```

Check the usage after adding this middleware

```dart
// Create a Redux store holding the state of your app.
// Its API is subscribe, state, actions.
var store = new Store<Counter, CounterBuilder, CounterActions>(
  new Counter(),
  new CounterActions(),
  middleware: [doubleMiddleware],
);

store.stream.listen((_) => print(store.state.count));

// The only way to mutate the internal state is to dispatch an action.
store.actions.increment(1);
// 1
store.actions.doublerActions.increment(2);
// 5
store.actions.decrement(1);
// 4
```

A middleware can also be defined without using a MiddlewareBuilder to execute a function for all actions. For example, the following middleware logs every action dispatched as well the the state after the action was handled:

```dart
NextActionHandler loggingMiddleware(MiddlewareApi<Counter, CounterBuilder, CounterActions> api) =>
    (ActionHandler next) => (Action action) {
          next(action);
          print("Action: ${action.name}");
          print("Payload: ${action.payload}");
          print("Next State: ${api.state}");
        };
```

### Observing substate

Streams can easily be accessed to observe any piece of your state tree by passing a mapper the store's
substateStream function. For example, say I only care about BaseCounter.count
in the previous example and I do not want to be notified when BaseCounter.nestedCounter changes.
I can create a stream that will only emit an event when BaseCounter.count changes, as so:

```dart
final countStream = store.substateStream<int>((BaseCounter state) => state.count);

countStream.listen((change) => print('prev: ${change.prev}, next: ${change.next}'));

store.actions.increment(1);
// prev: 1, next: 2
store.actions.nestedCounter.increment(2);
// nothing logged

```

[built_value_blog]: https://medium.com/dartlang/darts-built-value-for-immutable-object-models-83e2497922d4

[built_value_git]: https://github.com/google/built_value.dart/

[redux_git]: https://github.com/reactjs/redux

[redux_docs]: http://redux.js.org/

[react-dart]: https://github.com/davidmarne/react_built_redux

[flutter]: https://github.com/davidmarne/flutter_built_redux

[angular2]: https://github.com/davidmarne/angular_built_redux

[flutter_built_redux]: https://github.com/davidmarne/flutter_built_redux
