// GENERATED CODE - DO NOT MODIFY BY HAND

part of action_generics_models;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides

class _$ActionGenericsActions extends ActionGenericsActions {
  factory _$ActionGenericsActions() => new _$ActionGenericsActions._();
  _$ActionGenericsActions._() : super._();

  final intAction =
      new ActionDispatcher<int>('ActionGenericsActions-intAction');
  final nullAction =
      new ActionDispatcher<Null>('ActionGenericsActions-nullAction');
  final setIntAction =
      new ActionDispatcher<Set<int>>('ActionGenericsActions-setIntAction');
  final listIntAction =
      new ActionDispatcher<List<int>>('ActionGenericsActions-listIntAction');
  final mapStringToListIntAction = new ActionDispatcher<Map<String, List<int>>>(
      'ActionGenericsActions-mapStringToListIntAction');
  final typdefAction = new ActionDispatcher<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>>('ActionGenericsActions-typdefAction');
  final fooAction =
      new ActionDispatcher<Foo<int>>('ActionGenericsActions-fooAction');
  final classWithBuiltAction = new ActionDispatcher<
          ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>(
      'ActionGenericsActions-classWithBuiltAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    intAction.setDispatcher(dispatcher);
    nullAction.setDispatcher(dispatcher);
    setIntAction.setDispatcher(dispatcher);
    listIntAction.setDispatcher(dispatcher);
    mapStringToListIntAction.setDispatcher(dispatcher);
    typdefAction.setDispatcher(dispatcher);
    fooAction.setDispatcher(dispatcher);
    classWithBuiltAction.setDispatcher(dispatcher);
  }
}

class ActionGenericsActionsNames {
  static final ActionName<int> intAction =
      new ActionName('ActionGenericsActions-intAction');
  static final ActionName<Null> nullAction =
      new ActionName('ActionGenericsActions-nullAction');
  static final ActionName<Set<int>> setIntAction =
      new ActionName('ActionGenericsActions-setIntAction');
  static final ActionName<List<int>> listIntAction =
      new ActionName('ActionGenericsActions-listIntAction');
  static final ActionName<Map<String, List<int>>> mapStringToListIntAction =
      new ActionName('ActionGenericsActions-mapStringToListIntAction');
  static final ActionName<
          ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
              ActionGenericsActions>> typdefAction =
      new ActionName('ActionGenericsActions-typdefAction');
  static final ActionName<Foo<int>> fooAction =
      new ActionName('ActionGenericsActions-fooAction');
  static final ActionName<ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>
      classWithBuiltAction =
      new ActionName('ActionGenericsActions-classWithBuiltAction');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActionGenerics extends ActionGenerics {
  @override
  final int count;

  factory _$ActionGenerics([void Function(ActionGenericsBuilder) updates]) =>
      (new ActionGenericsBuilder()..update(updates)).build();

  _$ActionGenerics._({this.count}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('ActionGenerics', 'count');
    }
  }

  @override
  ActionGenerics rebuild(void Function(ActionGenericsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActionGenericsBuilder toBuilder() =>
      new ActionGenericsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActionGenerics && count == other.count;
  }

  @override
  int get hashCode {
    return $jf($jc(0, count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ActionGenerics')..add('count', count))
        .toString();
  }
}

class ActionGenericsBuilder
    implements Builder<ActionGenerics, ActionGenericsBuilder> {
  _$ActionGenerics _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  ActionGenericsBuilder();

  ActionGenericsBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActionGenerics other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ActionGenerics;
  }

  @override
  void update(void Function(ActionGenericsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ActionGenerics build() {
    final _$result = _$v ?? new _$ActionGenerics._(count: count);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
