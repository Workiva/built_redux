library test_counter;

import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'test_counter.g.dart';

// BaseCounter

abstract class BaseCounterActions extends ReduxActions {
  BaseCounterActions._();
  factory BaseCounterActions() => new _$BaseCounterActions();

  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;
  MiddlewareActions middlewareActions;
}

void _baseIncrement(
        BaseCounter state, Action<int> action, BaseCounterBuilder builder) =>
    builder.count = state.count + action.payload;

void _baseDecrement(
        BaseCounter state, Action<int> action, BaseCounterBuilder builder) =>
    builder.count = state.count - action.payload;

final reducer = (new ReducerBuilder<BaseCounter, BaseCounterBuilder>()
      ..add(BaseCounterActionsNames.increment, _baseIncrement)
      ..combine(_otherReducer))
    .build();

final _otherReducer = (new ReducerBuilder<BaseCounter, BaseCounterBuilder>()
  ..add(BaseCounterActionsNames.decrement, _baseDecrement));

abstract class BaseCounter implements Built<BaseCounter, BaseCounterBuilder> {
  int get count;

  BuiltList<int> get indexOutOfRangeList;

  // Built value constructor
  BaseCounter._();
  factory BaseCounter() =>
      new _$BaseCounter._(count: 1, indexOutOfRangeList: new BuiltList<int>());
}

// Middleware

abstract class MiddlewareActions extends ReduxActions {
  ActionDispatcher<int> increment;

  MiddlewareActions._();
  factory MiddlewareActions() => new _$MiddlewareActions();
}

var counterMiddleware = (new MiddlewareBuilder<BaseCounter, BaseCounterBuilder,
        BaseCounterActions>()
      ..add(MiddlewareActionsNames.increment, _doubleIt))
    .build();

_doubleIt(
    MiddlewareApi<BaseCounter, BaseCounterBuilder, BaseCounterActions> api,
    ActionHandler next,
    Action<int> action) {
  api.actions.increment(api.state.count * 2);
  next(action);
}

// Change handler

createChangeHandler(Completer comp) => (new StoreChangeHandlerBuilder<
    BaseCounter, BaseCounterBuilder, BaseCounterActions>()
  ..add(BaseCounterActionsNames.increment, (change) => comp.complete(change)));
