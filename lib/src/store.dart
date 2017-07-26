import 'dart:async';
import 'dart:core';

import 'package:built_value/built_value.dart';

import 'action.dart';
import 'built_reducer.dart';
import 'middleware.dart';
import 'typedefs.dart';
import 'store_change.dart';
import 'state_transformer.dart';

/// [Store] is the container of your state. It listens for actions, invokes reducers,
/// and publishes changes to the state
class Store<State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, Actions extends ReduxActions> {
  // stream used for dispatching actions
  final StreamController<Action<dynamic>> _dispatch = new StreamController();

  // stream used to dispatch changes to the state
  final StreamController<StoreChange<State, StateBuilder, dynamic>> _stateController =
      new StreamController.broadcast();

  // the current state
  State _state;
  Actions _actions;

  Store(
    State defaultState,
    Actions actions, {
    Iterable<Middleware<State, StateBuilder, Actions>> middleware: const [],
  }) {
    // set the initial state
    _state = defaultState;
    _actions = actions;
    _actions.syncWithStore(_dispatch.add);

    final MiddlewareApi api = new MiddlewareApi<State, StateBuilder, Actions>(this);

    // setup the middleware dispatch chain
    ActionHandler handler = (action) {
      var state = _state.rebuild((b) => _state.reduce(_state, action, b));

      // if the hashcode did not change bail
      if (_state == state) return;

      // update the internal state and publish the change
      _stateController.add(new StoreChange<State, StateBuilder, dynamic>(state, _state, action));
      _state = state;
    };

    // if middleware is give build the chain
    if (middleware.length > 0) {
      // Scope each function with the store's api
      Iterable<NextActionHandler> chain = middleware.map((m) => m(api));

      // combine each middeware
      NextActionHandler combinedMiddleware =
          chain.reduce((composed, middleware) => (handler) => composed(middleware(handler)));

      // make the last middleware in the chain call the top-level reducer
      handler = combinedMiddleware(handler);
    }

    _dispatch.stream.listen(handler);
  }

  /// [dispose] removes closes both the dispatch and subscription stream
  dispose() {
    _stateController.close();
    _dispatch.close();
    _state = null;
    _actions = null;
  }

  /// [subscribe] returns a stream that will be dispatched whenever the state changes
  Stream<StoreChange<State, StateBuilder, dynamic>> get stream => _stateController.stream;

  /// [state] returns the current state
  State get state => _state;

  /// [actions] returns the synced actions
  Actions get actions => _actions;

  /// [substateStream] returns a stream to the state that is returned by the mapper function.
  /// For example: say my state object had a property count, then store.substateStream((state) => state.count),
  /// would return a stream that fires whenever count changes.
  Stream<SubStateChange<SubState>> substateStream<SubState>(
    StateMapper<State, StateBuilder, SubState> mapper,
  ) =>
      _stateController.stream.transform(new StateChangeTransformer(mapper));
}
