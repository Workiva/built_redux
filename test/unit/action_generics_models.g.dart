// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_generics_models.dart';

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
      (ActionGenericsBuilder()..update(updates))._build();

  _$ActionGenerics._({required this.count}) : super._() {
    BuiltValueNullFieldError.checkNotNull(count, r'ActionGenerics', 'count');
  }

  @override
  ActionGenerics rebuild(void Function(ActionGenericsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActionGenericsBuilder toBuilder() => ActionGenericsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActionGenerics && count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
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
        _$ActionGenerics._(
            count: BuiltValueNullFieldError.checkNotNull(
                count, r'ActionGenerics', 'count'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
