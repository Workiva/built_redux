# built_redux

[![Pub](https://img.shields.io/pub/v/built_redux.svg)](https://pub.dartlang.org/packages/built_redux)
[![codecov.io](http://codecov.io/github/davidmarne/built_redux/coverage.svg?branch=master)](http://codecov.io/github/davidmarne/built_redux?branch=master)

built_redux is a state management library written in dart that enforces immutability.
built_redux is not only an implementation of [redux][redux_git], but also a framework for building middleware and reducers in a type safe manner.

Inspired by [redux][redux_git]

Built using [built_value][built_value_git]

## Framework bindings

[flutter][flutter]

## examples

flutter [todo_mvc], written by [Brian Egan]

[nested state & actions][nesting]

[building reducers for built collections][collection_reducers]

[inheritence in state & actions][inheritence]

## libraries

[thunk][built_redux_thunk]

[rx][built_redux_rx]

[repatch][built_redux_repatch]

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
    built_redux: "^7.0.0"
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

### Implementing a built_redux store

```dart
import 'package:built_value/built_value.dart';
import 'package:built_redux/built_redux.dart';

// This is a an implementation of ReduxActions. Actions are what middleware and ui
// components invoke a change to the redux store's state. By extending ReduxActions
// the built_redux generator will generate the required boilerplate to create
// each action and an ActionNames class. The ActionNames class is used to register
// reducers
abstract class CounterActions extends ReduxActions {
  ActionDispatcher<int> get increment;
  ActionDispatcher<int> get decrement;

  // factory to create on instance of the generated implementation of CounterActions
  CounterActions._();
  factory CounterActions() => new _$CounterActions();
}

// This is a built value. It is an immutable model that implements the Built interface.
// All of the state in your redux store is contained in a single built value model.
abstract class Counter implements Built<Counter, CounterBuilder> {
  /// [count] value of the counter
  int get count;

  // Built value constructor. The factory is returning the default state
  Counter._();
  factory Counter() => new _$Counter._(count: 1);
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
// that can be passed to the store's constructor.
var reducerBuilder = new ReducerBuilder<Counter, CounterBuilder>()
  ..add(CounterActionsNames.increment, increment)
  ..add(CounterActionsNames.decrement, decrement);

// Create a redux store holding the state of your app.
// Its API contains three getters: stream, state, and actions.
var store = new Store<Counter, CounterBuilder, CounterActions>(
  reducerBuilder.build(), // build returns a reducer function
  new Counter(),
  new CounterActions(),
);

// You can use stream.listen() to update the UI in response to state changes.
store.stream.listen((change) => print('prev: ${change.prev.count} next ${change.next.count}'));

// The only way to mutate the internal state is to dispatch an action.
store.actions.increment(1);
print(store.state.count); // 1
store.actions.increment(2);
print(store.state.count); // 3
store.actions.decrement(1);
print(store.state.count); // 2

// when the event dispatching actions finishes and the stream handlers process, the following will be printed:
// prev: 0 next: 1
// prev: 1 next 3
// prev: 3 next: 2
```

### Writing middleware

```dart
// Define specific actions to be handled by this middleware.
// A middleware can also listen to and perform side effects on any actions defined
// elsewhere. It is possible that a middleware will not need any of its own actions
// defined.
 abstract class DoubleAction extends ReduxActions {
  ActionDispatcher<int> get increment;

  DoubleAction._();
  factory DoubleAction() => new _$DoubleAction();
}

// This is a middleware builder. Use of MiddlewareBuilder is not required, however
// just like ReducerBuilder it is strongly recommended as it gives you static type checking to make sure
// the payload for action name provided is the same as the expected payload
// for the action provided to your reducer. It will also call next(action) for you
// if an action not handled by this middleware is received. Calling .build() returns the
// middleware function that can be passed to your store at instantiation.
var doubleMiddleware = (new MiddlewareBuilder<Counter, CounterBuilder, CounterActions>()
  ..add(DoubleActionNames.increment, _doubleIt)).build();

void  _doubleIt(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<int> action) {
  // doubles the action payload and kicks off a new action to increment the
  // store by that amount.
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

store.stream.listen((change) => print(change.next.count));

// The only way to mutate the internal state is to dispatch an action.
store.actions.increment(1);
store.actions.doublerActions.increment(2);
store.actions.decrement(1);
// 1
// 5
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

### Observing state

The store's stream fires with a payload of type StoreChange. This is an object
that contains the action, the previous state, and the next state. If you would
like to set up a stream thats payload is simply the next state, use store.nexState

```dart

print(store.state.count); // 1

store.nextState.listen(print);

store.actions.increment(1);
store.actions.increment(3);

// 2
// 5

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
store.actions.nestedCounter.increment(2);

// prev: 1, next: 2

```

In the case of substate streams, the payload is of type SubStateChange. This is an object the previous state, and the next state. If you would
like to set up a stream thats payload is simply the next subState, use store.nexSubstate

```dart

print(store.state.count); // 1

store.nextSubstate((BaseCounter state) => state.count)
  .listen(print);

store.actions.increment(1);
store.actions.increment(3);

// 2
// 5

```

[built_value_blog]: https://medium.com/dartlang/darts-built-value-for-immutable-object-models-83e2497922d4

[built_value_git]: https://github.com/google/built_value.dart/

[redux_git]: https://github.com/reactjs/redux

[redux_docs]: http://redux.js.org/

[flutter]: https://github.com/davidmarne/flutter_built_redux

[built_redux_thunk]: https://github.com/davidmarne/built_redux_thunk

[built_redux_rx]: https://github.com/davidmarne/built_redux_rx

[built_redux_repatch]: https://github.com/davidmarne/built_redux_repatch

[flutter_built_redux]: https://github.com/davidmarne/flutter_built_redux

[nesting]: test/unit/nested_models.dart

[collection_reducers]: test/unit/collection_models.dart

[inheritence]: test/unit/inheritance_test_models.dart

[todo_mvc]: https://gitlab.com/brianegan/flutter_architecture_samples/tree/master/example/built_redux

[Brian Egan]: https://gitlab.com/brianegan
