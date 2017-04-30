library todos;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'todo.dart';

part 'todos.g.dart';

abstract class TodosActions extends ReduxActions {
  ActionDispatcher<Todo> addTodo;
  ActionDispatcher<int> removeTodo;
  ActionDispatcher<int> updateTodoStatus;

  TodosActions._();
  factory TodosActions() => new _$TodosActions();
}

// Reducers
addTodoReducer(TodosReducer state, Action<Todo> action, TodosReducerBuilder builder) =>
    builder.todosMap[action.payload.id] = action.payload;

removeTodoReducer(TodosReducer state, Action<int> action, TodosReducerBuilder builder) =>
    builder.todosMap.remove(action.payload);

updateTodoStatusReducer(TodosReducer state, Action<int> action, TodosReducerBuilder builder) =>
    builder.todosMap[action.payload] = builder.todosMap[action.payload].rebuild(
      (tbuilder) => tbuilder..done = !tbuilder.done,
    );

final _reducer = (new ReducerBuilder<TodosReducer, TodosReducerBuilder>()
      ..add<Todo>(TodosActionsNames.addTodo, addTodoReducer)
      ..add<int>(TodosActionsNames.removeTodo, removeTodoReducer)
      ..add<int>(TodosActionsNames.updateTodoStatus, updateTodoStatusReducer))
    .build();

// Built Reducer
abstract class TodosReducer extends BuiltReducer<TodosReducer, TodosReducerBuilder>
    implements Built<TodosReducer, TodosReducerBuilder> {
  // global todo list
  BuiltMap<int, Todo> get todosMap;

  // The reducer
  get reducer => _reducer;

  TodosReducer._();
  factory TodosReducer([updates(TodosReducerBuilder b)]) = _$TodosReducer;
}
