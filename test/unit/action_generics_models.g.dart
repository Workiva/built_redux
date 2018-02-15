// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_generics_models.dart';

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

class _$ActionGenerics extends ActionGenerics {
  @override
  final int count;

  factory _$ActionGenerics([void updates(ActionGenericsBuilder b)]) =>
      (new ActionGenericsBuilder()..update(updates)).build();

  _$ActionGenerics._({this.count}) : super._() {
    if (count == null)
      throw new BuiltValueNullFieldError('ActionGenerics', 'count');
  }

  @override
  ActionGenerics rebuild(void updates(ActionGenericsBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ActionGenericsBuilder toBuilder() =>
      new ActionGenericsBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ActionGenerics) return false;
    return count == other.count;
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
    if (other == null) throw new ArgumentError.notNull('other');
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
