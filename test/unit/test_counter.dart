library test_counter;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'test_counter.g.dart';

// BaseCounter

abstract class BaseCounterActions extends ReduxActions {
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;

  NestedCounterActions nestedCounterActions;
  MiddlewareActions middlewareActions;

  BaseCounterActions._();
  factory BaseCounterActions() => new _$BaseCounterActions();
}

_baseIncrement(BaseCounter state, Action<int> action, BaseCounterBuilder builder) =>
    builder..count = state.count + action.payload;

_baseDecrement(BaseCounter state, Action<int> action, BaseCounterBuilder builder) =>
    builder..count = state.count - action.payload;

final _baseReducer = (new ReducerBuilder<BaseCounter, BaseCounterBuilder>()
      ..add<int>(BaseCounterActionsNames.increment, _baseIncrement)
      ..add<int>(BaseCounterActionsNames.decrement, _baseDecrement))
    .build();

// Built Reducer
abstract class BaseCounter extends BuiltReducer<BaseCounter, BaseCounterBuilder>
    with BaseCounterReduceChildren
    implements Built<BaseCounter, BaseCounterBuilder> {
  int get count;

  NestedCounter get nestedCounter;

  get reducer => _baseReducer;

  // Built value boilerplate
  BaseCounter._();
  factory BaseCounter([updates(BaseCounterBuilder b)]) =>
      new _$BaseCounter((BaseCounterBuilder b) => b
        ..count = 1
        ..nestedCounter = new NestedCounter().toBuilder());
}

// Nested Counter

abstract class NestedCounterActions extends ReduxActions {
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;

  NestedCounterActions._();
  factory NestedCounterActions() => new _$NestedCounterActions();
}

_nestedIncrement(NestedCounter state, Action<int> action, NestedCounterBuilder builder) =>
    builder..count = state.count + action.payload;

_nestedDecrement(NestedCounter state, Action<int> action, NestedCounterBuilder builder) =>
    builder..count = state.count - action.payload;

final _nestedReducer = (new ReducerBuilder<NestedCounter, NestedCounterBuilder>()
      ..add<int>(NestedCounterActionsNames.increment, _nestedIncrement)
      ..add<int>(NestedCounterActionsNames.decrement, _nestedDecrement))
    .build();

abstract class NestedCounter extends BuiltReducer<NestedCounter, NestedCounterBuilder>
    implements Built<NestedCounter, NestedCounterBuilder> {
  int get count;

  get reducer => _nestedReducer;

  // Built value boilerplate
  NestedCounter._();
  factory NestedCounter([updates(NestedCounterBuilder b)]) =>
      new _$NestedCounter((NestedCounterBuilder b) => b..count = 1);
}

abstract class MiddlewareActions extends ReduxActions {
  ActionDispatcher<int> increment;

  MiddlewareActions._();
  factory MiddlewareActions() => new _$MiddlewareActions();
}

var createCounterMiddleware = (new MiddlwareBuilder<BaseCounter, BaseCounterActions>()
      ..add<int>(MiddlewareActionsNames.increment, _doubleIt))
    .build();

_doubleIt(
    MiddlewareApi<BaseCounter, BaseCounterActions> api, ActionHandler next, Action<int> action) {
  api.actions.increment(api.state.count * 2);
  next(action);
}
