# Reducer Builders

ReducerBuilders allow you to register smaller reducer functions that handle a single action. They give you static type checking to make sure the payload for action name provided is the same as the expected payload for the action provided to your reducer. Calling .build() returns a reducer function that can be passed to the store's constructor.

```dart

var reducerBuilder = new ReducerBuilder<Counter, CounterBuilder>()
  ..add(CounterActionsNames.increment, increment)
  ..add(CounterActionsNames.decrement, decrement);

increment(Counter state, Action<int> action, CounterBuilder builder) {
  builder.count = state.count + action.payload;
}

decrement(Counter state, Action<int> action, CounterBuilder builder) {
  builder.count = state.count - action.payload;
}

// Create a redux store holding the state of your app.
// Its API contains three getters: stream, state, and actions.
var store = new Store<Counter, CounterBuilder, CounterActions>(
  reducerBuilder.build(), // build returns a reducer function
  new Counter(),
  new CounterActions(),
);

```

The following would fail analysis if the decrement's `ActionDispatcher` had a generic type of int:

```dart

var reducerBuilder = new ReducerBuilder<Counter, CounterBuilder>()
  ..add(CounterActionsNames.increment, increment)
  ..add(CounterActionsNames.decrement, decrement); // would yield error

increment(Counter state, Action<int> action, CounterBuilder builder) {
  builder.count = state.count + action.payload;
}

// the second param must be corrected to Action<int> action
decrement(Counter state, Action<String> action, CounterBuilder builder) {
  builder.count = state.count - action.payload;
}

```