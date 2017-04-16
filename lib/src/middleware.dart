import 'action.dart';
import 'built_reducer.dart';
import 'store.dart';

class MiddlewareApi<State extends BuiltReducer, Actions extends ReduxActions> {
  Store<State, Actions> _store;
  MiddlewareApi(this._store);

  /// [state] returns the current state
  State get state => _store.state;

  /// [dispatch] dispatches a new action
  Actions get actions => _store.actions;
}
