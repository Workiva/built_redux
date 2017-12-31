library test_counter;

import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'test_counter.g.dart';

// Counter

abstract class CounterActions extends ReduxActions {
  CounterActions._();
  factory CounterActions() => new _$CounterActions();

  ActionDispatcher<int> increment;
  ActionDispatcher<int> incrementOther;
  MiddlewareActions middlewareActions;
}

void _increment(Counter state, Action<int> action, CounterBuilder builder) =>
    builder.count = state.count + action.payload;

void _incrementOther(
        Counter state, Action<int> action, CounterBuilder builder) =>
    builder.otherCount = state.otherCount + action.payload;

final reducer = (new ReducerBuilder<Counter, CounterBuilder>()
      ..add(CounterActionsNames.increment, _increment)
      ..combine(_otherReducer))
    .build();

final _otherReducer = (new ReducerBuilder<Counter, CounterBuilder>()
  ..add(CounterActionsNames.incrementOther, _incrementOther));

abstract class Counter implements Built<Counter, CounterBuilder> {
  int get count;

  int get otherCount;

  // Built value constructor
  Counter._();
  factory Counter() => new _$Counter._(count: 1, otherCount: 1);
}

// Middleware

abstract class MiddlewareActions extends ReduxActions {
  ActionDispatcher<int> increment;

  MiddlewareActions._();
  factory MiddlewareActions() => new _$MiddlewareActions();
}

var counterMiddleware =
    (new MiddlewareBuilder<Counter, CounterBuilder, CounterActions>()
          ..add(MiddlewareActionsNames.increment, _doubleIt))
        .build();

void _doubleIt(MiddlewareApi<Counter, CounterBuilder, CounterActions> api,
    ActionHandler next, Action<int> action) {
  api.actions.increment(api.state.count * 2);
  next(action);
}

// Change handler

StoreChangeHandlerBuilder<Counter, CounterBuilder,
    CounterActions> createChangeHandler(
        Completer comp) =>
    (new StoreChangeHandlerBuilder<Counter, CounterBuilder, CounterActions>()
      ..add(CounterActionsNames.increment, (change) => comp.complete(change)));
