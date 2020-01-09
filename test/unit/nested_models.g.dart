// GENERATED CODE - DO NOT MODIFY BY HAND

part of nested_models;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$BaseActions extends BaseActions {
  factory _$BaseActions() => new _$BaseActions._();
  _$BaseActions._() : super._();

  final baseAction = new ActionDispatcher<Null>('BaseActions-baseAction');

  final child = new ChildActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    baseAction.setDispatcher(dispatcher);

    child.setDispatcher(dispatcher);
  }
}

class BaseActionsNames {
  static final baseAction = new ActionName<Null>('BaseActions-baseAction');
}

class _$ChildActions extends ChildActions {
  factory _$ChildActions() => new _$ChildActions._();
  _$ChildActions._() : super._();

  final childAction = new ActionDispatcher<Null>('ChildActions-childAction');

  final grandchild = new GrandchildActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    childAction.setDispatcher(dispatcher);

    grandchild.setDispatcher(dispatcher);
  }
}

class ChildActionsNames {
  static final childAction = new ActionName<Null>('ChildActions-childAction');
}

class _$GrandchildActions extends GrandchildActions {
  factory _$GrandchildActions() => new _$GrandchildActions._();
  _$GrandchildActions._() : super._();

  final grandchildAction =
      new ActionDispatcher<Null>('GrandchildActions-grandchildAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    grandchildAction.setDispatcher(dispatcher);
  }
}

class GrandchildActionsNames {
  static final grandchildAction =
      new ActionName<Null>('GrandchildActions-grandchildAction');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Base extends Base {
  @override
  final int count;
  @override
  final Child child;

  factory _$Base([void Function(BaseBuilder) updates]) =>
      (new BaseBuilder()..update(updates)).build();

  _$Base._({this.count, this.child}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('Base', 'count');
    }
    if (child == null) {
      throw new BuiltValueNullFieldError('Base', 'child');
    }
  }

  @override
  Base rebuild(void Function(BaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseBuilder toBuilder() => new BaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Base && count == other.count && child == other.child;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, count.hashCode), child.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Base')
          ..add('count', count)
          ..add('child', child))
        .toString();
  }
}

class BaseBuilder implements Builder<Base, BaseBuilder> {
  _$Base _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  ChildBuilder _child;
  ChildBuilder get child => _$this._child ??= new ChildBuilder();
  set child(ChildBuilder child) => _$this._child = child;

  BaseBuilder();

  BaseBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _child = _$v.child?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Base other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Base;
  }

  @override
  void update(void Function(BaseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Base build() {
    _$Base _$result;
    try {
      _$result = _$v ?? new _$Base._(count: count, child: child.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'child';
        child.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Base', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Child extends Child {
  @override
  final int count;
  @override
  final Grandchild grandchild;

  factory _$Child([void Function(ChildBuilder) updates]) =>
      (new ChildBuilder()..update(updates)).build();

  _$Child._({this.count, this.grandchild}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('Child', 'count');
    }
    if (grandchild == null) {
      throw new BuiltValueNullFieldError('Child', 'grandchild');
    }
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
        count == other.count &&
        grandchild == other.grandchild;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, count.hashCode), grandchild.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Child')
          ..add('count', count)
          ..add('grandchild', grandchild))
        .toString();
  }
}

class ChildBuilder implements Builder<Child, ChildBuilder> {
  _$Child _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  GrandchildBuilder _grandchild;
  GrandchildBuilder get grandchild =>
      _$this._grandchild ??= new GrandchildBuilder();
  set grandchild(GrandchildBuilder grandchild) =>
      _$this._grandchild = grandchild;

  ChildBuilder();

  ChildBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _grandchild = _$v.grandchild?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Child other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Child;
  }

  @override
  void update(void Function(ChildBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Child build() {
    _$Child _$result;
    try {
      _$result =
          _$v ?? new _$Child._(count: count, grandchild: grandchild.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'grandchild';
        grandchild.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Child', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Grandchild extends Grandchild {
  @override
  final int count;

  factory _$Grandchild([void Function(GrandchildBuilder) updates]) =>
      (new GrandchildBuilder()..update(updates)).build();

  _$Grandchild._({this.count}) : super._() {
    if (count == null) {
      throw new BuiltValueNullFieldError('Grandchild', 'count');
    }
  }

  @override
  Grandchild rebuild(void Function(GrandchildBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GrandchildBuilder toBuilder() => new GrandchildBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Grandchild && count == other.count;
  }

  @override
  int get hashCode {
    return $jf($jc(0, count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Grandchild')..add('count', count))
        .toString();
  }
}

class GrandchildBuilder implements Builder<Grandchild, GrandchildBuilder> {
  _$Grandchild _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  GrandchildBuilder();

  GrandchildBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Grandchild other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Grandchild;
  }

  @override
  void update(void Function(GrandchildBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Grandchild build() {
    final _$result = _$v ?? new _$Grandchild._(count: count);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
