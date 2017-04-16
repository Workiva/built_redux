import 'typedefs.dart';
import 'middleware.dart';
import 'built_reducer.dart';

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
  var _map = new Map<String, Reducer>();

  add<T>(ActionName<T> aMgr, Reducer<T, dynamic, B> reducer) => _map[aMgr.name] = reducer;

  build() => _map;
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

class ActionName<T> {
  String name;
  ActionName(this.name);
}
