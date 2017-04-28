// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_state;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class AppStateActions
// **************************************************************************

class _$AppStateActions extends AppStateActions {
  CreatorActions creationActions = new CreatorActions();
  TodosActions todosActions = new TodosActions();
  GroupsActions groupActions = new GroupsActions();
  ActionDispatcher<int> setBogus =
      new ActionDispatcher<int>('AppStateActions-setBogus');

  ActionDispatcher<int> setCurrentGroup =
      new ActionDispatcher<int>('AppStateActions-setCurrentGroup');
  factory _$AppStateActions() => new _$AppStateActions._();
  _$AppStateActions._() : super._();
  syncWithStore(dispatcher) {
    creationActions.syncWithStore(dispatcher);
    todosActions.syncWithStore(dispatcher);
    groupActions.syncWithStore(dispatcher);
    setBogus.syncWithStore(dispatcher);
    setCurrentGroup.syncWithStore(dispatcher);
  }
}

class AppStateActionsNames {
  static ActionName setBogus = new ActionName<int>('AppStateActions-setBogus');
  static ActionName setCurrentGroup =
      new ActionName<int>('AppStateActions-setCurrentGroup');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class AppState
// **************************************************************************

class _$AppState extends AppState {
  @override
  final int currentGroupId;
  @override
  final int bogus;
  @override
  final GroupsReducer groups;
  @override
  final TodosReducer todos;
  Group __currentGroup;
  BuiltMap<int, Todo> __currentGroupTodos;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.currentGroupId, this.bogus, this.groups, this.todos})
      : super._() {
    if (currentGroupId == null)
      throw new ArgumentError.notNull('currentGroupId');
    if (bogus == null) throw new ArgumentError.notNull('bogus');
    if (groups == null) throw new ArgumentError.notNull('groups');
    if (todos == null) throw new ArgumentError.notNull('todos');
  }

  @override
  Group get currentGroup => __currentGroup ??= super.currentGroup;

  @override
  BuiltMap<int, Todo> get currentGroupTodos =>
      __currentGroupTodos ??= super.currentGroupTodos;

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return currentGroupId == other.currentGroupId &&
        bogus == other.bogus &&
        groups == other.groups &&
        todos == other.todos;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, currentGroupId.hashCode), bogus.hashCode),
            groups.hashCode),
        todos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('currentGroupId', currentGroupId)
          ..add('bogus', bogus)
          ..add('groups', groups)
          ..add('todos', todos))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  int _currentGroupId;
  int get currentGroupId => _$this._currentGroupId;
  set currentGroupId(int currentGroupId) =>
      _$this._currentGroupId = currentGroupId;

  int _bogus;
  int get bogus => _$this._bogus;
  set bogus(int bogus) => _$this._bogus = bogus;

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
      _currentGroupId = _$v.currentGroupId;
      _bogus = _$v.bogus;
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
            currentGroupId: currentGroupId,
            bogus: bogus,
            groups: groups?.build(),
            todos: todos?.build());
    replace(result);
    return result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class AppState
// **************************************************************************

class AppStateReduceChildren {
  reduceChildren(AppState state, Action<dynamic> a, AppStateBuilder builder) {
    state.todos.reduce(state.todos, a, builder.todos);
    state.groups.reduce(state.groups, a, builder.groups);
  }
}
