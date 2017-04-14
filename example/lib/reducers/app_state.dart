library app_state;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

import 'groups.dart';
import 'todos.dart';

part 'app_state.g.dart';

class AppStateActions extends ReduxActions {
  static ActionMgr<int> setCurrentGroup;

  static GroupsActions groupActions;
  static TodosActions todosActions;

  AppStateActions(dispatcher) : super(dispatcher);
}

// Action Names
// var setCurrentGroupName = 'SET_CURRENT_GROUP';

// Action creators
// setCurrentGroup(int newGroup) => new Action<int>()
//   ..name = setCurrentGroupName
//   ..payload = newGroup;

// Reducers
// final Map<String, Reducer<AppState, AppStateBuilder, dynamic>> _reducers = {
//   setCurrentGroupName: (builder, action) => builder..currentGroup = action.payload,
// };

final _reducers = new ReducerBuilder()
  ..add<AppStateBuilder, int>(
    AppStateActions.setCurrentGroup,
    (builder, action) => builder..currentGroup = action.payload,
  );

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
