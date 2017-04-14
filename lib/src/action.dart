import 'typedefs.dart';

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
  ActionDispatcher dispatcher;
  ReduxActions(this.dispatcher);
}

/// Action annotaion
///
/// class TodoActions extends ReduxActions {
///   ActionMgr<String> addTodo;
///   final ActionMgr<int> removeTodo;
///
///   TodoActions(this.dispatcher);
/// }
///
/// transforms into
///
/// class TodoActions extends ReduxActions {
///   final ActionMgr<String> addTodo;
///   final ActionMgr<int> removeTodo;
///
///   TodoActions(this.dispatcher):
///     addTodo = new ActionMgr('todoActions-addTodo', dispatcher)
///     removeTodo = new ActionMgr('todoActions-removeTodo', dispatcher);
/// }
///

class ReducerBuilder<B> {
  Map<String, Reducer> _map;

  ReducerBuilder();

  add<T>(ActionMgr<T> aMgr, Reducer<T, dynamic, B> reducer) => _map[aMgr.name] = reducer;

  build() => _map;
}
