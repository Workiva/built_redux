// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class AppStateActions
// **************************************************************************

class _$AppStateActions extends AppStateActions {
  GroupsActions groupActions = new GroupsActions();
  final TodosActions todosActions = new TodosActions();
  ActionMgr<int> setCurrentGroup = new ActionMgr<int>('setCurrentGroup');
  CreatorActions creationActions = new CreatorActions();
  factory _$AppStateActions() => new _$AppStateActions._();
  _$AppStateActions._() : super._();
  syncWithStore(dispatcher) {
    creationActions.syncWithStore(dispatcher);
    todosActions.syncWithStore(dispatcher);
    groupActions.syncWithStore(dispatcher);
    setCurrentGroup.syncWithStore(dispatcher);
  }
}

class AppStateActionsNames {
  static ActionName setCurrentGroup = new ActionName<int>('setCurrentGroup');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class AppState
// **************************************************************************

class _$AppState extends AppState {
  @override
  final int currentGroup;
  @override
  final GroupsReducer groups;
  @override
  final TodosReducer todos;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.currentGroup, this.groups, this.todos}) : super._() {
    if (currentGroup == null) throw new ArgumentError.notNull('currentGroup');
    if (groups == null) throw new ArgumentError.notNull('groups');
    if (todos == null) throw new ArgumentError.notNull('todos');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return currentGroup == other.currentGroup &&
        groups == other.groups &&
        todos == other.todos;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, currentGroup.hashCode), groups.hashCode), todos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('currentGroup', currentGroup)
          ..add('groups', groups)
          ..add('todos', todos))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  int _currentGroup;
  int get currentGroup => _$this._currentGroup;
  set currentGroup(int currentGroup) => _$this._currentGroup = currentGroup;

  GroupsReducerBuilder _groups;
  GroupsReducerBuilder get groups =>
      _$this._groups ??= new GroupsReducerBuilder();
  set groups(GroupsReducerBuilder groups) => _$this._groups = groups;

  TodosReducerBuilder _todos;
  TodosReducerBuilder get todos => _$this._todos ??= new TodosReducerBuilder();
  set todos(TodosReducerBuilder todos) => _$this._todos = todos;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _currentGroup = _$v.currentGroup;
      _groups = _$v.groups?.toBuilder();
      _todos = _$v.todos?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    final result = _$v ??
        new _$AppState._(
            currentGroup: currentGroup,
            groups: groups?.build(),
            todos: todos?.build());
    replace(result);
    return result;
  }
}
