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
  factory _$AppStateActions() => new _$AppStateActions._();
  _$AppStateActions._() : super._();
  syncWithStore(dispatcher) {
    creationActions.syncWithStore(dispatcher);
    todosActions.syncWithStore(dispatcher);
    groupActions.syncWithStore(dispatcher);
    setBogus.syncWithStore(dispatcher);
  }
}

class AppStateActionsNames {
  static ActionName setBogus = new ActionName<int>('AppStateActions-setBogus');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class AppState
// **************************************************************************

class _$AppState extends AppState {
  @override
  final int bogus;
  @override
  final GroupsReducer groups;
  @override
  final TodosReducer todos;
  BuiltMap<int, Todo> __currentGroupTodos;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.bogus, this.groups, this.todos}) : super._() {
    if (bogus == null) throw new ArgumentError.notNull('bogus');
    if (groups == null) throw new ArgumentError.notNull('groups');
    if (todos == null) throw new ArgumentError.notNull('todos');
  }

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
    return bogus == other.bogus &&
        groups == other.groups &&
        todos == other.todos;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, bogus.hashCode), groups.hashCode), todos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('bogus', bogus)
          ..add('groups', groups)
          ..add('todos', todos))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

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
            bogus: bogus, groups: groups?.build(), todos: todos?.build());
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
