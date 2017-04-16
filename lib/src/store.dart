import 'dart:async';
import 'dart:core';

import 'action.dart';
import 'built_reducer.dart';
import 'middleware.dart';
import 'typedefs.dart';

// TODO: extend disposable
class Store<State extends BuiltReducer, Actions extends ReduxActions> {
  // stream used for dispatching actions
  final StreamController<Action<dynamic>> _dispatch = new StreamController.broadcast();

  // stream used to dispatch changes to the state
  final StreamController<State> _stateController = new StreamController.broadcast();

  // the current state
  State _state;
  Actions _actions;

  Store(
    State defaultState,
    Actions actions, {
    Iterable<Middleware<State>> middleware: const [],
  }) {
    // set the initial state
    _state = defaultState;
    _actions = actions;
    _actions.syncWithStore(_dispatch.add);

    final MiddlewareApi api = new MiddlewareApi<State, Actions>(this);

    // setup the middleware dispatch chain
    ActionHandler handler = (action) {
      print("action ${action.name}");
      var state = _state.rebuild((b) => _state.reduce(b, action));

      // if the hashcode did not change bail
      if (identical(_state, state)) return;
      print(state);
      // update the internal state and publish the change
      _state = state;
      _stateController.add(_state);
    };

    if (middleware.length > 0) {
      Iterable<NextActionHandler> chain = middleware.map((m) => m(api));
      NextActionHandler combinedMiddleware =
          chain.reduce((composed, middleware) => (handler) => composed(middleware(handler)));
      handler = combinedMiddleware(handler);
    }

    _dispatch.stream.listen(handler);
  }

  /// [subscribe] returns a stream that will be dispatched whenever the state changes
  Stream<State> get subscribe => _stateController.stream;

  /// [state] returns the current state
  State get state => _state;

  /// [actions] returns the synced actions
  Actions get actions => _actions;

  /// [dispatch] dispatches a new actione
  dispatch(Action a) => _dispatch.add(a);
}
