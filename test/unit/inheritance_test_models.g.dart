// GENERATED CODE - DO NOT MODIFY BY HAND

part of inheritance_test_models;

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

abstract class ParentBuilder {
  void replace(Parent other);
  void update(void updates(ParentBuilder b));
  int get parentCount;
  set parentCount(int parentCount);
}

abstract class GrandparentBuilder {
  void replace(Grandparent other);
  void update(void updates(GrandparentBuilder b));
  int get grandparentCount;
  set grandparentCount(int grandparentCount);
}

class _$Child extends Child {
  @override
  final int childCount;
  @override
  final int parentCount;
  @override
  final int grandparentCount;

  factory _$Child([void updates(ChildBuilder b)]) =>
      (new ChildBuilder()..update(updates)).build();

  _$Child._({this.childCount, this.parentCount, this.grandparentCount})
      : super._() {
    if (childCount == null)
      throw new BuiltValueNullFieldError('Child', 'childCount');
    if (parentCount == null)
      throw new BuiltValueNullFieldError('Child', 'parentCount');
    if (grandparentCount == null)
      throw new BuiltValueNullFieldError('Child', 'grandparentCount');
  }

  @override
  Child rebuild(void updates(ChildBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ChildBuilder toBuilder() => new ChildBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Child) return false;
    return childCount == other.childCount &&
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
  _$Child _$v;

  int _childCount;
  int get childCount => _$this._childCount;
  set childCount(int childCount) => _$this._childCount = childCount;

  int _parentCount;
  int get parentCount => _$this._parentCount;
  set parentCount(int parentCount) => _$this._parentCount = parentCount;

  int _grandparentCount;
  int get grandparentCount => _$this._grandparentCount;
  set grandparentCount(int grandparentCount) =>
      _$this._grandparentCount = grandparentCount;

  ChildBuilder();

  ChildBuilder get _$this {
    if (_$v != null) {
      _childCount = _$v.childCount;
      _parentCount = _$v.parentCount;
      _grandparentCount = _$v.grandparentCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant Child other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Child;
  }

  @override
  void update(void updates(ChildBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Child build() {
    final _$result = _$v ??
        new _$Child._(
            childCount: childCount,
            parentCount: parentCount,
            grandparentCount: grandparentCount);
    replace(_$result);
    return _$result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$ChildActions extends ChildActions {
  factory _$ChildActions() => new _$ChildActions._();
  _$ChildActions._() : super._();

  final ActionDispatcher<Null> childAction =
      new ActionDispatcher<Null>('ChildActions-childAction');
  final ActionDispatcher<Null> parentAction =
      new ActionDispatcher<Null>('ParentActions-parentAction');
  final ActionDispatcher<Null> grandparentAction =
      new ActionDispatcher<Null>('GrandparentActions-grandparentAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    childAction.setDispatcher(dispatcher);
    parentAction.setDispatcher(dispatcher);
    grandparentAction.setDispatcher(dispatcher);
  }
}

class ChildActionsNames {
  static final ActionName<Null> childAction =
      new ActionName<Null>('ChildActions-childAction');
  static final ActionName<Null> parentAction =
      new ActionName<Null>('ParentActions-parentAction');
  static final ActionName<Null> grandparentAction =
      new ActionName<Null>('GrandparentActions-grandparentAction');
}

class ParentActionsNames {
  static final ActionName<Null> parentAction =
      new ActionName<Null>('ParentActions-parentAction');
  static final ActionName<Null> grandparentAction =
      new ActionName<Null>('GrandparentActions-grandparentAction');
}

class GrandparentActionsNames {
  static final ActionName<Null> grandparentAction =
      new ActionName<Null>('GrandparentActions-grandparentAction');
}
