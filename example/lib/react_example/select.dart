import 'package:recompose_dart/recompose_dart.dart';
import 'package:over_react/over_react.dart';
import 'package:built_collection/built_collection.dart';

typedef OnSelect(int id);

class Nameable {
  String name;
  int id;
}

class SelectProps<T extends Nameable> {
  OnSelect onSelect;
  int currentGroup;
  BuiltMap<int, T> optionMap;
  String label;
}

FunctionalComponent<SelectProps> selectComponent = branch<SelectProps>(
  (SelectProps props) => props.optionMap.length > 0,
  selector,
  emptySelector,
);

ReactElement selector(SelectProps props) => (Dom.select()
      ..onChange = ((e) => props.onSelect(int.parse(e.target.value)))
      ..value = props.currentGroup
      ..label = props.label)(
      props.optionMap.values.map(
        (Nameable option) => (Dom.option()
          ..key = option.id
          ..value = option.id)(option.name),
      ),
    );

ReactElement emptySelector(SelectProps props) => Dom.h6()('No ${props.label}s exist!');
