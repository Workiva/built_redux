import 'action.dart';
import 'built_reducer.dart';
import 'store.dart';
import 'typedefs.dart';

class MiddlewareApi<State extends BuiltReducer, Actions extends ReduxActions> {
  Store<State, Actions> _store;
  MiddlewareApi(this._store);

  /// [state] returns the current state
  State get state => _store.state;

  /// [dispatch] dispatches a new action
  Actions get actions => _store.actions;
}

typedef MiddlewareHandler<State extends BuiltReducer, Actions extends ReduxActions>(
    MiddlewareApi<State, Actions> api, ActionHandler next, Action action);

class MiddlwareBuilder<State extends BuiltReducer, Actions extends ReduxActions> {
  var _map = new Map<String, MiddlewareHandler<State, Actions>>();

  add<T>(ActionName<T> aMgr, MiddlewareHandler<State, Actions> handler) => _map[aMgr.name] =
      handler;

  build() => (MiddlewareApi<State, Actions> api) => (ActionHandler next) => (Action action) {
        var handler = _map[action.name];
        if (handler != null) {
          handler(api, next, action);
          return;
        }

        next(action);
      };
}
