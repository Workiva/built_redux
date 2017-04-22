import 'action.dart';
import 'built_reducer.dart';
import 'store.dart';
import 'typedefs.dart';

/// [MiddlewareApi] put in scope to your [Middleware] function by redux.
/// When using [MiddlwareBuilder] (recommended) [MiddlewareApi] is passed to your [MiddlewareHandler]
class MiddlewareApi<State extends BuiltReducer, Actions extends ReduxActions> {
  Store<State, Actions> _store;
  MiddlewareApi(this._store);

  /// [state] returns the current state
  State get state => _store.state;

  /// [actions] returns the actions synced with this redux store
  Actions get actions => _store.actions;
}

/// [MiddlwareBuilder] allows you to build a reducer that handles many different actions
/// with many different payload types, while maintaining type safety.
/// Each [MiddlewareHandler] added with add<T> must take a state of type V, an Action of type
/// Action<T>, and a builder of type B
class MiddlwareBuilder<State extends BuiltReducer, Actions extends ReduxActions> {
  var _map = new Map<String, MiddlewareHandler<State, Actions>>();

  add<T>(ActionName<T> aMgr, MiddlewareHandler<State, Actions> handler) => _map[aMgr.name] =
      handler;

  /// build returns a [Middlware] function that handles all actions added with [add]
  build() => (MiddlewareApi<State, Actions> api) => (ActionHandler next) => (Action action) {
        var handler = _map[action.name];
        if (handler != null) {
          handler(api, next, action);
          return;
        }

        next(action);
      };
}

/// [MiddlewareHandler] is a function that handles an action in a middleware. Its is only for
/// use with [MiddlwareBuilder]. If you are not using [MiddlwareBuilder] middleware must be
/// decalred as a [Middleware] function.
typedef MiddlewareHandler<State extends BuiltReducer, Actions extends ReduxActions>(
    MiddlewareApi<State, Actions> api, ActionHandler next, Action action);
