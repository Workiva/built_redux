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

  factory _$BaseCounter([void updates(BaseCounterBuilder b)]) =>
      (new BaseCounterBuilder()..update(updates)).build();

  _$BaseCounter._({this.count, this.indexOutOfRangeList}) : super._() {
    if (count == null) throw new ArgumentError.notNull('count');
    if (indexOutOfRangeList == null)
      throw new ArgumentError.notNull('indexOutOfRangeList');
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
        indexOutOfRangeList == other.indexOutOfRangeList;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, count.hashCode), indexOutOfRangeList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BaseCounter')
          ..add('count', count)
          ..add('indexOutOfRangeList', indexOutOfRangeList))
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

  BaseCounterBuilder();

  BaseCounterBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _indexOutOfRangeList = _$v.indexOutOfRangeList?.toBuilder();
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
            count: count, indexOutOfRangeList: indexOutOfRangeList?.build());
    replace(_$result);
    return _$result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$BaseCounterActions extends BaseCounterActions {
  factory _$BaseCounterActions() => new _$BaseCounterActions._();
  _$BaseCounterActions._() : super._();

  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('BaseCounterActions-increment');
  final ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('BaseCounterActions-decrement');
  final MiddlewareActions middlewareActions = new MiddlewareActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
    decrement.setDispatcher(dispatcher);
    middlewareActions.setDispatcher(dispatcher);
  }
}

class BaseCounterActionsNames {
  static final ActionName<int> increment =
      new ActionName<int>('BaseCounterActions-increment');
  static final ActionName<int> decrement =
      new ActionName<int>('BaseCounterActions-decrement');
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
