library todo;

import 'package:built_value/built_value.dart';

part 'todo.g.dart';

abstract class Todo implements Built<Todo, TodoBuilder> {
  int get id;
  String get text;
  bool get done;

  Todo._();
  factory Todo([updates(TodoBuilder b)]) = _$Todo;
}
