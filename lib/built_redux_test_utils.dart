import 'package:test/test.dart';
import 'built_redux.dart';

/// [expectDispatched] verifies that a given action is dispatched
/// at a later time using expectAsync1. It runs the [verifier] function provided
/// when the action is called so you can perform expects on the payload.
/// It takes all of the same optional params as expectAsync.
void expectDispatched<T>(
  ActionDispatcher<T> actionDispatcher, {
  void Function(Action<T> action)? verifier,
  int count = 1,
  int max = 0,
  String? id,
  String? reason,
}) {
  actionDispatcher.setDispatcher(
    expectAsync1(
      (Action<dynamic> action) {
        if (verifier != null) verifier(action as Action<T>);
      },
      count: count,
      max: max,
      id: id,
      reason: reason,
    ),
  );
}
