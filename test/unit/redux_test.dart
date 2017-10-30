import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

main() {
  group('store', () {
    Store<BaseCounter, BaseCounterBuilder, BaseCounterActions> store;

    setUp(() {
      var actions = new BaseCounterActions();
      var defaultValue = new BaseCounter();

      store = new Store(reducer, defaultValue, actions);
    });

    tearDown(() {
      store.dispose();
    });

    test('basic action fires stream', () async {
      Completer onStateChangeCompleter = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();
      store.stream.listen(onStateChangeCompleter.complete);
      store.actions.increment(2);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
    });

    test('store change handler', () async {
      Completer onStateChangeCompleter = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();

      var storeChagneHandler = createChangeHandler(onStateChangeCompleter);
      storeChagneHandler.build(store);
      // dipatch 2 different actions, since the handler is only set to listen to base.increment
      // if both are handled by the handler the completer with throw an error
      store.actions.decrement(1);
      store.actions.increment(4);

      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 0);
      expect(stateChange.next.count, 4);
      storeChagneHandler.dispose();
    });

    test('replaceState', () async {
      Completer onStateChangeCompleter = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();
      Completer onStateChangeCompleter2 = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();

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
  });
}
