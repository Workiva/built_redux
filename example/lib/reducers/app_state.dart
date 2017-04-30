library app_state;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'groups.dart';
import 'todos.dart';
import 'todo.dart';
import 'utils.dart';
import '../middleware/creation_middleware.dart';

part 'app_state.g.dart';

abstract class AppStateActions extends ReduxActions {
  ActionDispatcher<int> setBogus;

  GroupsActions groupActions;
  TodosActions todosActions;
  CreatorActions creationActions;

  AppStateActions._();
  factory AppStateActions() => new _$AppStateActions();
}

_setBogus(AppState state, Action<int> action, AppStateBuilder builder) {
  print("set bogus handled");
  return builder..bogus += action.payload;
}

final _reducer = (new ReducerBuilder<AppState, AppStateBuilder>()
      ..add<int>(AppStateActionsNames.setBogus, _setBogus))
    .build();

// Built Reducer
abstract class AppState extends BuiltReducer<AppState, AppStateBuilder>
    with AppStateReduceChildren
    implements Built<AppState, AppStateBuilder> {
  /// [bogus] is an integer to prove that pure component should updates work
  int get bogus;

  /// [groups] is a map of all todo groups
  GroupsReducer get groups;

  /// [todos] is a map of all todos
  TodosReducer get todos;

  @memoized
  BuiltMap<int, Todo> get currentGroupTodos {
    return (groups.currentGroupId == -1)
        ? new BuiltMap<int, Todo>()
        : filterMap<int, Todo>(todos.todosMap, groups.currentGroup.todoIds);
  }

  // The reducer
  get reducer => _reducer;

  // Built value boilerplate and default state
  AppState._();
  factory AppState([updates(AppStateBuilder b)]) => new _$AppState((AppStateBuilder b) => b
    ..bogus = 0
    ..groups = new GroupsReducer().toBuilder()
    ..todos = new TodosReducer().toBuilder());
}
