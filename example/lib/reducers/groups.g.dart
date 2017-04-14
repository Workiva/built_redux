// GENERATED CODE - DO NOT MODIFY BY HAND

part of groups;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class GroupsReducer
// **************************************************************************

class _$GroupsReducer extends GroupsReducer {
  @override
  final BuiltMap<int, Group> groupMap;

  factory _$GroupsReducer([void updates(GroupsReducerBuilder b)]) =>
      (new GroupsReducerBuilder()..update(updates)).build();

  _$GroupsReducer._({this.groupMap}) : super._() {
    if (groupMap == null) throw new ArgumentError.notNull('groupMap');
  }

  @override
  GroupsReducer rebuild(void updates(GroupsReducerBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupsReducerBuilder toBuilder() => new GroupsReducerBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! GroupsReducer) return false;
    return groupMap == other.groupMap;
  }

  @override
  int get hashCode {
    return $jf($jc(0, groupMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupsReducer')
          ..add('groupMap', groupMap))
        .toString();
  }
}

class GroupsReducerBuilder
    implements Builder<GroupsReducer, GroupsReducerBuilder> {
  _$GroupsReducer _$v;

  MapBuilder<int, Group> _groupMap;
  MapBuilder<int, Group> get groupMap =>
      _$this._groupMap ??= new MapBuilder<int, Group>();
  set groupMap(MapBuilder<int, Group> groupMap) => _$this._groupMap = groupMap;

  GroupsReducerBuilder();

  GroupsReducerBuilder get _$this {
    if (_$v != null) {
      _groupMap = _$v.groupMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupsReducer other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$GroupsReducer;
  }

  @override
  void update(void updates(GroupsReducerBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupsReducer build() {
    final result = _$v ?? new _$GroupsReducer._(groupMap: groupMap?.build());
    replace(result);
    return result;
  }
}
