// GENERATED CODE - DO NOT MODIFY BY HAND

part of creation_middleware;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class CreatorActions
// **************************************************************************

class _$CreatorActions extends CreatorActions {
  final ActionMgr<String> createGroup = new ActionMgr<String>('createGroup');
  final ActionMgr<String> createTodo = new ActionMgr<String>('createTodo');
  factory _$CreatorActions() => new _$CreatorActions._();
  _$CreatorActions._() : super._();
  syncWithStore(dispatcher) {
    createGroup.syncWithStore(dispatcher);
    createTodo.syncWithStore(dispatcher);
  }
}

class CreatorActionsNames {
  static ActionName createGroup = new ActionName<String>('createGroup');
  static ActionName createTodo = new ActionName<String>('createTodo');
}
