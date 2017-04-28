import 'package:built_collection/built_collection.dart';

BuiltMap<K, V> filterMap<K, V>(BuiltMap<K, V> map, Iterable<K> ids) {
  var filtered = new Map<K, V>();
  for (var id in ids) filtered[id] = map[id];
  return map.rebuild((MapBuilder builder) => builder
    ..clear()
    ..addAll(filtered));
}
