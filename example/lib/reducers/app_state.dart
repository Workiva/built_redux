library app_state;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

import 'groups.dart';
import 'todos.dart';
import '../middleware/creation_middleware.dart';

part 'app_state.g.dart';

abstract class AppStateActions extends ReduxActions {
  ActionMgr<int> setCurrentGroup;

  GroupsActions groupActions;
  TodosActions todosActions;
  CreatorActions creationActions;

  AppStateActions._();
  factory AppStateActions() => new _$AppStateActions();
}

_setCurrentGroupReducer(AppState state, Action<int> action, AppStateBuilder builder) =>
    builder..currentGroup = action.payload;

final _reducers = (new ReducerBuilder<AppStateBuilder>()
      ..add<int>(AppStateActionsNames.setCurrentGroup, _setCurrentGroupReducer))
    .build();

// Built Reducer
abstract class AppState extends BuiltReducer<AppState, AppStateBuilder>
    implements Built<AppState, AppStateBuilder> {
  /// [currentGroup] is the group in which the view is currently displaying todos for
  int get currentGroup;

  /// [groups] is a list of all todo groups
  GroupsReducer get groups;

  TodosReducer get todos;

  // The reducers
  get reducers => _reducers;

  // Built value boilerplate
  AppState._();
  factory AppState([updates(AppStateBuilder b)]) = _$AppState;
}
