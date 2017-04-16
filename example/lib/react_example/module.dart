import 'package:func_comp/func_comp.dart';
import 'package:over_react/over_react.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';

import '../reducers/app_state.dart';
import '../reducers/api.dart';
import '../reducers/todo.dart';
import '../reducers/group.dart';
import 'select.dart';
import 'creator.dart';

class TodoMappedProps {
  AppStateActions actions;
  int currentGroup;
  BuiltMap<int, Group> groups;
  BuiltMap<int, Todo> todos;
  String title;
}

class TodoProps extends TodoMappedProps with StateMgr {}

var todosReduxBuilder = compose<ReduxProps<AppState>, TodoProps>([
  mapReduxStoreToProps<AppState, TodoMappedProps>(
      (ReduxProps<AppState> reduxProps) => new TodoMappedProps()
        ..actions = reduxProps.store.actions
        ..currentGroup = reduxProps.store.state.currentGroup
        ..groups = reduxProps.store.state.groups.groupMap
        ..todos = currentGroupTodos(reduxProps.store.state)
        ..title = "redux"),
  pure,
])(todosComponent);

ReactElement todosComponent(TodoProps props) => Dom.div()(
      todoHeader(props),
      selectComponent(new SelectProps()
        ..label = 'group'
        ..currentGroup = props.currentGroup
        ..optionMap = props.groups
        ..onSelect = props.actions.setCurrentGroup),
      creatorComponent(new CreatorProps()
        ..onSubmit = props.actions.creationActions.createGroup
        ..name = 'group'),
      Dom.div()(),
      creatorComponent(new CreatorProps()
        ..onSubmit = props.actions.creationActions.createTodo
        ..name = 'todo'),
      todoItems(props),
    );

ReactElement todoHeader(TodoProps props) =>
    Dom.div()('${props.title} TODOS: (${props.todos.length})');

ReactElement todoItems(TodoProps props) => Dom.div()(
      props.todos.values.map(
        (Todo todo) => todoItem(todo, props.actions.todosActions.updateTodoStatus),
      ),
    );

ReactElement todoItem(Todo todo, ActionMgr<int> updateTodoStatus) => (Dom.div()..key = todo.id)(
      todo.text,
      (Dom.input()
        ..onChange = ((_) => updateTodoStatus(todo.id))
        ..checked = todo.done
        ..type = 'checkbox')(),
    );
