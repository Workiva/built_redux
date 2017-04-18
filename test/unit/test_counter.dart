library test_counter;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'test_counter.g.dart';

// BaseCounter

abstract class BaseCounterActions extends ReduxActions {
  ActionMgr<int> increment;
  ActionMgr<int> decrement;

  NestedCounterActions nestedCounterActions;
  MiddlewareActions middlewareActions;

  BaseCounterActions._();
  factory BaseCounterActions() => new _$BaseCounterActions();
}

_baseIncrement(BaseCounter state, Action<int> action, BaseCounterBuilder builder) =>
    builder..count = state.count + action.payload;

_baseDecrement(BaseCounter state, Action<int> action, BaseCounterBuilder builder) =>
    builder..count = state.count - action.payload;

final _baseReducers = (new ReducerBuilder<BaseCounterBuilder>()
      ..add<int>(BaseCounterActionsNames.increment, _baseIncrement)
      ..add<int>(BaseCounterActionsNames.decrement, _baseDecrement))
    .build();

// Built Reducer
abstract class BaseCounter extends BuiltReducer<BaseCounter, BaseCounterBuilder>
    implements Built<BaseCounter, BaseCounterBuilder> {
  int get count;

  NestedCounter get nestedCounter;

  get reducers => _baseReducers;

  // Built value boilerplate
  BaseCounter._();
  factory BaseCounter([updates(BaseCounterBuilder b)]) = _$BaseCounter;
}

// Nested Counter

abstract class NestedCounterActions extends ReduxActions {
  ActionMgr<int> increment;
  ActionMgr<int> decrement;

  NestedCounterActions._();
  factory NestedCounterActions() => new _$NestedCounterActions();
}

_nestedIncrement(NestedCounter state, Action<int> action, NestedCounterBuilder builder) =>
    builder..count = state.count + action.payload;

_nestedDecrement(NestedCounter state, Action<int> action, NestedCounterBuilder builder) =>
    builder..count = state.count - action.payload;

final _nestedReducers = (new ReducerBuilder<NestedCounterBuilder>()
      ..add<int>(NestedCounterActionsNames.increment, _nestedIncrement)
      ..add<int>(NestedCounterActionsNames.decrement, _nestedDecrement))
    .build();

abstract class NestedCounter extends BuiltReducer<NestedCounter, NestedCounterBuilder>
    implements Built<NestedCounter, NestedCounterBuilder> {
  int get count;

  get reducers => _nestedReducers;

  // Built value boilerplate
  NestedCounter._();
  factory NestedCounter([updates(NestedCounterBuilder b)]) = _$NestedCounter;
}

abstract class MiddlewareActions extends ReduxActions {
  ActionMgr<int> increment;

  MiddlewareActions._();
  factory MiddlewareActions() => new _$MiddlewareActions();
}

var createCounterMiddleware = (new MiddlwareBuilder<BaseCounter, BaseCounterActions>()
      ..add<int>(MiddlewareActionsNames.increment, _doubleIt))
    .build();

_doubleIt(
    MiddlewareApi<BaseCounter, BaseCounterActions> api, ActionHandler next, Action<int> action) {
  api.actions.increment(action.payload * 2);
}
