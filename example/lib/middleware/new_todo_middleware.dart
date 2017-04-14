import 'package:built_redux/built_redux.dart';

import '../reducers/todo.dart';

import '../reducers/groups.dart';
import '../reducers/todos.dart';

var createTodoName = 'CREATE_TODO';

createTodo(String text) => new Action<String>()
  ..name = createTodoName
  ..payload = text;

newTodoMiddleware(MiddlewareApi api) => (ActionHandler next) => (Action action) {
      if (action.name != createTodoName) return next(action);

      var newTodo = _newTodo(action.payload);
      api.dispatch(addTodo(newTodo));
      api.dispatch(addTodoToGroup(newTodo.id, api.state.currentGroup));
    };

// util
_newTodo(String text) => new Todo((b) => b
  ..id = new DateTime.now().millisecondsSinceEpoch
  ..text = text
  ..done = false);
