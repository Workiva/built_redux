import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

main() {
  group('redux', () {
    Store<BaseCounter, BaseCounterBuilder, BaseCounterActions> store;

    setup({int numMiddleware: 1}) {
      var actions = new BaseCounterActions();
      var defaultValue = new BaseCounter();

      var middleware = new List<Middleware>();
      for (int i = 0; i < numMiddleware; i++) {
        middleware.add(counterMiddleware);
      }

      store = new Store(
        defaultValue,
        actions,
        middleware: middleware,
      );
    }

    tearDown(() {
      store.dispose();
    });

    test('base action updates state', () async {
      setup();
      Completer onStateChangeCompleter =
          new Completer<StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();
      store.stream.listen((StoreChange<BaseCounter, BaseCounterBuilder, dynamic> state) =>
          onStateChangeCompleter.complete(state));
      store.actions.increment(4);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 5);
    });

    test('nested action updates state', () async {
      setup();
      Completer onStateChangeCompleter =
          new Completer<StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();
      store.stream.listen((state) => onStateChangeCompleter.complete(state));
      store.actions.nestedCounterActions.increment(4);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.nestedCounter.count, 1);
      expect(stateChange.next.nestedCounter.count, 5);
    });

    test('middleware action doubles count and updates state', () async {
      setup();
      Completer onStateChangeCompleter =
          new Completer<StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();
      store.stream.listen((state) => onStateChangeCompleter.complete(state));
      store.actions.middlewareActions.increment(0);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
    });

    test('2 middlewares doubles count twice and updates state', () async {
      setup(numMiddleware: 2);
      Completer onStateChangeCompleter =
          new Completer<StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();
      Completer onStateChangeCompleter2 =
          new Completer<StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();

      store.stream.listen((state) {
        if (!onStateChangeCompleter.isCompleted)
          onStateChangeCompleter.complete(state);
        else
          onStateChangeCompleter2.complete(state);
      });
      // should add 2 twice
      store.actions.middlewareActions.increment(0);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
      var stateChange2 = await onStateChangeCompleter2.future;
      expect(stateChange2.prev.count, 3);
      expect(stateChange2.next.count, 5);
    });

    test('store change handler', () async {
      setup();
      Completer onStateChangeCompleter =
          new Completer<StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();

      var storeChagneHandler = createChangeHandler(onStateChangeCompleter);
      storeChagneHandler.build(store);
      // dipatch 2 different actions, since the handler is only set to listen to base.increment
      // if both are handled by the handler the completer with throw an error
      store.actions.nestedCounterActions.increment(4);
      store.actions.increment(4);

      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 5);
      storeChagneHandler.dispose();
    });

    test('store change handler', () async {
      setup();

      Completer onStreamFiredCompleter = new Completer<SubStateChange<int>>();

      final _sub = store
          .substateStream<int>((BaseCounter state) => state.count)
          .listen(onStreamFiredCompleter.complete);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.nestedCounterActions.increment(1);

      var change = await onStreamFiredCompleter.future;
      expect(change.next, 5);
      expect(change.next, 5);
      _sub.cancel();
    });
  });
}
