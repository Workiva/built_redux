// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_generics_models.dart';

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$ActionGenericsActions extends ActionGenericsActions {
  factory _$ActionGenericsActions() => new _$ActionGenericsActions._();
  _$ActionGenericsActions._() : super._();

  final ActionDispatcher<int> intAction =
      new ActionDispatcher<int>('ActionGenericsActions-intAction');
  final ActionDispatcher<Null> nullAction =
      new ActionDispatcher<Null>('ActionGenericsActions-nullAction');
  final ActionDispatcher<List<int>> listIntAction =
      new ActionDispatcher<List<int>>('ActionGenericsActions-listIntAction');
  final ActionDispatcher<Map<String, List<int>>> mapStringToListIntAction =
      new ActionDispatcher<Map<String, List<int>>>(
          'ActionGenericsActions-mapStringToListIntAction');
  final ActionDispatcher<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>> typdefAction = new ActionDispatcher<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>>('ActionGenericsActions-typdefAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    intAction.setDispatcher(dispatcher);
    nullAction.setDispatcher(dispatcher);
    listIntAction.setDispatcher(dispatcher);
    mapStringToListIntAction.setDispatcher(dispatcher);
    typdefAction.setDispatcher(dispatcher);
  }
}

class ActionGenericsActionsNames {
  static final ActionName<int> intAction =
      new ActionName<int>('ActionGenericsActions-intAction');
  static final ActionName<Null> nullAction =
      new ActionName<Null>('ActionGenericsActions-nullAction');
  static final ActionName<List<int>> listIntAction =
      new ActionName<List<int>>('ActionGenericsActions-listIntAction');
  static final ActionName<Map<String, List<int>>> mapStringToListIntAction =
      new ActionName<Map<String, List<int>>>(
          'ActionGenericsActions-mapStringToListIntAction');
  static final ActionName<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>> typdefAction = new ActionName<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>>('ActionGenericsActions-typdefAction');
}
