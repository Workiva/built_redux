// GENERATED CODE - DO NOT MODIFY BY HAND

part of inheritance_test_models;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$ChildActions extends ChildActions {
  factory _$ChildActions() => _$ChildActions._();
  _$ChildActions._() : super._();

  final childAction = ActionDispatcher<Null>('ChildActions-childAction');
  final parentAction = ActionDispatcher<Null>('ParentActions-parentAction');
  final grandparentAction =
      ActionDispatcher<Null>('GrandparentActions-grandparentAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    childAction.setDispatcher(dispatcher);
    parentAction.setDispatcher(dispatcher);
    grandparentAction.setDispatcher(dispatcher);
  }
}

class ChildActionsNames {
  static final childAction = ActionName<Null>('ChildActions-childAction');
  static final parentAction = ActionName<Null>('ParentActions-parentAction');
  static final grandparentAction =
      ActionName<Null>('GrandparentActions-grandparentAction');
}

class ParentActionsNames {
  static final parentAction = ActionName<Null>('ParentActions-parentAction');
  static final grandparentAction =
      ActionName<Null>('GrandparentActions-grandparentAction');
}

class GrandparentActionsNames {
  static final grandparentAction =
      ActionName<Null>('GrandparentActions-grandparentAction');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class ParentBuilder {
  void replace(Parent other);
  void update(void Function(ParentBuilder) updates);
  int? get parentCount;
  set parentCount(int? parentCount);
}

abstract class GrandparentBuilder {
  void replace(Grandparent other);
  void update(void Function(GrandparentBuilder) updates);
  int? get grandparentCount;
  set grandparentCount(int? grandparentCount);
}

class _$Child extends Child {
  @override
  final int childCount;
  @override
  final int parentCount;
  @override
  final int grandparentCount;

  factory _$Child([void Function(ChildBuilder)? updates]) =>
      (new ChildBuilder()..update(updates)).build();

  _$Child._(
      {required this.childCount,
      required this.parentCount,
      required this.grandparentCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(childCount, 'Child', 'childCount');
    BuiltValueNullFieldError.checkNotNull(parentCount, 'Child', 'parentCount');
    BuiltValueNullFieldError.checkNotNull(
        grandparentCount, 'Child', 'grandparentCount');
  }

  @override
  Child rebuild(void Function(ChildBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChildBuilder toBuilder() => new ChildBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Child &&
        childCount == other.childCount &&
        parentCount == other.parentCount &&
        grandparentCount == other.grandparentCount;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, childCount.hashCode), parentCount.hashCode),
        grandparentCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Child')
          ..add('childCount', childCount)
          ..add('parentCount', parentCount)
          ..add('grandparentCount', grandparentCount))
        .toString();
  }
}

class ChildBuilder
    implements Builder<Child, ChildBuilder>, ParentBuilder, GrandparentBuilder {
  _$Child? _$v;

  int? _childCount;
  int? get childCount => _$this._childCount;
  set childCount(covariant int? childCount) => _$this._childCount = childCount;

  int? _parentCount;
  int? get parentCount => _$this._parentCount;
  set parentCount(covariant int? parentCount) =>
      _$this._parentCount = parentCount;

  int? _grandparentCount;
  int? get grandparentCount => _$this._grandparentCount;
  set grandparentCount(covariant int? grandparentCount) =>
      _$this._grandparentCount = grandparentCount;

  ChildBuilder();

  ChildBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _childCount = $v.childCount;
      _parentCount = $v.parentCount;
      _grandparentCount = $v.grandparentCount;
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant Child other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Child;
  }

  @override
  void update(void Function(ChildBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Child build() {
    final _$result = _$v ??
        new _$Child._(
            childCount: BuiltValueNullFieldError.checkNotNull(
                childCount, 'Child', 'childCount'),
            parentCount: BuiltValueNullFieldError.checkNotNull(
                parentCount, 'Child', 'parentCount'),
            grandparentCount: BuiltValueNullFieldError.checkNotNull(
                grandparentCount, 'Child', 'grandparentCount'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
