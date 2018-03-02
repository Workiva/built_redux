library nested_models;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'nested_models.built_redux.g.dart';
part 'nested_models.g.dart';

// BaseActions is the main action class that contains
// all actions for your store. It is passed to the store at
// instantiation. It contains an action dispatcher and a reference
// to an instance of ChildActions.
abstract class BaseActions extends ReduxActions {
  BaseActions._();
  factory BaseActions() => new _$BaseActions();

  ActionDispatcher<Null> get baseAction;
  ChildActions get child;
}

// ChildActions contains an action dispatcher and a reference
// to an instance of GrandchildActions.
abstract class ChildActions extends ReduxActions {
  ChildActions._();
  factory ChildActions() => new _$ChildActions();

  ActionDispatcher<Null> get childAction;
  GrandchildActions get grandchild;
}

// ChildActions contains an action dispatcher.
abstract class GrandchildActions extends ReduxActions {
  GrandchildActions._();
  factory GrandchildActions() => new _$GrandchildActions();

  ActionDispatcher<Null> get grandchildAction;
}

// Base is the main built class that contains all of the state
// for your store. It is passed to the store at instantiation.
// It contains an count and a reference to an instance of Child.
abstract class Base implements Built<Base, BaseBuilder> {
  int get count;
  Child get child;

  Base._();
  factory Base() => new _$Base._(count: 0, child: new Child());
}

// Child contains an count and a reference to an instance of Grandchild.
abstract class Child implements Built<Child, ChildBuilder> {
  int get count;
  Grandchild get grandchild;

  Child._();
  factory Child() => new _$Child._(count: 0, grandchild: new Grandchild());
}

// Grandchild contains an count
abstract class Grandchild implements Built<Grandchild, GrandchildBuilder> {
  int get count;

  Grandchild._();
  factory Grandchild() => new _$Grandchild._(count: 0);
}

// getBaseReducer returns a reducer that rebuilds Base when childAction is dispatched.
// It combines the child and grandchild ReducerBuilders.
// This ReducerBuilder could be modified to handle more
// actions that could rebuild any peice of state within the Base object.
// Reducers added to the ReducerBuilder must have the signature:
// (Base, Action<T>, BaseBuilder)
Reducer<Base, BaseBuilder, dynamic> getBaseReducer() =>
    (new ReducerBuilder<Base, BaseBuilder>()
          ..add<Null>(BaseActionsNames.baseAction, (s, a, b) => b.count++)
          ..combineNested(getChildReducer())
          ..combineNested(getGrandchildReducer()))
        .build();

// getChildReducer returns a nested reducer builder that rebuilds the
// child built when childAction is dispatched. This NestedReducerBuilder
// could be modified to handle more actions that rebuild Child.
// Reducers added to the NestedReducerBuilder must have the signature:
// (Child, Action<T>, ChildBuilder)
NestedReducerBuilder<Base, BaseBuilder, Child, ChildBuilder>
    getChildReducer() =>
        (new NestedReducerBuilder<Base, BaseBuilder, Child, ChildBuilder>(
            (s) => s.child, (b) => b.child)
          ..add<Null>(ChildActionsNames.childAction, (s, a, b) => b.count++));

// getGrandchildReducer returns a nested reducer builder that rebuilds the
// grandchild built when grandchildAction is dispatched. This NestedReducerBuilder
// could be modified to handle more actions that rebuild Grandchild.
// Reducers added to the NestedReducerBuilder must have the signature:
// (Grandchild, Action<T>, GrandchildBuilder)
NestedReducerBuilder<Base, BaseBuilder, Grandchild, GrandchildBuilder>
    getGrandchildReducer() => new NestedReducerBuilder<
        Base,
        BaseBuilder,
        Grandchild,
        GrandchildBuilder>((s) => s.child.grandchild, (b) => b.child.grandchild)
      ..add<Null>(
          GrandchildActionsNames.grandchildAction, (s, a, b) => b.count++);
