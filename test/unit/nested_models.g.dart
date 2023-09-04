// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_models.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$BaseActions extends BaseActions {
  factory _$BaseActions() => _$BaseActions._();
  _$BaseActions._() : super._();

  final baseAction = ActionDispatcher<Null>('BaseActions-baseAction');

  final child = ChildActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    baseAction.setDispatcher(dispatcher);

    child.setDispatcher(dispatcher);
  }
}

class BaseActionsNames {
  static final baseAction = ActionName<Null>('BaseActions-baseAction');
}

class _$ChildActions extends ChildActions {
  factory _$ChildActions() => _$ChildActions._();
  _$ChildActions._() : super._();

  final childAction = ActionDispatcher<Null>('ChildActions-childAction');

  final grandchild = GrandchildActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    childAction.setDispatcher(dispatcher);

    grandchild.setDispatcher(dispatcher);
  }
}

class ChildActionsNames {
  static final childAction = ActionName<Null>('ChildActions-childAction');
}

class _$GrandchildActions extends GrandchildActions {
  factory _$GrandchildActions() => _$GrandchildActions._();
  _$GrandchildActions._() : super._();

  final grandchildAction =
      ActionDispatcher<Null>('GrandchildActions-grandchildAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    grandchildAction.setDispatcher(dispatcher);
  }
}

class GrandchildActionsNames {
  static final grandchildAction =
      ActionName<Null>('GrandchildActions-grandchildAction');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Base extends Base {
  @override
  final int count;
  @override
  final Child child;

  factory _$Base([void Function(BaseBuilder)? updates]) =>
      (new BaseBuilder()..update(updates))._build();

  _$Base._({required this.count, required this.child}) : super._() {
    BuiltValueNullFieldError.checkNotNull(count, r'Base', 'count');
    BuiltValueNullFieldError.checkNotNull(child, r'Base', 'child');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, child.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Base')
          ..add('count', count)
          ..add('child', child))
        .toString();
  }
}

class BaseBuilder implements Builder<Base, BaseBuilder> {
  _$Base? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  ChildBuilder? _child;
  ChildBuilder get child => _$this._child ??= new ChildBuilder();
  set child(ChildBuilder? child) => _$this._child = child;

  BaseBuilder();

  BaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _child = $v.child.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Base;
  }

  @override
  void update(void Function(BaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Base build() => _build();

  _$Base _build() {
    _$Base _$result;
    try {
      _$result = _$v ??
          new _$Base._(
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'Base', 'count'),
              child: child.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'child';
        child.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Base', _$failedField, e.toString());
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

  factory _$Child([void Function(ChildBuilder)? updates]) =>
      (new ChildBuilder()..update(updates))._build();

  _$Child._({required this.count, required this.grandchild}) : super._() {
    BuiltValueNullFieldError.checkNotNull(count, r'Child', 'count');
    BuiltValueNullFieldError.checkNotNull(grandchild, r'Child', 'grandchild');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, grandchild.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Child')
          ..add('count', count)
          ..add('grandchild', grandchild))
        .toString();
  }
}

class ChildBuilder implements Builder<Child, ChildBuilder> {
  _$Child? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  GrandchildBuilder? _grandchild;
  GrandchildBuilder get grandchild =>
      _$this._grandchild ??= new GrandchildBuilder();
  set grandchild(GrandchildBuilder? grandchild) =>
      _$this._grandchild = grandchild;

  ChildBuilder();

  ChildBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _grandchild = $v.grandchild.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Child other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Child;
  }

  @override
  void update(void Function(ChildBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Child build() => _build();

  _$Child _build() {
    _$Child _$result;
    try {
      _$result = _$v ??
          new _$Child._(
              count: BuiltValueNullFieldError.checkNotNull(
                  count, r'Child', 'count'),
              grandchild: grandchild.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'grandchild';
        grandchild.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Child', _$failedField, e.toString());
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

  factory _$Grandchild([void Function(GrandchildBuilder)? updates]) =>
      (new GrandchildBuilder()..update(updates))._build();

  _$Grandchild._({required this.count}) : super._() {
    BuiltValueNullFieldError.checkNotNull(count, r'Grandchild', 'count');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Grandchild')..add('count', count))
        .toString();
  }
}

class GrandchildBuilder implements Builder<Grandchild, GrandchildBuilder> {
  _$Grandchild? _$v;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  GrandchildBuilder();

  GrandchildBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Grandchild other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Grandchild;
  }

  @override
  void update(void Function(GrandchildBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Grandchild build() => _build();

  _$Grandchild _build() {
    final _$result = _$v ??
        new _$Grandchild._(
            count: BuiltValueNullFieldError.checkNotNull(
                count, r'Grandchild', 'count'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
