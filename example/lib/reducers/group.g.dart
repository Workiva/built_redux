// GENERATED CODE - DO NOT MODIFY BY HAND

part of group;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Group
// **************************************************************************

class _$Group extends Group {
  @override
  final int id;
  @override
  final String name;
  @override
  final bool done;
  @override
  final BuiltList<int> todoIds;

  factory _$Group([void updates(GroupBuilder b)]) =>
      (new GroupBuilder()..update(updates)).build();

  _$Group._({this.id, this.name, this.done, this.todoIds}) : super._() {
    if (id == null) throw new ArgumentError.notNull('id');
    if (name == null) throw new ArgumentError.notNull('name');
    if (done == null) throw new ArgumentError.notNull('done');
    if (todoIds == null) throw new ArgumentError.notNull('todoIds');
  }

  @override
  Group rebuild(void updates(GroupBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupBuilder toBuilder() => new GroupBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Group) return false;
    return id == other.id &&
        name == other.name &&
        done == other.done &&
        todoIds == other.todoIds;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, id.hashCode), name.hashCode), done.hashCode),
        todoIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Group')
          ..add('id', id)
          ..add('name', name)
          ..add('done', done)
          ..add('todoIds', todoIds))
        .toString();
  }
}

class GroupBuilder implements Builder<Group, GroupBuilder> {
  _$Group _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _done;
  bool get done => _$this._done;
  set done(bool done) => _$this._done = done;

  ListBuilder<int> _todoIds;
  ListBuilder<int> get todoIds => _$this._todoIds ??= new ListBuilder<int>();
  set todoIds(ListBuilder<int> todoIds) => _$this._todoIds = todoIds;

  GroupBuilder();

  GroupBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _done = _$v.done;
      _todoIds = _$v.todoIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Group other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Group;
  }

  @override
  void update(void updates(GroupBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Group build() {
    final result = _$v ??
        new _$Group._(
            id: id, name: name, done: done, todoIds: todoIds?.build());
    replace(result);
    return result;
  }
}
