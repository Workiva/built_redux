/// [Action]
/// Action [name]s should always be unique!
class Action<Payload> {
  /// A unique action name.
  String name;

  /// The actions payload.
  Payload payload;
}

// Dispatches an action to the store
typedef ActionDispatcher<P>(Action<P> action);

class ActionMgr<P> {
  ActionDispatcher _dispatcher;
  final String _name;

  String get name => _name;

  call(P payload) => _dispatcher(new Action()
    ..name = name
    ..payload = payload);

  ActionMgr(this._name);

  syncWithStore(dispatcher) {
    _dispatcher = dispatcher;
  }
}

abstract class ReduxActions {
  syncWithStore(dispatcher);
}

class ActionName<T> {
  String name;
  ActionName(this.name);
}
