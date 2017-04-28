library creation_middleware;

import 'package:built_redux/built_redux.dart';

import '../reducers/group.dart';
import '../reducers/todo.dart';
import '../reducers/app_state.dart';
import '../reducers/groups.dart';

part 'creation_middleware.g.dart';

abstract class CreatorActions extends ReduxActions {
  ActionDispatcher<String> createTodo;
  ActionDispatcher<String> createGroup;

  CreatorActions._();
  factory CreatorActions() => new _$CreatorActions();
}

var creatorMiddeware = (new MiddlwareBuilder<AppState, AppStateBuilder, AppStateActions>()
      ..add<String>(CreatorActionsNames.createGroup, _createGroup)
      ..add<String>(CreatorActionsNames.createTodo, _createTodo))
    .build();

_createGroup(MiddlewareApi<AppState, AppStateBuilder, AppStateActions> api, ActionHandler next,
    Action<String> action) {
  var newGroup = _newGroup(action.payload);
  api.actions.groupActions.addGroup(newGroup);
  api.actions.setCurrentGroup(newGroup.id);
}

_createTodo(MiddlewareApi<AppState, AppStateBuilder, AppStateActions> api, ActionHandler next,
    Action<String> action) {
  var newTodo = _newTodo(action.payload);
  api.actions.todosActions.addTodo(newTodo);
  api.actions.groupActions.addTodoToGroup(new AddTodoToGroupPayload()
    ..todoId = newTodo.id
    ..groupId = api.state.currentGroupId);
}

Group _newGroup(String name) => new Group((b) => b
  ..id = new DateTime.now().millisecondsSinceEpoch
  ..name = name
  ..done = false);

Todo _newTodo(String text) => new Todo((b) => b
  ..id = new DateTime.now().millisecondsSinceEpoch
  ..text = text
  ..done = false);
