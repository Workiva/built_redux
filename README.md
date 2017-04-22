[![Pub](https://img.shields.io/pub/v/built_redux.svg)](https://pub.dartlang.org/packages/built_redux)

### built_redux

built_redux is a state management library written in dart that enforces immutability.

Inspired by [redux][redux_git]

Built using [built_value][built_value_git]

### Using it in your project

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
      built_redux: "^0.0.5"
    ```

2. Add the `built_redux` [transformer] to your `pubspec.yaml`.

    ```yaml
    transformers:
      - built_redux
      # Reminder: dart2js should come after any other transformers that touch Dart code
      - $dart2js
    ```

    _Our transformer uses code generation reduce boilerplate required to set up
    nested redux store

3. Create a script to run generators for generating built_values and redux actions.
    ```
    import 'dart:async';

    import 'package:build_runner/build_runner.dart';
    import 'package:built_value_generator/built_value_generator.dart';
    import 'package:source_gen/source_gen.dart';
    import 'package:built_redux/generator.dart';

    /// Build the generated files in the built_value chat example.
    Future main(List<String> args) async {
      await build(
          new PhaseGroup.singleAction(
              new GeneratorBuilder([
                new BuiltValueGenerator(),
                new BuiltReduxGenerator(),
              ]),
              new InputSet('my_lib', const ['lib/**/*.dart'])),
          deleteFilesByDefault: true);
    }
    ```

### Writing a built_redux store

```
import 'package:built_redux/built_redux.dart';

/**
 * This is a an implementation of ReduxActions. Actions are middleware and ui
 * components invoke a change to the redux store's state. By extending ReduxActions
 * the built_redux generator will generate the required boilerplate to create
 * each action and an ActionNames class.
 */
 abstract class CounterActions extends ReduxActions {
   ActionDispatcher<int> increment;
   ActionDispatcher<int> decrement;

   // factory to create on instance of the generated implementation of CounterActions
   AppStateActions._();
   factory AppStateActions() => new _$AppStateActions();
 }

/**
 * This is a BuiltReducer. It is essentially an implementation of built_value
 * with one extra getter named reducers. This getter is simply a map from action
 * name to a reducer function.
 */
 abstract class Counter extends BuiltReducer<Counter, CounterBuilder>
     implements Built<Counter, CounterBuilder> {
   /// [count] value of the counter
   int get count;

   /// This is the reducer getter, it describes which actions this BuiltReducer handles
   /// and how each action transforms the state into the next state.
   get reducer => _reducer;

   // Built value boilerplate
   Counter._();
   factory Counter([updates(CounterBuilder b)]) = _$Counter;
 }


/**
 * These are reducers, a pure function with (builder, action) => state signature.
 * It describes how an action transforms the state into the next state.
 */
increment(Counter state, Action<int> action, CounterBuilder builder) =>
  builder..count = state.count + action.payload;

decrement(Counter state, Action<int> action, CounterBuilder builder) =>
  builder..count = state.count - action.payload;

/**
 * This is a reducer builder. Use of ReducerBuilder is not required, however it
 * is strongly recommended as it gives you static type checking to make sure
 * the payload for action name provided is the same as the expected payload
 * for the action provided to your reducer. Calling .build() returns the map
 * of action names to reducers.
 */
var _reducer =  (new ReducerBuilder<CounterBuilder>()
      ..add<int>(CounterActionsNames.increment, increment)
      ..add<int>(CounterActionsNames.decrement, decrement)).build();

// Create a Redux store holding the state of your app.
// Its API is subscribe, state, actions.
var store = new Store<AppState, AppStateActions>(
  _defaultState(),
  new CounterActions(),
);

// You can use subscribe() to update the UI in response to state changes.
// Normally you'd use a view binding library (e.g. React Redux) rather than subscribe() directly.
// However it can also be handy to persist the current state in the localStorage.

store.subscribe(() =>
  print(store.state);
)

// The only way to mutate the internal state is to dispatch an action.
store.actions.increment(1);
// 1
store.actions.increment(2);
// 3
store.actions.decrement(1);
// 2
```

### Writing middleware
```
/**
 * Actions to be handled by this middleware
 */
abstract class DoubleAction extends ReduxActions {
  ActionDispatcher<int> increment;

  DoubleAction._();
  factory DoubleAction() => new _$DoubleAction();
}

/**
 * This is a middleware builder. Use of MiddlewareBuilder is not required, however
 * just like ReducerBuilder it is strongly recommended as it gives you static type checking to make sure
 * the payload for action name provided is the same as the expected payload
 * for the action provided to your reducer. It will also call next(action) for you
 * if an action not handled by this middlware is received. Calling .build() returns the
 * middleware function that can be passed to your store at instantiation.
 */
var doubleMiddleware =  (new MiddlwareBuilder<Counter, CounterActions>()
      ..add<int>(DoubleActionNames.increment, _doubleIt)).build();

_doubleIt(MiddlewareApi api, ActionHandler next, Action<int> action) {
  api.actions.increment(action.payload * 2);
}
```

You will notice that MiddlwareBuilder's generics are Counter and CounterActions.
These are the same types as the defaultState and actions classes passed when
the store was instantiated. In order for DoubleActions to be handled by redux
you must add it to definition of CounterActions like so

```
abstract class CounterActions extends ReduxActions {
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;

  DoubleActions doublerActions;

  // factory to create on instance of the generated implementation of CounterActions
  AppStateActions._();
  factory AppStateActions() => new _$AppStateActions();
}
```

Check the usage after adding this middleware
```
// Create a Redux store holding the state of your app.
// Its API is subscribe, state, actions.
var store = new Store<AppState, AppStateActions>(
  _defaultState(),
  new CounterActions(),
  middleware: [doubleMiddleware],
);

store.subscribe(() =>
  print(store.state);
)

// The only way to mutate the internal state is to dispatch an action.
store.actions.increment(1);
// 1
store.actions.doublerActions.increment(2);
// 5
store.actions.decrement(1);
// 4
```

[built_value_blog]: https://medium.com/dartlang/darts-built-value-for-immutable-object-models-83e2497922d4

[built_value_git]: https://github.com/google/built_value.dart/

[redux_git]: https://github.com/reactjs/redux

[redux_docs]: http://redux.js.org/
