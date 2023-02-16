// GENERATED CODE - DO NOT MODIFY BY HAND

part of action_generics_models;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$ActionGenericsActions extends ActionGenericsActions {
  factory _$ActionGenericsActions() => _$ActionGenericsActions._();
  _$ActionGenericsActions._() : super._();

  final intAction = ActionDispatcher<int>('ActionGenericsActions-intAction');
  final nullAction = ActionDispatcher<Null>('ActionGenericsActions-nullAction');
  final nullableIntAction =
      ActionDispatcher<int?>('ActionGenericsActions-nullableIntAction');
  final setIntAction =
      ActionDispatcher<Set<int>>('ActionGenericsActions-setIntAction');
  final nullableSetIntAction =
      ActionDispatcher<Set<int>?>('ActionGenericsActions-nullableSetIntAction');
  final listIntAction =
      ActionDispatcher<List<int>>('ActionGenericsActions-listIntAction');
  final mapStringToListIntAction = ActionDispatcher<Map<String, List<int>>>(
      'ActionGenericsActions-mapStringToListIntAction');
  final typdefAction = ActionDispatcher<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>>('ActionGenericsActions-typdefAction');
  final typdefNullableAction = ActionDispatcher<
          ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
              ActionGenericsActions>?>(
      'ActionGenericsActions-typdefNullableAction');
  final fooAction =
      ActionDispatcher<Foo<int>>('ActionGenericsActions-fooAction');
  final fooActionWithNestedNullable = ActionDispatcher<Foo<int?>>(
      'ActionGenericsActions-fooActionWithNestedNullable');
  final classWithBuiltAction =
      ActionDispatcher<ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>(
          'ActionGenericsActions-classWithBuiltAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    intAction.setDispatcher(dispatcher);
    nullAction.setDispatcher(dispatcher);
    nullableIntAction.setDispatcher(dispatcher);
    setIntAction.setDispatcher(dispatcher);
    nullableSetIntAction.setDispatcher(dispatcher);
    listIntAction.setDispatcher(dispatcher);
    mapStringToListIntAction.setDispatcher(dispatcher);
    typdefAction.setDispatcher(dispatcher);
    typdefNullableAction.setDispatcher(dispatcher);
    fooAction.setDispatcher(dispatcher);
    fooActionWithNestedNullable.setDispatcher(dispatcher);
    classWithBuiltAction.setDispatcher(dispatcher);
  }
}

class ActionGenericsActionsNames {
  static final intAction = ActionName<int>('ActionGenericsActions-intAction');
  static final nullAction =
      ActionName<Null>('ActionGenericsActions-nullAction');
  static final nullableIntAction =
      ActionName<int?>('ActionGenericsActions-nullableIntAction');
  static final setIntAction =
      ActionName<Set<int>>('ActionGenericsActions-setIntAction');
  static final nullableSetIntAction =
      ActionName<Set<int>?>('ActionGenericsActions-nullableSetIntAction');
  static final listIntAction =
      ActionName<List<int>>('ActionGenericsActions-listIntAction');
  static final mapStringToListIntAction = ActionName<Map<String, List<int>>>(
      'ActionGenericsActions-mapStringToListIntAction');
  static final typdefAction = ActionName<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>>('ActionGenericsActions-typdefAction');
  static final typdefNullableAction = ActionName<
          ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
              ActionGenericsActions>?>(
      'ActionGenericsActions-typdefNullableAction');
  static final fooAction =
      ActionName<Foo<int>>('ActionGenericsActions-fooAction');
  static final fooActionWithNestedNullable = ActionName<Foo<int?>>(
      'ActionGenericsActions-fooActionWithNestedNullable');
  static final classWithBuiltAction =
      ActionName<ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>(
          'ActionGenericsActions-classWithBuiltAction');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActionGenerics extends ActionGenerics {
  @override
  final int count;

  factory _$ActionGenerics([void Function(ActionGenericsBuilder)? updates]) =>
      (new ActionGenericsBuilder()..update(updates))._build();

  _$ActionGenerics._({required this.count}) : super._() {
    BuiltValueNullFieldError.checkNotNull(count, r'ActionGenerics', 'count');
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
    return (newBuiltValueToStringHelper(r'ActionGenerics')..add('count', count))
        .toString();
  }
}

class ActionGenericsBuilder
    implements Builder<ActionGenerics, ActionGenericsBuilder> {
  _$ActionGenerics? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  ActionGenericsBuilder();

  ActionGenericsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActionGenerics other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ActionGenerics;
  }

  @override
  void update(void Function(ActionGenericsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActionGenerics build() => _build();

  _$ActionGenerics _build() {
    final _$result = _$v ??
        new _$ActionGenerics._(
            count: BuiltValueNullFieldError.checkNotNull(
                count, r'ActionGenerics', 'count'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
