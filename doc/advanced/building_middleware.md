# Middleware Builders

MiddlewareBuilders allow you to register smaller middleware functions that handle a single action. They give you static type checking to make sure the payload for action name provided is the same as the expected payload for the action provided to your reducer. Calling .build() returns a middleware function that can be passed to the store's constructor.

```dart

final middlewareBuilder = new MiddlewareBuilder<Counter, CounterBuilder, CounterActions>()
  ..add(CounterActionsNames.increment, increment)
  ..add(CounterActionsNames.decrement, decrement);

void increment(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<int> action) {
  logger.fine('counter incremented by ${action.payload}');
  next(action);
}

void decrement(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<int> action) {
  logger.fine('counter decremented by ${action.payload}');
  next(action);
}

// Create a redux store holding the state of your app.
// Its API contains three getters: stream, state, and actions.
var store = new Store<Counter, CounterBuilder, CounterActions>(
  reducerBuilder.build(), // build returns a reducer function
  new Counter(),
  new CounterActions(),
  middleware: [
      middlewareBuilder.build(),
  ],
);

```

The following would fail analysis if the decrement's `ActionDispatcher` had a generic type of int:

```dart

final middlewareBuilder = new MiddlewareBuilder<Counter, CounterBuilder, CounterActions>()
  ..add(CounterActionsNames.increment, increment)
  ..add(CounterActionsNames.decrement, decrement); // would yield error

void increment(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<int> action) {
  logger.fine('counter incremented by ${action.payload}');
  next(action);
}

// the third param must be corrected to Action<int> action
void decrement(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<String> action) {
  logger.fine('counter decremented by ${action.payload}');
  next(action);
}

```