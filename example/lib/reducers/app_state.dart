library app_state;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'groups.dart';
import 'group.dart';
import 'todos.dart';
import 'todo.dart';
import 'utils.dart';
import '../middleware/creation_middleware.dart';

part 'app_state.g.dart';

abstract class AppStateActions extends ReduxActions {
  ActionDispatcher<int> setCurrentGroup;
  ActionDispatcher<int> setBogus;

  GroupsActions groupActions;
  TodosActions todosActions;
  CreatorActions creationActions;

  AppStateActions._();
  factory AppStateActions() => new _$AppStateActions();
}

_setCurrentGroupReducer(AppState state, Action<int> action, AppStateBuilder builder) =>
    builder..currentGroupId = action.payload;

_setBogus(AppState state, Action<int> action, AppStateBuilder builder) {
  print("set bogus handled");
  return builder..bogus += action.payload;
}

final _reducer = (new ReducerBuilder<AppState, AppStateBuilder>()
      ..add<int>(AppStateActionsNames.setCurrentGroup, _setCurrentGroupReducer)
      ..add<int>(AppStateActionsNames.setBogus, _setBogus))
    .build();

// Built Reducer
abstract class AppState extends BuiltReducer<AppState, AppStateBuilder>
    with AppStateReduceChildren
    implements Built<AppState, AppStateBuilder> {
  /// [currentGroup] is the group in which the view is currently displaying todos for
  int get currentGroupId;

  @memoized
  Group get currentGroup => groups.groupMap[currentGroupId];

  @memoized
  BuiltMap<int, Todo> get currentGroupTodos {
    if (currentGroupId == -1) return new BuiltMap<int, Todo>();
    return filterMap<int, Todo>(
      todos.todosMap,
      currentGroup.todoIds,
    );
  }

  /// [bogus] is an integer to prove that pure component should updates work
  int get bogus;

  /// [groups] is a list of all todo groups
  GroupsReducer get groups;

  TodosReducer get todos;

  // The reducer
  get reducer => _reducer;

  // Built value boilerplate and default state
  AppState._();
  factory AppState([updates(AppStateBuilder b)]) => new _$AppState((AppStateBuilder b) => b
    ..currentGroupId = -1
    ..bogus = 0);
}
