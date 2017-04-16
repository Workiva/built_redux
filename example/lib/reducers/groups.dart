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
_addTodoToGroupReducer(GroupsReducerBuilder builder, Action<AddTodoToGroupPayload> action) =>
    builder.groupMap[action.payload.groupId] = builder.groupMap
        .build()[action.payload.groupId]
        .rebuild((gbuilder) => gbuilder..todoIds.add(action.payload.todoId));

_addGroupReducer(GroupsReducerBuilder builder, Action<Group> action) =>
    builder.groupMap[action.payload.id] = action.payload;

_removeGroupReducer(GroupsReducerBuilder builder, Action<int> action) =>
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
