// GENERATED CODE - DO NOT MODIFY BY HAND

part of test_counter;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

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
  final ActionDispatcher<int> appendToNestedList =
      new ActionDispatcher<int>('BaseCounterActions-appendToNestedList');

  final ActionDispatcher<Map<String, List<int>>> genericAction2 =
      new ActionDispatcher<Map<String, List<int>>>(
          'BaseCounterActions-genericAction2');

  final ActionDispatcher<List<int>> genericAction1 =
      new ActionDispatcher<List<int>>('BaseCounterActions-genericAction1');

  final ActionDispatcher<
          ThunkTypedef<BaseCounter, BaseCounterBuilder, BaseCounterActions>>
      thunkDispatcher = new ActionDispatcher<
          ThunkTypedef<BaseCounter, BaseCounterBuilder,
              BaseCounterActions>>('BaseCounterActions-thunkDispatcher');

  final ActionDispatcher<Null> incrementOne =
      new ActionDispatcher<Null>('BaseCounterActions-incrementOne');

  final ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('BaseCounterActions-decrement');

  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('BaseCounterActions-increment');
  factory _$BaseCounterActions() => new _$BaseCounterActions._();

  _$BaseCounterActions._() : super._();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    middlewareActions.setDispatcher(dispatcher);
    nestedCounterActions.setDispatcher(dispatcher);
    appendToNestedList.setDispatcher(dispatcher);
    genericAction2.setDispatcher(dispatcher);
    genericAction1.setDispatcher(dispatcher);
    thunkDispatcher.setDispatcher(dispatcher);
    incrementOne.setDispatcher(dispatcher);
    decrement.setDispatcher(dispatcher);
    increment.setDispatcher(dispatcher);
  }
}

class BaseCounterActionsNames {
  static final ActionName<int> appendToNestedList =
      new ActionName<int>('BaseCounterActions-appendToNestedList');
  static final ActionName<Map<String, List<int>>> genericAction2 =
      new ActionName<Map<String, List<int>>>(
          'BaseCounterActions-genericAction2');
  static final ActionName<List<int>> genericAction1 =
      new ActionName<List<int>>('BaseCounterActions-genericAction1');
  static final ActionName<
          ThunkTypedef<BaseCounter, BaseCounterBuilder, BaseCounterActions>>
      thunkDispatcher = new ActionName<
          ThunkTypedef<BaseCounter, BaseCounterBuilder,
              BaseCounterActions>>('BaseCounterActions-thunkDispatcher');
  static final ActionName<Null> incrementOne =
      new ActionName<Null>('BaseCounterActions-incrementOne');
  static final ActionName<int> decrement =
      new ActionName<int>('BaseCounterActions-decrement');
  static final ActionName<int> increment =
      new ActionName<int>('BaseCounterActions-increment');
}

class _$NestedCounterActions extends NestedCounterActions {
  final ActionDispatcher<
          ThunkTypedef<BaseCounter, BaseCounterBuilder, BaseCounterActions>>
      thunkDispatcher = new ActionDispatcher<
          ThunkTypedef<BaseCounter, BaseCounterBuilder,
              BaseCounterActions>>('NestedCounterActions-thunkDispatcher');

  final ActionDispatcher<Null> incrementOne =
      new ActionDispatcher<Null>('NestedCounterActions-incrementOne');

  final ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('NestedCounterActions-decrement');

  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('NestedCounterActions-increment');
  factory _$NestedCounterActions() => new _$NestedCounterActions._();

  _$NestedCounterActions._() : super._();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    thunkDispatcher.setDispatcher(dispatcher);
    incrementOne.setDispatcher(dispatcher);
    decrement.setDispatcher(dispatcher);
    increment.setDispatcher(dispatcher);
  }
}

class NestedCounterActionsNames {
  static final ActionName<
          ThunkTypedef<BaseCounter, BaseCounterBuilder, BaseCounterActions>>
      thunkDispatcher = new ActionName<
          ThunkTypedef<BaseCounter, BaseCounterBuilder,
              BaseCounterActions>>('NestedCounterActions-thunkDispatcher');
  static final ActionName<Null> incrementOne =
      new ActionName<Null>('NestedCounterActions-incrementOne');
  static final ActionName<int> decrement =
      new ActionName<int>('NestedCounterActions-decrement');
  static final ActionName<int> increment =
      new ActionName<int>('NestedCounterActions-increment');
}

class _$MiddlewareActions extends MiddlewareActions {
  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('MiddlewareActions-increment');
  factory _$MiddlewareActions() => new _$MiddlewareActions._();

  _$MiddlewareActions._() : super._();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
  }
}

class MiddlewareActionsNames {
  static final ActionName<int> increment =
      new ActionName<int>('MiddlewareActions-increment');
}
