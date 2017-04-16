library todos;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'todo.dart';

part 'todos.g.dart';

abstract class TodosActions extends ReduxActions {
  ActionMgr<Todo> addTodo;
  ActionMgr<int> removeTodo;
  ActionMgr<int> updateTodoStatus;

  TodosActions._();
  factory TodosActions() => new _$TodosActions();
}

// Reducers
addTodoReducer(TodosReducerBuilder builder, Action<Todo> action) =>
    builder.todosMap[action.payload.id] = action.payload;

removeTodoReducer(TodosReducerBuilder builder, Action<int> action) =>
    builder.todosMap.remove(action.payload);

updateTodoStatusReducer(TodosReducerBuilder builder, Action<int> action) =>
    builder.todosMap[action.payload] = builder.todosMap.build()[action.payload].rebuild(
          (tbuilder) => tbuilder..done = !tbuilder.done,
        );

final _reducers = (new ReducerBuilder<TodosReducerBuilder>()
      ..add<Todo>(TodosActionsNames.addTodo, addTodoReducer)
      ..add<int>(TodosActionsNames.removeTodo, removeTodoReducer)
      ..add<int>(TodosActionsNames.updateTodoStatus, updateTodoStatusReducer))
    .build();

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
