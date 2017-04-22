// GENERATED CODE - DO NOT MODIFY BY HAND

part of creation_middleware;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class CreatorActions
// **************************************************************************

class _$CreatorActions extends CreatorActions {
  ActionDispatcher<String> createGroup =
      new ActionDispatcher<String>('CreatorActions-createGroup');

  ActionDispatcher<String> createTodo =
      new ActionDispatcher<String>('CreatorActions-createTodo');
  factory _$CreatorActions() => new _$CreatorActions._();
  _$CreatorActions._() : super._();
  syncWithStore(dispatcher) {
    createGroup.syncWithStore(dispatcher);
    createTodo.syncWithStore(dispatcher);
  }
}

class CreatorActionsNames {
  static ActionName createGroup =
      new ActionName<String>('CreatorActions-createGroup');
  static ActionName createTodo =
      new ActionName<String>('CreatorActions-createTodo');
}
