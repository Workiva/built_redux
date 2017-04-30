// GENERATED CODE - DO NOT MODIFY BY HAND

part of module;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class TodoProps
// **************************************************************************

class _$TodoProps extends TodoProps {
  @override
  final AppStateActions actions;
  @override
  final Group currentGroup;
  @override
  final BuiltMap<int, Group> groups;
  @override
  final BuiltMap<int, Todo> todos;
  @override
  final String title;

  factory _$TodoProps([void updates(TodoPropsBuilder b)]) =>
      (new TodoPropsBuilder()..update(updates)).build();

  _$TodoProps._(
      {this.actions, this.currentGroup, this.groups, this.todos, this.title})
      : super._() {
    if (actions == null) throw new ArgumentError.notNull('actions');
    if (groups == null) throw new ArgumentError.notNull('groups');
    if (todos == null) throw new ArgumentError.notNull('todos');
    if (title == null) throw new ArgumentError.notNull('title');
  }

  @override
  TodoProps rebuild(void updates(TodoPropsBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoPropsBuilder toBuilder() => new TodoPropsBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TodoProps) return false;
    return actions == other.actions &&
        currentGroup == other.currentGroup &&
        groups == other.groups &&
        todos == other.todos &&
        title == other.title;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, actions.hashCode), currentGroup.hashCode),
                groups.hashCode),
            todos.hashCode),
        title.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoProps')
          ..add('actions', actions)
          ..add('currentGroup', currentGroup)
          ..add('groups', groups)
          ..add('todos', todos)
          ..add('title', title))
        .toString();
  }
}

class TodoPropsBuilder implements Builder<TodoProps, TodoPropsBuilder> {
  _$TodoProps _$v;

  AppStateActions _actions;
  AppStateActions get actions => _$this._actions;
  set actions(AppStateActions actions) => _$this._actions = actions;

  GroupBuilder _currentGroup;
  GroupBuilder get currentGroup => _$this._currentGroup ??= new GroupBuilder();
  set currentGroup(GroupBuilder currentGroup) =>
      _$this._currentGroup = currentGroup;

  MapBuilder<int, Group> _groups;
  MapBuilder<int, Group> get groups =>
      _$this._groups ??= new MapBuilder<int, Group>();
  set groups(MapBuilder<int, Group> groups) => _$this._groups = groups;

  MapBuilder<int, Todo> _todos;
  MapBuilder<int, Todo> get todos =>
      _$this._todos ??= new MapBuilder<int, Todo>();
  set todos(MapBuilder<int, Todo> todos) => _$this._todos = todos;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  TodoPropsBuilder();

  TodoPropsBuilder get _$this {
    if (_$v != null) {
      _actions = _$v.actions;
      _currentGroup = _$v.currentGroup?.toBuilder();
      _groups = _$v.groups?.toBuilder();
      _todos = _$v.todos?.toBuilder();
      _title = _$v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoProps other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$TodoProps;
  }

  @override
  void update(void updates(TodoPropsBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoProps build() {
    final result = _$v ??
        new _$TodoProps._(
            actions: actions,
            currentGroup: _currentGroup?.build(),
            groups: groups?.build(),
            todos: todos?.build(),
            title: title);
    replace(result);
    return result;
  }
}
