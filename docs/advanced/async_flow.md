# Async Flow

Without middleware, built_redux store only supports synchronous data flow.

You may pass middleware to the store upon construction. It is not required, but it lets you express asynchronous actions in a convenient way.

Asynchronous middleware like [built_redux_thunk](https://github.com/davidmarne/built_redux_thunk) or [built_redux_rx](https://github.com/davidmarne/built_redux_rx) provide middleware to help asynchronous flow easy. However, you can easily write your own middleware to perform async actions.

Note that is best practice to dispatch a new action after an async process resolves rather than calling next after an await or .then.

The following middleware is built to hit a server then update the store upon success, and show an alert upon error.

``` dart

final middlewareBuilder = new MiddlewareBuilder<Counter, CounterBuilder, CounterActions>()
  ..add(CounterActionsNames.incrementAsync, increment)
  ..add(CounterActionsNames.decrementAsync, decrement);

void increment(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<int> action) {
  HttpRequest.postFormData(url, {'incrementAmount': action.payload})
      .then(capi.actions.increment(action.payload))
      .catchError(window.alert);
}

void decrement(MiddlewareApi<Counter, CounterBuilder, CounterActions> api, ActionHandler next, Action<int> action) {
  HttpRequest.postFormData(url, {'decrementAmount': action.payload})
      .then((resp) => api.actions.decrement(action.payload))
      .catchError(window.alert);
}

```