library groups;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'group.dart';

part 'groups.g.dart';

abstract class GroupsActions extends ReduxActions {
  ActionDispatcher<int> setCurrentGroup;
  ActionDispatcher<Group> addGroup;
  ActionDispatcher<int> removeGroup;
  ActionDispatcher<AddTodoToGroupPayload> addTodoToGroup;

  GroupsActions._();
  factory GroupsActions() => new _$GroupsActions();
}

// Action Payload
class AddTodoToGroupPayload {
  int todoId;
  int groupId;
}

// Reducers
_setCurrentGroupReducer(GroupsReducer state, Action<int> action, GroupsReducerBuilder builder) =>
    builder..currentGroupId = action.payload;

_addTodoToGroupReducer(
        GroupsReducer state, Action<AddTodoToGroupPayload> action, GroupsReducerBuilder builder) =>
    builder.groupMap[action.payload.groupId] = builder.groupMap[action.payload.groupId]
        .rebuild((gbuilder) => gbuilder..todoIds.add(action.payload.todoId));

_addGroupReducer(GroupsReducer state, Action<Group> action, GroupsReducerBuilder builder) => builder
  ..groupMap[action.payload.id] = action.payload
  ..currentGroupId = action.payload.id;

_removeGroupReducer(GroupsReducer state, Action<int> action, GroupsReducerBuilder builder) =>
    builder.groupMap.remove(action.payload);

final _reducer = (new ReducerBuilder<GroupsReducer, GroupsReducerBuilder>()
      ..add<int>(GroupsActionsNames.setCurrentGroup, _setCurrentGroupReducer)
      ..add<Group>(GroupsActionsNames.addGroup, _addGroupReducer)
      ..add<int>(GroupsActionsNames.removeGroup, _removeGroupReducer)
      ..add<AddTodoToGroupPayload>(GroupsActionsNames.addTodoToGroup, _addTodoToGroupReducer))
    .build();

// Built Reducer
abstract class GroupsReducer extends BuiltReducer<GroupsReducer, GroupsReducerBuilder>
    implements Built<GroupsReducer, GroupsReducerBuilder> {
  /// [currentGroupId] is the group id in which the view is currently displaying todos for
  int get currentGroupId;

  /// [currentGroup] is the group in which the view is currently displaying todos for
  @memoized
  Group get currentGroup => groupMap[currentGroupId];

  /// [groupMap] is the global group map for the whole application
  BuiltMap<int, Group> get groupMap;

  // The reducer
  get reducer => _reducer;

  GroupsReducer._();
  factory GroupsReducer([updates(GroupsReducerBuilder b)]) =>
      new _$GroupsReducer((GroupsReducerBuilder b) => b..currentGroupId = -1);
}
