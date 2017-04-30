// GENERATED CODE - DO NOT MODIFY BY HAND

part of groups;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class GroupsActions
// **************************************************************************

class _$GroupsActions extends GroupsActions {
  ActionDispatcher<AddTodoToGroupPayload> addTodoToGroup =
      new ActionDispatcher<AddTodoToGroupPayload>(
          'GroupsActions-addTodoToGroup');

  ActionDispatcher<int> removeGroup =
      new ActionDispatcher<int>('GroupsActions-removeGroup');

  ActionDispatcher<Group> addGroup =
      new ActionDispatcher<Group>('GroupsActions-addGroup');

  ActionDispatcher<int> setCurrentGroup =
      new ActionDispatcher<int>('GroupsActions-setCurrentGroup');
  factory _$GroupsActions() => new _$GroupsActions._();
  _$GroupsActions._() : super._();
  syncWithStore(dispatcher) {
    addTodoToGroup.syncWithStore(dispatcher);
    removeGroup.syncWithStore(dispatcher);
    addGroup.syncWithStore(dispatcher);
    setCurrentGroup.syncWithStore(dispatcher);
  }
}

class GroupsActionsNames {
  static ActionName addTodoToGroup =
      new ActionName<AddTodoToGroupPayload>('GroupsActions-addTodoToGroup');
  static ActionName removeGroup =
      new ActionName<int>('GroupsActions-removeGroup');
  static ActionName addGroup = new ActionName<Group>('GroupsActions-addGroup');
  static ActionName setCurrentGroup =
      new ActionName<int>('GroupsActions-setCurrentGroup');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class GroupsReducer
// **************************************************************************

class _$GroupsReducer extends GroupsReducer {
  @override
  final int currentGroupId;
  @override
  final BuiltMap<int, Group> groupMap;
  Group __currentGroup;

  factory _$GroupsReducer([void updates(GroupsReducerBuilder b)]) =>
      (new GroupsReducerBuilder()..update(updates)).build();

  _$GroupsReducer._({this.currentGroupId, this.groupMap}) : super._() {
    if (currentGroupId == null)
      throw new ArgumentError.notNull('currentGroupId');
    if (groupMap == null) throw new ArgumentError.notNull('groupMap');
  }

  @override
  Group get currentGroup => __currentGroup ??= super.currentGroup;

  @override
  GroupsReducer rebuild(void updates(GroupsReducerBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupsReducerBuilder toBuilder() => new GroupsReducerBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! GroupsReducer) return false;
    return currentGroupId == other.currentGroupId && groupMap == other.groupMap;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, currentGroupId.hashCode), groupMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupsReducer')
          ..add('currentGroupId', currentGroupId)
          ..add('groupMap', groupMap))
        .toString();
  }
}

class GroupsReducerBuilder
    implements Builder<GroupsReducer, GroupsReducerBuilder> {
  _$GroupsReducer _$v;

  int _currentGroupId;
  int get currentGroupId => _$this._currentGroupId;
  set currentGroupId(int currentGroupId) =>
      _$this._currentGroupId = currentGroupId;

  MapBuilder<int, Group> _groupMap;
  MapBuilder<int, Group> get groupMap =>
      _$this._groupMap ??= new MapBuilder<int, Group>();
  set groupMap(MapBuilder<int, Group> groupMap) => _$this._groupMap = groupMap;

  GroupsReducerBuilder();

  GroupsReducerBuilder get _$this {
    if (_$v != null) {
      _currentGroupId = _$v.currentGroupId;
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
    final result = _$v ??
        new _$GroupsReducer._(
            currentGroupId: currentGroupId, groupMap: groupMap?.build());
    replace(result);
    return result;
  }
}
