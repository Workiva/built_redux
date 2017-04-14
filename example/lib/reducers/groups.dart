library groups;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'group.dart';

part 'groups.g.dart';

class GroupsActions extends ReduxActions {
  static ActionMgr<int> addGroup;
  static ActionMgr<int> removeGroup;
  static ActionMgr<AddTodoToGroupPayload> addTodoToGroup;

  GroupsActions(dispatcher) : super(dispatcher);
}

// ction Names
// var addTodoToGroupName = 'ADD_TODO_GROUP';
// var addGroupName = 'ADD_GROUP';
// var removeGroupName = 'REMOVE_GROUP';

// Action Payload
class AddTodoToGroupPayload {
  int todoId;
  int groupId;
}

// Action creators
// addTodoToGroup(int todoId, int groupId) => new Action<AddTodoToGroupPayload>()
//   ..name = addTodoToGroupName
//   ..payload = (new AddTodoToGroupPayload()
//     ..todoId = todoId
//     ..groupId = groupId);
//
// addGroup(Group newGroup) => new Action<Group>()
//   ..name = addGroupName
//   ..payload = newGroup;
//
// removeGroup(int id) => new Action<int>()
//   ..name = removeGroupName
//   ..payload = id;

// Reducers
_addTodoToGroupReducer(GroupsReducerBuilder builder, Action<AddTodoToGroupPayload> action) =>
    builder.groupMap[action.payload.groupId] = builder.groupMap
        .build()[action.payload.groupId]
        .rebuild((gbuilder) => gbuilder..todoIds.add(action.payload.todoId));

_addGroupReducer(GroupsReducerBuilder builder, Action<Group> action) =>
    builder.groupMap[action.payload.id] = action.payload;

_removeGroupReducer(GroupsReducerBuilder builder, Action<int> action) =>
    builder.groupMap.remove(action.payload);

// final Map<String, Reducer<GroupsReducer, GroupsReducerBuilder, dynamic>> _reducers = {
//   addTodoToGroupName: _addTodoToGroupReducer,
//   addGroupName: _addGroupReducer,
//   removeGroupName: _removeGroupReducer,
// };

final _reducers = new ReducerBuilder<GroupsBuilder>()
  ..add<Group>(GroupActions.addGroup, _addGroupReducer)
  ..add<int>(GroupsActions.removeGroup, _removeGroupReducer)
  ..add<AddTodoToGroupPayload>(GroupsActions.addGroup, _addTodoToGroupReducer);

// Built Reducer
abstract class GroupsReducer extends BuiltReducer<GroupsReducer, GroupsReducerBuilder>
    implements Built<GroupsReducer, GroupsReducerBuilder> {
  BuiltMap<int, Group> get groupMap;

  // The reducers
  get reducers => _reducers;

  GroupsReducer._();
  factory GroupsReducer([updates(GroupsReducerBuilder b)]) = _$GroupsReducer;
}
