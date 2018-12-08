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

  final ActionDispatcher<int> intAction =
      new ActionDispatcher<int>('ActionGenericsActions-intAction');
  final ActionDispatcher<Null> nullAction =
      new ActionDispatcher<Null>('ActionGenericsActions-nullAction');
  final ActionDispatcher<List<int>> listIntAction =
      new ActionDispatcher<List<int>>('ActionGenericsActions-listIntAction');
  final ActionDispatcher<Map<String, List<int>>> mapStringToListIntAction =
      new ActionDispatcher<Map<String, List<int>>>(
          'ActionGenericsActions-mapStringToListIntAction');
  final ActionDispatcher<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>> typdefAction = new ActionDispatcher<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>>('ActionGenericsActions-typdefAction');
  final ActionDispatcher<Foo<int>> fooAction =
      new ActionDispatcher<Foo<int>>('ActionGenericsActions-fooAction');
  final ActionDispatcher<ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>
      classWithBuiltAction = new ActionDispatcher<
              ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>(
          'ActionGenericsActions-classWithBuiltAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    intAction.setDispatcher(dispatcher);
    nullAction.setDispatcher(dispatcher);
    listIntAction.setDispatcher(dispatcher);
    mapStringToListIntAction.setDispatcher(dispatcher);
    typdefAction.setDispatcher(dispatcher);
    fooAction.setDispatcher(dispatcher);
    classWithBuiltAction.setDispatcher(dispatcher);
  }
}

class ActionGenericsActionsNames {
  static final ActionName<int> intAction =
      new ActionName<int>('ActionGenericsActions-intAction');
  static final ActionName<Null> nullAction =
      new ActionName<Null>('ActionGenericsActions-nullAction');
  static final ActionName<List<int>> listIntAction =
      new ActionName<List<int>>('ActionGenericsActions-listIntAction');
  static final ActionName<Map<String, List<int>>> mapStringToListIntAction =
      new ActionName<Map<String, List<int>>>(
          'ActionGenericsActions-mapStringToListIntAction');
  static final ActionName<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>> typdefAction = new ActionName<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>>('ActionGenericsActions-typdefAction');
  static final ActionName<Foo<int>> fooAction =
      new ActionName<Foo<int>>('ActionGenericsActions-fooAction');
  static final ActionName<ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>
      classWithBuiltAction =
      new ActionName<ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>(
          'ActionGenericsActions-classWithBuiltAction');
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
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

class _$ActionGenerics extends ActionGenerics {
  @override
  final int count;

  factory _$ActionGenerics([void updates(ActionGenericsBuilder b)]) =>
      (new ActionGenericsBuilder()..update(updates)).build();

  _$ActionGenerics._({this.count}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('ActionGenerics', 'count');
    }
  }

  @override
  ActionGenerics rebuild(void updates(ActionGenericsBuilder b)) =>
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
  void update(void updates(ActionGenericsBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ActionGenerics build() {
    final _$result = _$v ?? new _$ActionGenerics._(count: count);
    replace(_$result);
    return _$result;
  }
}
