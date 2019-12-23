library inheritance_test_models;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'inheritance_test_models.g.dart';

// ChildActions is the only of the three that yield the generated classes
abstract class ChildActions extends ParentActions {
  ActionDispatcher<Null> get childAction;

  ChildActions._();
  factory ChildActions() => _$ChildActions();
}

// ParentActions will be inherited by ChildActions
abstract class ParentActions extends GrandparentActions {
  ActionDispatcher<Null> get parentAction;
}

// GrandparentActions will be inherited by ChildActions
abstract class GrandparentActions extends ReduxActions {
  ActionDispatcher<Null> get grandparentAction;
}

// Parent will be impelemented by Child
@BuiltValue(instantiable: false)
abstract class Parent {
  int get parentCount;
}

// Grandparent will be impelemented by Child
@BuiltValue(instantiable: false)
abstract class Grandparent {
  int get grandparentCount;
}

// Child implements in Parent & Grandparent
abstract class Child
    implements Parent, Grandparent, Built<Child, ChildBuilder> {
  int get childCount;

  Child._();
  factory Child() => _$Child._(
        childCount: 0,
        parentCount: 0,
        grandparentCount: 0,
      );
}

// getBaseReducer returns a reducer that rebuilds Child when childAction is dispatched.
// It combines the parentBuilder and grandparentBuilder AbstractReducerBuilders.
// This ReducerBuilder could be modified to handle more
// actions that could rebuild any peice of state within the Child object.
// Reducers added to the ReducerBuilder must have one of the following signatures:
// (Child, Action<T>, ChildBuilder)
// (Parent, Action<T>, ParentBuilder)
// (Grandparent, Action<T>, GrandparentBuilder)
Reducer<Child, ChildBuilder, dynamic> getInheritanceReducer() =>
    (ReducerBuilder<Child, ChildBuilder>()
          ..add<Null>(ChildActionsNames.childAction,
              (state, action, builder) => builder.childCount++)
          ..add<Null>(
              ChildActionsNames.parentAction,
              (Parent state, action, ParentBuilder builder) =>
                  builder.parentCount += 2)
          ..combineAbstract(grandparentBuilder.build()))
        .build();

// grandparentBuilderis a AbstractReducerBuilder that rebuilds values from the Grandparent
// interface when grandparentAction is dispatched. This AbstractReducerBuilder
// could be modified to handle more actions that rebuild values from the Grandparent interface.
// Reducers added to the AbstractReducerBuilder must have the signature:
// (Grandparent, Action<T>, GrandparentBuilder)
AbstractReducerBuilder<Grandparent, GrandparentBuilder> grandparentBuilder =
    AbstractReducerBuilder<Grandparent, GrandparentBuilder>()
      ..add<Null>(ChildActionsNames.grandparentAction,
          (state, action, builder) => builder.grandparentCount += 3);
