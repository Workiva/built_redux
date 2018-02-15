// GENERATED CODE - DO NOT MODIFY BY HAND

part of nested_models;

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$BaseActions extends BaseActions {
  factory _$BaseActions() => new _$BaseActions._();
  _$BaseActions._() : super._();

  final ActionDispatcher<Null> baseAction =
      new ActionDispatcher<Null>('BaseActions-baseAction');
  final ChildActions child = new ChildActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    baseAction.setDispatcher(dispatcher);
    child.setDispatcher(dispatcher);
  }
}

class BaseActionsNames {
  static final ActionName<Null> baseAction =
      new ActionName<Null>('BaseActions-baseAction');
}

class _$ChildActions extends ChildActions {
  factory _$ChildActions() => new _$ChildActions._();
  _$ChildActions._() : super._();

  final ActionDispatcher<Null> childAction =
      new ActionDispatcher<Null>('ChildActions-childAction');
  final GrandchildActions grandchild = new GrandchildActions();

  @override
  void setDispatcher(Dispatcher dispatcher) {
    childAction.setDispatcher(dispatcher);
    grandchild.setDispatcher(dispatcher);
  }
}

class ChildActionsNames {
  static final ActionName<Null> childAction =
      new ActionName<Null>('ChildActions-childAction');
}

class _$GrandchildActions extends GrandchildActions {
  factory _$GrandchildActions() => new _$GrandchildActions._();
  _$GrandchildActions._() : super._();

  final ActionDispatcher<Null> grandchildAction =
      new ActionDispatcher<Null>('GrandchildActions-grandchildAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    grandchildAction.setDispatcher(dispatcher);
  }
}

class GrandchildActionsNames {
  static final ActionName<Null> grandchildAction =
      new ActionName<Null>('GrandchildActions-grandchildAction');
}
