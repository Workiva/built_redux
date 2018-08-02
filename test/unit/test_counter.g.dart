// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_counter;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides

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

  final ActionDispatcher<int> doubleIt =
      new ActionDispatcher<int>('MiddlewareActions-doubleIt');
  final ActionDispatcher<int> tripleIt =
      new ActionDispatcher<int>('MiddlewareActions-tripleIt');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    doubleIt.setDispatcher(dispatcher);
    tripleIt.setDispatcher(dispatcher);
  }
}

class MiddlewareActionsNames {
  static final ActionName<int> doubleIt =
      new ActionName<int>('MiddlewareActions-doubleIt');
  static final ActionName<int> tripleIt =
      new ActionName<int>('MiddlewareActions-tripleIt');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$Counter extends Counter {
  @override
  final int count;
  @override
  final int otherCount;

  factory _$Counter([void updates(CounterBuilder b)]) =>
      (new CounterBuilder()..update(updates)).build();

  _$Counter._({this.count, this.otherCount}) : super._() {
    if (count == null) throw new BuiltValueNullFieldError('Counter', 'count');
    if (otherCount == null)
      throw new BuiltValueNullFieldError('Counter', 'otherCount');
  }

  @override
  Counter rebuild(void updates(CounterBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CounterBuilder toBuilder() => new CounterBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Counter) return false;
    return count == other.count && otherCount == other.otherCount;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, count.hashCode), otherCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Counter')
          ..add('count', count)
          ..add('otherCount', otherCount))
        .toString();
  }
}

class CounterBuilder implements Builder<Counter, CounterBuilder> {
  _$Counter _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  int _otherCount;
  int get otherCount => _$this._otherCount;
  set otherCount(int otherCount) => _$this._otherCount = otherCount;

  CounterBuilder();

  CounterBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _otherCount = _$v.otherCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Counter other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Counter;
  }

  @override
  void update(void updates(CounterBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Counter build() {
    final _$result =
        _$v ?? new _$Counter._(count: count, otherCount: otherCount);
    replace(_$result);
    return _$result;
  }
}
