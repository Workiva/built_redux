// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_counter.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$CounterActions extends CounterActions {
  factory _$CounterActions() => _$CounterActions._();
  _$CounterActions._() : super._();

  final increment = ActionDispatcher<int>('CounterActions-increment');
  final incrementOther = ActionDispatcher<int>('CounterActions-incrementOther');

  final subCounterActions = SubCounterActions();
  final middlewareActions = MiddlewareActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
    incrementOther.setDispatcher(dispatcher);

    subCounterActions.setDispatcher(dispatcher);
    middlewareActions.setDispatcher(dispatcher);
  }
}

class CounterActionsNames {
  static final increment = ActionName<int>('CounterActions-increment');
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

  final doubleIt = ActionDispatcher<int>('MiddlewareActions-doubleIt');
  final tripleIt = ActionDispatcher<int>('MiddlewareActions-tripleIt');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    doubleIt.setDispatcher(dispatcher);
    tripleIt.setDispatcher(dispatcher);
  }
}

class MiddlewareActionsNames {
  static final doubleIt = ActionName<int>('MiddlewareActions-doubleIt');
  static final tripleIt = ActionName<int>('MiddlewareActions-tripleIt');
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

  factory _$Counter([void Function(CounterBuilder)? updates]) =>
      (CounterBuilder()..update(updates))._build();

  _$Counter._(
      {required this.count, required this.otherCount, required this.subCounter})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(count, r'Counter', 'count');
    BuiltValueNullFieldError.checkNotNull(otherCount, r'Counter', 'otherCount');
    BuiltValueNullFieldError.checkNotNull(subCounter, r'Counter', 'subCounter');
  }

  @override
  Counter rebuild(void Function(CounterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CounterBuilder toBuilder() => CounterBuilder()..replace(this);

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
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, otherCount.hashCode);
    _$hash = $jc(_$hash, subCounter.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Counter')
          ..add('count', count)
          ..add('otherCount', otherCount)
          ..add('subCounter', subCounter))
        .toString();
  }
}

class CounterBuilder implements Builder<Counter, CounterBuilder> {
  _$Counter? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  int? _otherCount;
  int? get otherCount => _$this._otherCount;
  set otherCount(int? otherCount) => _$this._otherCount = otherCount;

  SubCounterBuilder? _subCounter;
  SubCounterBuilder get subCounter =>
      _$this._subCounter ??= SubCounterBuilder();
  set subCounter(SubCounterBuilder? subCounter) =>
      _$this._subCounter = subCounter;

  CounterBuilder();

  CounterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _otherCount = $v.otherCount;
      _subCounter = $v.subCounter.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Counter other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Counter;
  }

  @override
  void update(void Function(CounterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Counter build() => _build();

  _$Counter _build() {
    _$Counter _$result;
    try {
      _$result = _$v ??
          _$Counter._(
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'Counter', 'count'),
              otherCount: BuiltValueNullFieldError.checkNotNull(
                  otherCount, r'Counter', 'otherCount'),
              subCounter: subCounter.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subCounter';
        subCounter.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Counter', _$failedField, e.toString());
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

  factory _$SubCounter([void Function(SubCounterBuilder)? updates]) =>
      (SubCounterBuilder()..update(updates))._build();

  _$SubCounter._({required this.subCount}) : super._() {
    BuiltValueNullFieldError.checkNotNull(subCount, r'SubCounter', 'subCount');
  }

  @override
  SubCounter rebuild(void Function(SubCounterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubCounterBuilder toBuilder() => SubCounterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubCounter && subCount == other.subCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubCounter')
          ..add('subCount', subCount))
        .toString();
  }
}

class SubCounterBuilder implements Builder<SubCounter, SubCounterBuilder> {
  _$SubCounter? _$v;

  int? _subCount;
  int? get subCount => _$this._subCount;
  set subCount(int? subCount) => _$this._subCount = subCount;

  SubCounterBuilder();

  SubCounterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subCount = $v.subCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubCounter other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubCounter;
  }

  @override
  void update(void Function(SubCounterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubCounter build() => _build();

  _$SubCounter _build() {
    final _$result = _$v ??
        _$SubCounter._(
            subCount: BuiltValueNullFieldError.checkNotNull(
                subCount, r'SubCounter', 'subCount'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
