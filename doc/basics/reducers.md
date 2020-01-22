# Reducers

## What is a reducer

Reducers specify how the application's state changes in response to actions sent to the store. Remember that actions only describe the fact that something happened, but don't describe how the application's state changes.

## Writing a reducer

Say I'm working on the counter app discussed in the [Actions](actions.md) section. This means I've defined my apps actions as:

```dart
abstract class AppActions extends ReduxActions {
  AppActions._();
  factory AppActions() => _$AppActions();
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;
}
```

and my state object as so:

```dart
abstract class App implements Built<App, AppBuilder> {
  App._();
  factory App() => _$App._(count: 0);

  int get count;
}
```

I can define a simple reducer function as follows:

```dart
void counterReducer(App prevState, Action<dynamic> action, AppBuilder builder) {
  if (action.name == AppActionsNames.increment.name)
    builder.count += action.payload as int;
  else if (action.name == AppActionsNames.decrement.name)
    builder.count -= action.payload as int;
}
```

When this reducer is run it will either increase or decrease the count value conditionally based on the action that was dispatched. Unlike redux.js or redux.dart, it does not return anything. It simply uses the builder provided to make changes.

Notice the action parameter is dynamic and action.payload has to be casted to an integer. This is no good, and can be avoided by using a [ReducerBuilder](../advanced/building_reducers.md)

## More on the differences from redux.js and redux.dart

In redux.js and redux.dart, reducers are just pure functions that take the previous state and an action, and return the next state. You are required to return new state objects, instead of mutating the previous state. This is where built_redux differs. With built_redux your reducer functions are passed a referenece to a builder for your state object and you apply any changes to that builder. This means your reducers are actually void functions. This is because, behind the scenes, built_redux calls `.toBuilder()` on your state object once, and passes you a reference to the builder to mutate so you do not have to call `.toBuilder()` or `.rebuild(updates)` on your state objects manually.
