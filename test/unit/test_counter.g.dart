// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_counter;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$CounterActions extends CounterActions {
  factory _$CounterActions() => _$CounterActions._();
  _$CounterActions._() : super._();

  final increment = ActionDispatcher<int>('CounterActions-increment');
  final doubleIncrement =
      ActionDispatcher<int>('CounterActions-doubleIncrement');
  final incrementOther = ActionDispatcher<int>('CounterActions-incrementOther');

  final subCounterActions = SubCounterActions();
  final middlewareActions = MiddlewareActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
    doubleIncrement.setDispatcher(dispatcher);
    incrementOther.setDispatcher(dispatcher);

    subCounterActions.setDispatcher(dispatcher);
    middlewareActions.setDispatcher(dispatcher);
  }
}

class CounterActionsNames {
  static final increment = ActionName<int>('CounterActions-increment');
  static final doubleIncrement =
      ActionName<int>('CounterActions-doubleIncrement');
  static final incrementOther =
      ActionName<int>('CounterActions-incrementOther');
}

class _$SubCounterActions extends SubCounterActions {
  factory _$SubCounterActions() => _$SubCounterActions._();
  _$SubCounterActions._() : super._();

  final increment = ActionDispatcher<int>('SubCounterActions-increment');
  final doubleIt = ActionDispatcher<int>('SubCounterActions-doubleIt');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
    doubleIt.setDispatcher(dispatcher);
  }
}

class SubCounterActionsNames {
  static final increment = ActionName<int>('SubCounterActions-increment');
  static final doubleIt = ActionName<int>('SubCounterActions-doubleIt');
}

class _$MiddlewareActions extends MiddlewareActions {
  factory _$MiddlewareActions() => _$MiddlewareActions._();
  _$MiddlewareActions._() : super._();

  final doubleIt = ActionDispatcher<void>('MiddlewareActions-doubleIt');
  final tripleIt = ActionDispatcher<void>('MiddlewareActions-tripleIt');
  final timesSix = ActionDispatcher<void>('MiddlewareActions-timesSix');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    doubleIt.setDispatcher(dispatcher);
    tripleIt.setDispatcher(dispatcher);
    timesSix.setDispatcher(dispatcher);
  }
}

class MiddlewareActionsNames {
  static final doubleIt = ActionName<void>('MiddlewareActions-doubleIt');
  static final tripleIt = ActionName<void>('MiddlewareActions-tripleIt');
  static final timesSix = ActionName<void>('MiddlewareActions-timesSix');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Counter extends Counter {
  @override
  final int count;
  @override
  final int otherCount;
  @override
  final SubCounter subCounter;

  factory _$Counter([void Function(CounterBuilder) updates]) =>
      (new CounterBuilder()..update(updates)).build();

  _$Counter._({this.count, this.otherCount, this.subCounter}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('Counter', 'count');
    }
    if (otherCount == null) {
      throw new BuiltValueNullFieldError('Counter', 'otherCount');
    }
    if (subCounter == null) {
      throw new BuiltValueNullFieldError('Counter', 'subCounter');
    }
  }

  @override
  Counter rebuild(void Function(CounterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CounterBuilder toBuilder() => new CounterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Counter &&
        count == other.count &&
        otherCount == other.otherCount &&
        subCounter == other.subCounter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, count.hashCode), otherCount.hashCode), subCounter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Counter')
          ..add('count', count)
          ..add('otherCount', otherCount)
          ..add('subCounter', subCounter))
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

  SubCounterBuilder _subCounter;
  SubCounterBuilder get subCounter =>
      _$this._subCounter ??= new SubCounterBuilder();
  set subCounter(SubCounterBuilder subCounter) =>
      _$this._subCounter = subCounter;

  CounterBuilder();

  CounterBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _otherCount = _$v.otherCount;
      _subCounter = _$v.subCounter?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Counter other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Counter;
  }

  @override
  void update(void Function(CounterBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Counter build() {
    _$Counter _$result;
    try {
      _$result = _$v ??
          new _$Counter._(
              count: count,
              otherCount: otherCount,
              subCounter: subCounter.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subCounter';
        subCounter.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Counter', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubCounter extends SubCounter {
  @override
  final int subCount;

  factory _$SubCounter([void Function(SubCounterBuilder) updates]) =>
      (new SubCounterBuilder()..update(updates)).build();

  _$SubCounter._({this.subCount}) : super._() {
    if (subCount == null) {
      throw new BuiltValueNullFieldError('SubCounter', 'subCount');
    }
  }

  @override
  SubCounter rebuild(void Function(SubCounterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubCounterBuilder toBuilder() => new SubCounterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubCounter && subCount == other.subCount;
  }

  @override
  int get hashCode {
    return $jf($jc(0, subCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubCounter')
          ..add('subCount', subCount))
        .toString();
  }
}

class SubCounterBuilder implements Builder<SubCounter, SubCounterBuilder> {
  _$SubCounter _$v;

  int _subCount;
  int get subCount => _$this._subCount;
  set subCount(int subCount) => _$this._subCount = subCount;

  SubCounterBuilder();

  SubCounterBuilder get _$this {
    if (_$v != null) {
      _subCount = _$v.subCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubCounter other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubCounter;
  }

  @override
  void update(void Function(SubCounterBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubCounter build() {
    final _$result = _$v ?? new _$SubCounter._(subCount: subCount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
