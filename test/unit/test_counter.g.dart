// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_counter;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class BaseCounterActions
// **************************************************************************

class _$BaseCounterActions extends BaseCounterActions {
  MiddlewareActions middlewareActions = new MiddlewareActions();
  NestedCounterActions nestedCounterActions = new NestedCounterActions();
  ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('BaseCounterActions-decrement');

  ActionDispatcher<int> increment =
      new ActionDispatcher<int>('BaseCounterActions-increment');
  factory _$BaseCounterActions() => new _$BaseCounterActions._();
  _$BaseCounterActions._() : super._();
  syncWithStore(dispatcher) {
    middlewareActions.syncWithStore(dispatcher);
    nestedCounterActions.syncWithStore(dispatcher);
    decrement.syncWithStore(dispatcher);
    increment.syncWithStore(dispatcher);
  }
}

class BaseCounterActionsNames {
  static ActionName decrement =
      new ActionName<int>('BaseCounterActions-decrement');
  static ActionName increment =
      new ActionName<int>('BaseCounterActions-increment');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class BaseCounter
// **************************************************************************

class _$BaseCounter extends BaseCounter {
  @override
  final int count;
  @override
  final NestedCounter nestedCounter;

  factory _$BaseCounter([void updates(BaseCounterBuilder b)]) =>
      (new BaseCounterBuilder()..update(updates)).build();

  _$BaseCounter._({this.count, this.nestedCounter}) : super._() {
    if (count == null) throw new ArgumentError.notNull('count');
    if (nestedCounter == null) throw new ArgumentError.notNull('nestedCounter');
  }

  @override
  BaseCounter rebuild(void updates(BaseCounterBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseCounterBuilder toBuilder() => new BaseCounterBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! BaseCounter) return false;
    return count == other.count && nestedCounter == other.nestedCounter;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, count.hashCode), nestedCounter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseCounter')
          ..add('count', count)
          ..add('nestedCounter', nestedCounter))
        .toString();
  }
}

class BaseCounterBuilder implements Builder<BaseCounter, BaseCounterBuilder> {
  _$BaseCounter _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  NestedCounterBuilder _nestedCounter;
  NestedCounterBuilder get nestedCounter =>
      _$this._nestedCounter ??= new NestedCounterBuilder();
  set nestedCounter(NestedCounterBuilder nestedCounter) =>
      _$this._nestedCounter = nestedCounter;

  BaseCounterBuilder();

  BaseCounterBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _nestedCounter = _$v.nestedCounter?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseCounter other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$BaseCounter;
  }

  @override
  void update(void updates(BaseCounterBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BaseCounter build() {
    final result = _$v ??
        new _$BaseCounter._(
            count: count, nestedCounter: nestedCounter?.build());
    replace(result);
    return result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class BaseCounter
// **************************************************************************

class BaseCounterReduceChildren {
  reduceChildren(
      BaseCounter state, Action<dynamic> a, BaseCounterBuilder builder) {
    state.nestedCounter.reduce(state.nestedCounter, a, builder.nestedCounter);
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class NestedCounterActions
// **************************************************************************

class _$NestedCounterActions extends NestedCounterActions {
  ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('NestedCounterActions-decrement');

  ActionDispatcher<int> increment =
      new ActionDispatcher<int>('NestedCounterActions-increment');
  factory _$NestedCounterActions() => new _$NestedCounterActions._();
  _$NestedCounterActions._() : super._();
  syncWithStore(dispatcher) {
    decrement.syncWithStore(dispatcher);
    increment.syncWithStore(dispatcher);
  }
}

class NestedCounterActionsNames {
  static ActionName decrement =
      new ActionName<int>('NestedCounterActions-decrement');
  static ActionName increment =
      new ActionName<int>('NestedCounterActions-increment');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class NestedCounter
// **************************************************************************

class _$NestedCounter extends NestedCounter {
  @override
  final int count;

  factory _$NestedCounter([void updates(NestedCounterBuilder b)]) =>
      (new NestedCounterBuilder()..update(updates)).build();

  _$NestedCounter._({this.count}) : super._() {
    if (count == null) throw new ArgumentError.notNull('count');
  }

  @override
  NestedCounter rebuild(void updates(NestedCounterBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  NestedCounterBuilder toBuilder() => new NestedCounterBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! NestedCounter) return false;
    return count == other.count;
  }

  @override
  int get hashCode {
    return $jf($jc(0, count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NestedCounter')..add('count', count))
        .toString();
  }
}

class NestedCounterBuilder
    implements Builder<NestedCounter, NestedCounterBuilder> {
  _$NestedCounter _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  NestedCounterBuilder();

  NestedCounterBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NestedCounter other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$NestedCounter;
  }

  @override
  void update(void updates(NestedCounterBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$NestedCounter build() {
    final result = _$v ?? new _$NestedCounter._(count: count);
    replace(result);
    return result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class MiddlewareActions
// **************************************************************************

class _$MiddlewareActions extends MiddlewareActions {
  ActionDispatcher<int> increment =
      new ActionDispatcher<int>('MiddlewareActions-increment');
  factory _$MiddlewareActions() => new _$MiddlewareActions._();
  _$MiddlewareActions._() : super._();
  syncWithStore(dispatcher) {
    increment.syncWithStore(dispatcher);
  }
}

class MiddlewareActionsNames {
  static ActionName increment =
      new ActionName<int>('MiddlewareActions-increment');
}
