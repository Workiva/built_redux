// GENERATED CODE - DO NOT MODIFY BY HAND

part of nested_models;

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

class _$Base extends Base {
  @override
  final int count;
  @override
  final Child child;

  factory _$Base([void updates(BaseBuilder b)]) =>
      (new BaseBuilder()..update(updates)).build();

  _$Base._({this.count, this.child}) : super._() {
    if (count == null) throw new BuiltValueNullFieldError('Base', 'count');
    if (child == null) throw new BuiltValueNullFieldError('Base', 'child');
  }

  @override
  Base rebuild(void updates(BaseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseBuilder toBuilder() => new BaseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Base) return false;
    return count == other.count && child == other.child;
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Base;
  }

  @override
  void update(void updates(BaseBuilder b)) {
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

  factory _$Child([void updates(ChildBuilder b)]) =>
      (new ChildBuilder()..update(updates)).build();

  _$Child._({this.count, this.grandchild}) : super._() {
    if (count == null) throw new BuiltValueNullFieldError('Child', 'count');
    if (grandchild == null)
      throw new BuiltValueNullFieldError('Child', 'grandchild');
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
    return count == other.count && grandchild == other.grandchild;
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Child;
  }

  @override
  void update(void updates(ChildBuilder b)) {
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

  factory _$Grandchild([void updates(GrandchildBuilder b)]) =>
      (new GrandchildBuilder()..update(updates)).build();

  _$Grandchild._({this.count}) : super._() {
    if (count == null)
      throw new BuiltValueNullFieldError('Grandchild', 'count');
  }

  @override
  Grandchild rebuild(void updates(GrandchildBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  GrandchildBuilder toBuilder() => new GrandchildBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Grandchild) return false;
    return count == other.count;
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
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Grandchild;
  }

  @override
  void update(void updates(GrandchildBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Grandchild build() {
    final _$result = _$v ?? new _$Grandchild._(count: count);
    replace(_$result);
    return _$result;
  }
}
