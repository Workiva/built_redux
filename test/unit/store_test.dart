import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

void main() {
  group('store', () {
    late Store<Counter, CounterBuilder, CounterActions> store;

    setUp(() {
      var actions = CounterActions();
      var defaultValue = Counter();

      store = Store<Counter, CounterBuilder, CounterActions>(
          reducer, defaultValue, actions);
    });

    tearDown(() {
      store.dispose();
    });

    test('basic action fires stream', () async {
      final onStateChangeCompleter =
          Completer<StoreChange<Counter, CounterBuilder, dynamic>>();
      store.stream.listen(onStateChangeCompleter.complete);
      store.actions.increment(2);
      final stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
    });

    test('store change handler', () async {
      final onStateChangeCompleter =
          Completer<StoreChange<Counter, CounterBuilder, dynamic>>();

      final storeChangeHandler = createChangeHandler(onStateChangeCompleter);
      storeChangeHandler.build(store);
      // dispatch 2 different actions, since the handler is only set to listen to base.increment
      // if both are handled by the handler the completer with throw an error
      store.actions.incrementOther(1);
      store.actions.increment(4);

      final stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 5);
      storeChangeHandler.dispose();
    });

    test('replaceState', () async {
      final onStateChangeCompleter =
          Completer<StoreChange<Counter, CounterBuilder, dynamic>>();
      final onStateChangeCompleter2 =
          Completer<StoreChange<Counter, CounterBuilder, dynamic>>();

      store.stream.listen((state) {
        if (!onStateChangeCompleter.isCompleted)
          onStateChangeCompleter.complete(state);
        else
          onStateChangeCompleter2.complete(state);
      });

      store.actions.increment(4);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 5);

      store.replaceState(Counter());
      stateChange = await onStateChangeCompleter2.future;
      expect(stateChange.prev.count, 5);
      expect(stateChange.next.count, 1);
    });

    test('substateStream', () async {
      final completer = Completer<SubstateChange<int>>();
      final sub = store.substateStream<int>((Counter state) => state.count);
      sub.listen(completer.complete);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.incrementOther(1);

      var change = await completer.future;
      expect(change.prev, 1);
      expect(change.next, 5);
    });

    test('nextState stream', () async {
      final completer = Completer<Counter>();
      store.nextState.listen(completer.complete);
      store.actions.increment(4);
      var stateChange = await completer.future;
      expect(stateChange.count, 5);
    });

    test('nextSubstate stream', () async {
      final sub = store.nextSubstate<int>((Counter state) => state.count);
      final completer = Completer<int>();
      sub.listen(completer.complete);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.incrementOther(2);

      var change = await completer.future;
      expect(change, 5);
    });

    test('actionStream', () async {
      final onStateChangeCompleter =
          Completer<StoreChange<Counter, CounterBuilder, int>>();
      store
          .actionStream(CounterActionsNames.increment)
          .listen(onStateChangeCompleter.complete);
      store.actions.increment(2);
      final stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
      expect(stateChange.action.payload, 2);
    });

    test('should not reset state and actions before closing', () async {
      store
          .substateStream((s) => s)
          .listen((_) => expect(store.actions, isNotNull));

      // intentionally don't wait
      store.dispose();

      store.actions.increment(1);
    });

    test('should not publish pending events if disposed', () async {
      store.nextState.listen(expectAsync1((Counter _) {
        expect(store.actions, isNotNull);
      }));

      store.actions.increment(1);

      // intentionally don't wait
      store.dispose();
    });

    test('awaiting dispose', () async {
      await store.dispose();
      expect(store.state, null);
      expect(store.actions, null);
    });

    test('action toString', () async {
      final action = Action('foo', 1);
      final expectedString = 'Action {\n  name: foo,\n  payload: 1,\n}';

      expect('$action', expectedString);
    });
  });
}
