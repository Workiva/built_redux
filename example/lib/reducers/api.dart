import 'package:built_collection/built_collection.dart';

import 'todo.dart';
import 'group.dart';
import 'app_state.dart';

Group groupById(AppState state, int id) => state.groups.groupMap[id];

Group currentGroup(AppState state) => groupById(state, state.currentGroup);

BuiltMap<int, Todo> currentGroupTodos(AppState state) {
  final group = currentGroup(state);
  if (group == null) return new BuiltMap<int, Todo>();
  // print("HI    $group $group.todoIds");
  return _filterMap<int, Todo>(
    state.todos.todosMap,
    group.todoIds,
  );
}

BuiltMap<K, V> _filterMap<K, V>(BuiltMap<K, V> map, Iterable<K> ids) {
  var filtered = new Map<K, V>();
  for (var id in ids) filtered[id] = map[id];
  return map.rebuild((builder) => builder
    ..clear()
    ..addAll(filtered));
}
