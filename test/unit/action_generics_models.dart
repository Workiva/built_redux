library action_generics_models;

import 'dart:async';
import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

part 'action_generics_models.g.dart';

/// Used to test code generation when the generic type of an action is a
/// `typedef`
typedef ThunkTypedef<V extends Built<V, B>, B extends Builder<V, B>,
        A extends ReduxActions>
    = FutureOr<void> Function(MiddlewareApi<V, B, A> api);

class Foo<T> {}

class ClassWithBuilt<V extends Built<V, B>, B extends Builder<V, B>> {}

// ActionGenerics contains actions that have payload
// of different generic types. This is mainly to test the generation of
// the action classes.
abstract class ActionGenericsActions extends ReduxActions {
  ActionGenericsActions._();
  factory ActionGenericsActions() => _$ActionGenericsActions();

  ActionDispatcher<int> get intAction;
  ActionDispatcher<Null> get nullAction;
  ActionDispatcher<Set<int>> get setIntAction;
  ActionDispatcher<List<int>> get listIntAction;
  ActionDispatcher<Map<String, List<int>>> get mapStringToListIntAction;
  ActionDispatcher<
      ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>> get typdefAction;
  ActionDispatcher<Foo<int>> get fooAction;
  ActionDispatcher<ClassWithBuilt<ActionGenerics, ActionGenericsBuilder>>
      get classWithBuiltAction;
}

abstract class ActionGenerics
    implements Built<ActionGenerics, ActionGenericsBuilder> {
  int get count;

  ActionGenerics._();
  factory ActionGenerics() => _$ActionGenerics._(count: 0);
}

Reducer<ActionGenerics, ActionGenericsBuilder, dynamic>
    getActionGenericsReducer() =>
        (ReducerBuilder<ActionGenerics, ActionGenericsBuilder>()
              ..add<int>(ActionGenericsActionsNames.intAction,
                  (s, a, b) => b.count = s.count + a.payload)
              ..add<Null>(
                  ActionGenericsActionsNames.nullAction, (s, a, b) => b.count++)
              ..add<List<int>>(
                  ActionGenericsActionsNames.listIntAction,
                  (s, a, b) =>
                      b.count += a.payload.fold<int>(0, (c, n) => c + n))
              ..add<Map<String, List<int>>>(
                  ActionGenericsActionsNames.mapStringToListIntAction,
                  (s, a, b) =>
                      b.count += a.payload['k'].fold<int>(0, (c, n) => c + n)))
            .build();

NextActionHandler thunkMiddleware(
  MiddlewareApi<ActionGenerics, ActionGenericsBuilder, ActionGenericsActions>
      api,
) =>
    (ActionHandler next) => (Action a) {
          if (a.payload is ThunkTypedef<ActionGenerics, ActionGenericsBuilder,
              ActionGenericsActions>)
            a.payload(api);
          else
            next(a);
        };
