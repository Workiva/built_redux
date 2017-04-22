// GENERATED CODE - DO NOT MODIFY BY HAND

part of todos;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class TodosActions
// **************************************************************************

class _$TodosActions extends TodosActions {
  final ActionDispatcher<int> updateTodoStatus =
      new ActionDispatcher<int>('TodosActions-updateTodoStatus');
  final ActionDispatcher<int> removeTodo =
      new ActionDispatcher<int>('TodosActions-removeTodo');
  final ActionDispatcher<Todo> addTodo =
      new ActionDispatcher<Todo>('TodosActions-addTodo');
  factory _$TodosActions() => new _$TodosActions._();
  _$TodosActions._() : super._();
  syncWithStore(dispatcher) {
    updateTodoStatus.syncWithStore(dispatcher);
    removeTodo.syncWithStore(dispatcher);
    addTodo.syncWithStore(dispatcher);
  }
}

class TodosActionsNames {
  static ActionName updateTodoStatus =
      new ActionName<int>('TodosActions-updateTodoStatus');
  static ActionName removeTodo = new ActionName<int>('TodosActions-removeTodo');
  static ActionName addTodo = new ActionName<Todo>('TodosActions-addTodo');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TodosReducer
// **************************************************************************

class _$TodosReducer extends TodosReducer {
  @override
  final BuiltMap<int, Todo> todosMap;

  factory _$TodosReducer([void updates(TodosReducerBuilder b)]) =>
      (new TodosReducerBuilder()..update(updates)).build();

  _$TodosReducer._({this.todosMap}) : super._() {
    if (todosMap == null) throw new ArgumentError.notNull('todosMap');
  }

  @override
  TodosReducer rebuild(void updates(TodosReducerBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodosReducerBuilder toBuilder() => new TodosReducerBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TodosReducer) return false;
    return todosMap == other.todosMap;
  }

  @override
  int get hashCode {
    return $jf($jc(0, todosMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodosReducer')
          ..add('todosMap', todosMap))
        .toString();
  }
}

class TodosReducerBuilder
    implements Builder<TodosReducer, TodosReducerBuilder> {
  _$TodosReducer _$v;

  MapBuilder<int, Todo> _todosMap;
  MapBuilder<int, Todo> get todosMap =>
      _$this._todosMap ??= new MapBuilder<int, Todo>();
  set todosMap(MapBuilder<int, Todo> todosMap) => _$this._todosMap = todosMap;

  TodosReducerBuilder();

  TodosReducerBuilder get _$this {
    if (_$v != null) {
      _todosMap = _$v.todosMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodosReducer other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$TodosReducer;
  }

  @override
  void update(void updates(TodosReducerBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodosReducer build() {
    final result = _$v ?? new _$TodosReducer._(todosMap: todosMap?.build());
    replace(result);
    return result;
  }
}
