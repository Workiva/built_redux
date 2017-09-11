// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_counter;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides
class _$BaseCounter extends BaseCounter {
  @override
  final int count;
  @override
  final BuiltList<int> indexOutOfRangeList;
  @override
  final NestedCounter nestedCounter;

  factory _$BaseCounter([void updates(BaseCounterBuilder b)]) =>
      (new BaseCounterBuilder()..update(updates)).build();

  _$BaseCounter._({this.count, this.indexOutOfRangeList, this.nestedCounter})
      : super._() {
    if (count == null) throw new ArgumentError.notNull('count');
    if (indexOutOfRangeList == null)
      throw new ArgumentError.notNull('indexOutOfRangeList');
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
    return count == other.count &&
        indexOutOfRangeList == other.indexOutOfRangeList &&
        nestedCounter == other.nestedCounter;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, count.hashCode), indexOutOfRangeList.hashCode),
        nestedCounter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseCounter')
          ..add('count', count)
          ..add('indexOutOfRangeList', indexOutOfRangeList)
          ..add('nestedCounter', nestedCounter))
        .toString();
  }
}

class BaseCounterBuilder implements Builder<BaseCounter, BaseCounterBuilder> {
  _$BaseCounter _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  ListBuilder<int> _indexOutOfRangeList;
  ListBuilder<int> get indexOutOfRangeList =>
      _$this._indexOutOfRangeList ??= new ListBuilder<int>();
  set indexOutOfRangeList(ListBuilder<int> indexOutOfRangeList) =>
      _$this._indexOutOfRangeList = indexOutOfRangeList;

  NestedCounterBuilder _nestedCounter;
  NestedCounterBuilder get nestedCounter =>
      _$this._nestedCounter ??= new NestedCounterBuilder();
  set nestedCounter(NestedCounterBuilder nestedCounter) =>
      _$this._nestedCounter = nestedCounter;

  BaseCounterBuilder();

  BaseCounterBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _indexOutOfRangeList = _$v.indexOutOfRangeList?.toBuilder();
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
    final _$result = _$v ??
        new _$BaseCounter._(
            count: count,
            indexOutOfRangeList: indexOutOfRangeList?.build(),
            nestedCounter: nestedCounter?.build());
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: annotate_overrides
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
    final _$result = _$v ?? new _$NestedCounter._(count: count);
    replace(_$result);
    return _$result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$BaseCounterActions extends BaseCounterActions {
  final MiddlewareActions middlewareActions = new MiddlewareActions();
  final NestedCounterActions nestedCounterActions = new NestedCounterActions();
  final ActionDispatcher<FooTypedef> foo =
      new ActionDispatcher<FooTypedef>('BaseCounterActions-foo');

  final ActionDispatcher<Null> incrementOne =
      new ActionDispatcher<Null>('BaseCounterActions-incrementOne');

  final ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('BaseCounterActions-decrement');

  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('BaseCounterActions-increment');
  factory _$BaseCounterActions() => new _$BaseCounterActions._();

  _$BaseCounterActions._() : super._();

  @override
  void syncWithStore(Dispatcher dispatcher) {
    middlewareActions.syncWithStore(dispatcher);
    nestedCounterActions.syncWithStore(dispatcher);
    foo.syncWithStore(dispatcher);
    incrementOne.syncWithStore(dispatcher);
    decrement.syncWithStore(dispatcher);
    increment.syncWithStore(dispatcher);
  }
}

class BaseCounterActionsNames {
  static final ActionName<FooTypedef> foo =
      new ActionName<FooTypedef>('BaseCounterActions-foo');
  static final ActionName<Null> incrementOne =
      new ActionName<Null>('BaseCounterActions-incrementOne');
  static final ActionName<int> decrement =
      new ActionName<int>('BaseCounterActions-decrement');
  static final ActionName<int> increment =
      new ActionName<int>('BaseCounterActions-increment');
}

abstract class BaseCounterReducer
    implements BuiltReducer<BaseCounter, BaseCounterBuilder> {
  Map<String, Reducer<dynamic, BaseCounter, BaseCounterBuilder>> get reducer =>
      null;

  void reduce(
      BaseCounter state, Action<dynamic> a, BaseCounterBuilder builder) {
    if (reducer != null) {
      final handler = reducer[a.name];
      if (handler != null) handler(state, a, builder);
    }
    reduceChildren(state, a, builder);
  }

  void reduceChildren(
      BaseCounter state, Action<dynamic> a, BaseCounterBuilder builder) {
    state.nestedCounter.reduce(state.nestedCounter, a, builder.nestedCounter);
  }
}

class _$NestedCounterActions extends NestedCounterActions {
  final ActionDispatcher<FooTypedef> fooTypedef =
      new ActionDispatcher<FooTypedef>('NestedCounterActions-fooTypedef');

  final ActionDispatcher<Null> incrementOne =
      new ActionDispatcher<Null>('NestedCounterActions-incrementOne');

  final ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('NestedCounterActions-decrement');

  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('NestedCounterActions-increment');
  factory _$NestedCounterActions() => new _$NestedCounterActions._();

  _$NestedCounterActions._() : super._();

  @override
  void syncWithStore(Dispatcher dispatcher) {
    fooTypedef.syncWithStore(dispatcher);
    incrementOne.syncWithStore(dispatcher);
    decrement.syncWithStore(dispatcher);
    increment.syncWithStore(dispatcher);
  }
}

class NestedCounterActionsNames {
  static final ActionName<FooTypedef> fooTypedef =
      new ActionName<FooTypedef>('NestedCounterActions-fooTypedef');
  static final ActionName<Null> incrementOne =
      new ActionName<Null>('NestedCounterActions-incrementOne');
  static final ActionName<int> decrement =
      new ActionName<int>('NestedCounterActions-decrement');
  static final ActionName<int> increment =
      new ActionName<int>('NestedCounterActions-increment');
}

abstract class NestedCounterReducer
    implements BuiltReducer<NestedCounter, NestedCounterBuilder> {
  Map<String, Reducer<dynamic, NestedCounter, NestedCounterBuilder>>
      get reducer => null;

  void reduce(
      NestedCounter state, Action<dynamic> a, NestedCounterBuilder builder) {
    if (reducer != null) {
      final handler = reducer[a.name];
      if (handler != null) handler(state, a, builder);
    }
    reduceChildren(state, a, builder);
  }

  void reduceChildren(
      NestedCounter state, Action<dynamic> a, NestedCounterBuilder builder) {}
}

class _$MiddlewareActions extends MiddlewareActions {
  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('MiddlewareActions-increment');
  factory _$MiddlewareActions() => new _$MiddlewareActions._();

  _$MiddlewareActions._() : super._();

  @override
  void syncWithStore(Dispatcher dispatcher) {
    increment.syncWithStore(dispatcher);
  }
}

class MiddlewareActionsNames {
  static final ActionName<int> increment =
      new ActionName<int>('MiddlewareActions-increment');
}
