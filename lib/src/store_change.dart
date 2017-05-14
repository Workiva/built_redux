import 'dart:async';

import 'package:built_value/built_value.dart';

import 'action.dart';
import 'built_reducer.dart';
import 'store.dart';

/// [StoreChange] is the payload for the [Store] subscription
class StoreChange<State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, P> {
  final State next;
  final State prev;
  final Action<P> action;

  StoreChange(State n, State p, Action<P> a)
      : next = n,
        prev = p,
        action = a;
}

/// [StoreChangeHandler] handles a change the store after an action of type Action<T>
typedef void StoreChangeHandler<P, State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>>(
  StoreChange<State, StateBuilder, P> storeChange,
);

/// [StoreChangeHandlerBuilder] allows you to listen to the [Store] and perform a handler for a given
/// set of actions with many different payload types, while maintaining type safety.
/// Each [StoreChangeHandler] added with add<T> must take a [StoreChange] with prev and next of type
/// <State, StateBuilder> an Action of typ Action<T>,
class StoreChangeHandlerBuilder<State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, Actions extends ReduxActions> {
  final _map = new Map<String, StoreChangeHandler<dynamic, State, StateBuilder>>();
  StreamSubscription<StoreChange<State, StateBuilder, dynamic>> _subscription;

  void add<Payload>(
      ActionName<Payload> aName, StoreChangeHandler<Payload, State, StateBuilder> reducer) {
    _map[aName.name] = reducer;
  }

  build(Store<State, StateBuilder, Actions> store) {
    _subscription = store.stream.listen((StoreChange<State, StateBuilder, dynamic> storeChange) {
      var handler = _map[storeChange.action.name];
      if (handler != null) handler(storeChange);
    });
  }

  dispose() {
    _subscription.cancel();
  }
}
