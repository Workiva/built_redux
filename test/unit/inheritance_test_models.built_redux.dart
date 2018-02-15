// GENERATED CODE - DO NOT MODIFY BY HAND

part of inheritance_test_models;

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$ChildActions extends ChildActions {
  factory _$ChildActions() => new _$ChildActions._();
  _$ChildActions._() : super._();

  final ActionDispatcher<Null> childAction =
      new ActionDispatcher<Null>('ChildActions-childAction');
  final ActionDispatcher<Null> parentAction =
      new ActionDispatcher<Null>('ParentActions-parentAction');
  final ActionDispatcher<Null> grandparentAction =
      new ActionDispatcher<Null>('GrandparentActions-grandparentAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    childAction.setDispatcher(dispatcher);
    parentAction.setDispatcher(dispatcher);
    grandparentAction.setDispatcher(dispatcher);
  }
}

class ChildActionsNames {
  static final ActionName<Null> childAction =
      new ActionName<Null>('ChildActions-childAction');
  static final ActionName<Null> parentAction =
      new ActionName<Null>('ParentActions-parentAction');
  static final ActionName<Null> grandparentAction =
      new ActionName<Null>('GrandparentActions-grandparentAction');
}

class ParentActionsNames {
  static final ActionName<Null> parentAction =
      new ActionName<Null>('ParentActions-parentAction');
  static final ActionName<Null> grandparentAction =
      new ActionName<Null>('GrandparentActions-grandparentAction');
}

class GrandparentActionsNames {
  static final ActionName<Null> grandparentAction =
      new ActionName<Null>('GrandparentActions-grandparentAction');
}
