library groups;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'group.dart';

part 'groups.g.dart';

abstract class GroupsActions extends ReduxActions {
  ActionMgr<int> addGroup;
  ActionMgr<int> removeGroup;
  ActionMgr<AddTodoToGroupPayload> addTodoToGroup;

  GroupsActions._();
  factory GroupsActions() => new _$GroupsActions();
}

// Action Payload
class AddTodoToGroupPayload {
  int todoId;
  int groupId;
}

// Reducers
_addTodoToGroupReducer(
        GroupsReducer state, Action<AddTodoToGroupPayload> action, GroupsReducerBuilder builder) =>
    builder.groupMap[action.payload.groupId] = state.groupMap[action.payload.groupId]
        .rebuild((gbuilder) => gbuilder..todoIds.add(action.payload.todoId));

_addGroupReducer(GroupsReducer state, Action<Group> action, GroupsReducerBuilder builder) =>
    builder.groupMap[action.payload.id] = action.payload;

_removeGroupReducer(GroupsReducer state, Action<int> action, GroupsReducerBuilder builder) =>
    builder.groupMap.remove(action.payload);

final _reducers = (new ReducerBuilder<GroupsReducerBuilder>()
      ..add<Group>(GroupsActionsNames.addGroup, _addGroupReducer)
      ..add<int>(GroupsActionsNames.removeGroup, _removeGroupReducer)
      ..add<AddTodoToGroupPayload>(GroupsActionsNames.addTodoToGroup, _addTodoToGroupReducer))
    .build();

// Built Reducer
abstract class GroupsReducer extends BuiltReducer<GroupsReducer, GroupsReducerBuilder>
    implements Built<GroupsReducer, GroupsReducerBuilder> {
  BuiltMap<int, Group> get groupMap;

  // The reducers
  get reducers => _reducers;

  GroupsReducer._();
  factory GroupsReducer([updates(GroupsReducerBuilder b)]) = _$GroupsReducer;
}
