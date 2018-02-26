# Middleware

Middleware functions are functions that are exectued before an action calls a reducer. Middleware is useful for logging, crash reporting, talking to an asynchronous API, routing, and more.

A middleware is passed an instance of `MiddlewareApi` which gives access to the store's current state and actions. It is also passed the `action` that was dispatched, as well as a reference to the `next` function in the middleware chain. A middleware can decide to call the `next` function or not, giving it the ability to short circuit the middleware chain. Note that this means if `next` is not called, the reducer will never be called. It is important to note that `MiddlewareApi` contains a getter to the store's state, so the value of `api.state` will be different and after calling `next` if the action causes a state change.

A basic middleware example is a logging middleware. In this example the following middleware:

1. prints the action dispatched and the store's state before the middleware chain is continued
2. calls next, allowing the middleware chain to continue
3. prints the resulting state change if one was made

```dart
NextActionHandler loggingMiddleware(MiddlewareApi api) =>
    (ActionHandler next) => (Action action) {
        final prevState = api.state;
        logger.fine('Action: $action');
        logger.fine('Previous State: ${prevState});
        next(action);
        if (prevState != api.state) {
            logger.fine('Action: $action');
            logger.fine('Resulting State: ${api.state});
        }
    };
```