import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

void main() {
  group('store', () {
    Store<BaseCounter, BaseCounterBuilder, BaseCounterActions> store;

    setUp(() {
      var actions = new BaseCounterActions();
      var defaultValue = new BaseCounter();

      store = new Store<BaseCounter, BaseCounterBuilder, BaseCounterActions>(
          reducer, defaultValue, actions);
    });

    tearDown(() {
      store.dispose();
    });

    test('basic action fires stream', () async {
      final onStateChangeCompleter = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, dynamic>>();
      store.stream.listen(onStateChangeCompleter.complete);
      store.actions.increment(2);
      final stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
    });

    test('store change handler', () async {
      final onStateChangeCompleter = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, dynamic>>();

      final storeChagneHandler = createChangeHandler(onStateChangeCompleter);
      storeChagneHandler.build(store);
      // dipatch 2 different actions, since the handler is only set to listen to base.increment
      // if both are handled by the handler the completer with throw an error
      store.actions.decrement(1);
      store.actions.increment(4);

      final stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 0);
      expect(stateChange.next.count, 4);
      storeChagneHandler.dispose();
    });

    test('replaceState', () async {
      final onStateChangeCompleter = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, dynamic>>();
      final onStateChangeCompleter2 = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, dynamic>>();

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

      store.replaceState(new BaseCounter());
      stateChange = await onStateChangeCompleter2.future;
      expect(stateChange.prev.count, 5);
      expect(stateChange.next.count, 1);
    });

    test('substateStream', () async {
      final completer = new Completer<SubstateChange<int>>();
      final sub = store.substateStream<int>((BaseCounter state) => state.count);
      sub.first.then(completer.complete);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.decrement(1);

      var change = await completer.future;
      expect(change.prev, 1);
      expect(change.next, 5);
    });

    test('nextState stream', () async {
      final completer = new Completer<BaseCounter>();
      store.nextState.first.then(completer.complete);
      store.actions.increment(4);
      var stateChange = await completer.future;
      expect(stateChange.count, 5);
    });

    test('nextSubstate stream', () async {
      final sub = store.nextSubstate<int>((BaseCounter state) => state.count);
      final completer = new Completer<int>();
      sub.first.then(completer.complete);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.decrement(2);

      var change = await completer.future;
      expect(change, 5);
    });

    test('actionStream', () async {
      final onStateChangeCompleter =
          new Completer<StoreChange<BaseCounter, BaseCounterBuilder, int>>();
      store
          .actionStream(BaseCounterActionsNames.increment)
          .listen(onStateChangeCompleter.complete);
      store.actions.increment(2);
      final stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
      expect(stateChange.action.payload, 2);
    });
  });
}
