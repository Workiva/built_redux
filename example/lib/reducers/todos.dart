library todos;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'todo.dart';

part 'todos.g.dart';

class TodosActions extends ReduxActions {
  static ActionMgr<Todo> addTodo;
  static ActionMgr<int> removeTodo;
  static ActionMgr<int> updateTodoStatus;

  TodosActions(dispatcher) : super(dispatcher);
}

// // Action Names
// var addTodoName = 'ADD_TODO';
// var removeTodoName = 'REMOVE_TODO';
// var updateTodoStatusName = 'UPDATE_TODO_STATUS';
//
// // Action creators
// addTodo(Todo todo) => new Action<Todo>()
//   ..name = addTodoName
//   ..payload = todo;
//
// removeTodo(int todoId) => new Action<int>()
//   ..name = removeTodoName
//   ..payload = todoId;
//
// updateTodoStatus(int todoId) => new Action<int>()
//   ..name = removeTodoName
//   ..payload = todoId;

// Reducers
addTodoReducer(TodosReducerBuilder builder, Action<Todo> action) =>
    builder.todosMap[action.payload.id] = action.payload;

removeTodoReducer(TodosReducerBuilder builder, Action<int> action) =>
    builder.todosMap.remove(action.payload);

updateTodoStatusReducer(TodosReducerBuilder builder, Action<int> action) =>
    builder.todosMap[action.payload.groupId] = builder.todosMap
        .build()[action.payload.groupId]
        .rebuild((tbuilder) => tbuilder..done = !tbuilder.done);

// final Map<String, Reducer<TodosReducer, TodosReducerBuilder, dynamic>> _reducers = {
//   addTodoName: addTodoReducer,
//   removeTodoName: removeTodoReducer,
//   // updateTodoStatusName:
// };

final _reducers = new ReducerBuilder<TodosReducerBuilder>()
  ..add<Todo>(TodosActions.addTodo, addTodoReducer)
  ..add<int>(TodosActions.removeTodo, removeTodoReducer)
  ..add<int>(TodosActions.updateTodoStatus, updateTodoStatusReducer);

// Built Reducer
abstract class TodosReducer extends BuiltReducer<TodosReducer, TodosReducerBuilder>
    implements Built<TodosReducer, TodosReducerBuilder> {
  // global todo list
  BuiltMap<int, Todo> get todosMap;

  // The reducers
  get reducers => _reducers;

  TodosReducer._();
  factory TodosReducer([updates(TodosReducerBuilder b)]) = _$TodosReducer;
}
