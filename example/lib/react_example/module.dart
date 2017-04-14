import 'package:func_comp/func_comp.dart';
import 'package:over_react/over_react.dart';
import 'package:built_collection/built_collection.dart';

import '../reducers/app_state.dart';
import '../reducers/api.dart';
import '../reducers/todos.dart';
import '../reducers/todo.dart';
import '../reducers/groups.dart';
import '../reducers/group.dart';
import '../middleware/new_group_middleware.dart';
import '../middleware/new_todo_middleware.dart';
import 'select.dart';
import 'creator.dart';

// class TodoActions {
//   Action
// }

class TodoMappedProps {
  Function addTodo;
  Function removeTodo;
  Function addGroup;
  Function removeGroup;
  Function setCurrentGroup;
  // Function setCurrentGroup;

  int currentGroup;
  BuiltMap<int, Group> groups;
  BuiltMap<int, Todo> todos;
  String title;
}

class TodoProps extends TodoMappedProps with StateMgr {}

var todosReduxBuilder = compose<ReduxProps<AppState>, TodoProps>([
  mapReduxStoreToProps<AppState, TodoMappedProps>(
      (ReduxProps<AppState> reduxProps) => new TodoMappedProps()
        ..actions = reduxProps.actions
        // ..addTodo = ((String content) => reduxProps.store.dispatch(createTodo(content)))
        // ..removeTodo = ((int id) => reduxProps.store.dispatch(removeTodo(id)))
        // ..addGroup = ((String name) => reduxProps.store.dispatch(createGroup(name)))
        // ..removeGroup = ((int id) => reduxProps.store.dispatch(removeGroup(id)))
        // ..setCurrentGroup = ((int id) => reduxProps.store.dispatch(setCurrentGroup(id)))
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
        ..onSelect = props.setCurrentGroup),
      creatorComponent(new CreatorProps()
        ..onSubmit = props.addGroup
        ..name = 'group'),
      Dom.div()(),
      creatorComponent(new CreatorProps()
        ..onSubmit = props.addTodo
        ..name = 'todo'),
      todoItems(props),
    );

ReactElement todoHeader(TodoProps props) =>
    Dom.div()('${props.title} TODOS: (${props.todos.length})');

ReactElement todoItems(TodoProps props) => Dom.div()(
      props.todos.values.map(
        (Todo todo) => todoItem(todo),
      ),
    );

ReactElement todoItem(Todo todo) => (Dom.div()..key = todo.id)(
      todo.text,
      (Dom.input()
        // ..onChange = (() => )
        ..value = todo.done
        ..type = 'checkbox')(),
    );
