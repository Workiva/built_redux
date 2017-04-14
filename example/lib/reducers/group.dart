library group;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'group.g.dart';

abstract class Group implements Built<Group, GroupBuilder> {
  int get id;
  String get name;
  bool get done;
  BuiltList<int> get todoIds;

  Group._();
  factory Group([updates(GroupBuilder b)]) = _$Group;
}
