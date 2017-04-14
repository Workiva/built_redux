import 'action.dart';
import 'built_reducer.dart';
import 'store.dart';

class MiddlewareApi<State extends BuiltReducer> {
  Store<State> _store;
  MiddlewareApi(this._store);

  /// [state] returns the current state
  State get state => _store.state;

  /// [dispatch] dispatches a new action
  dispatch(Action a) => _store.dispatch(a);
}
