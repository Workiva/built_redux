// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_counter;

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$CounterActions extends CounterActions {
  factory _$CounterActions() => new _$CounterActions._();
  _$CounterActions._() : super._();

  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('CounterActions-increment');
  final ActionDispatcher<int> incrementOther =
      new ActionDispatcher<int>('CounterActions-incrementOther');
  final MiddlewareActions middlewareActions = new MiddlewareActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
    incrementOther.setDispatcher(dispatcher);
    middlewareActions.setDispatcher(dispatcher);
  }
}

class CounterActionsNames {
  static final ActionName<int> increment =
      new ActionName<int>('CounterActions-increment');
  static final ActionName<int> incrementOther =
      new ActionName<int>('CounterActions-incrementOther');
}

class _$MiddlewareActions extends MiddlewareActions {
  factory _$MiddlewareActions() => new _$MiddlewareActions._();
  _$MiddlewareActions._() : super._();

  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('MiddlewareActions-increment');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
  }
}

class MiddlewareActionsNames {
  static final ActionName<int> increment =
      new ActionName<int>('MiddlewareActions-increment');
}
