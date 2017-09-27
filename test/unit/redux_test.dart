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

      var middleware =
          <Middleware<BaseCounter, BaseCounterBuilder, BaseCounterActions>>[
        fooTypedefMiddleware
      ];
      for (int i = 0; i < numMiddleware; i++) {
        middleware.add(counterMiddleware);
      }

      store = new Store(
        reducer,
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
      store.actions.increment(4);
      var stateChange = await store.stream.first;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 5);
    });

    test('nested built value', () async {
      setup();
      store.actions.nestedCounterActions.increment(4);
      var stateChange = await store.stream.first;
      expect(stateChange.prev.nestedCounter.count, 1);
      expect(stateChange.next.nestedCounter.count, 5);
    });

    test('middleware action doubles count and updates state', () async {
      setup();
      store.actions.middlewareActions.increment(0);
      var stateChange = await store.stream.first;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
    });

    test('2 middlewares doubles count twice and updates state', () async {
      setup(numMiddleware: 2);
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
      // should add 2 twice
      store.actions.middlewareActions.increment(0);
      var stateChange = await store.stream.first;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
      stateChange = await store.stream.first;
      expect(stateChange.prev.count, 3);
      expect(stateChange.next.count, 5);
    });

    test('store change handler', () async {
      setup();
      Completer onStateChangeCompleter = new Completer<
          StoreChange<BaseCounter, BaseCounterBuilder, BaseCounterActions>>();

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

    test('replaceState', () async {
      setup();
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

    test('state transformer', () async {
      setup();

      final sub = store.substateStream<int>((BaseCounter state) => state.count);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.nestedCounterActions.increment(1);

      var change = await sub.first;
      expect(change.prev, 1);
      expect(change.next, 5);
    });

    test('state transformer pause / resume', () async {
      setup();
      StreamSubscription<SubStateChange<int>> sub;
      sub =
          store.substateStream<int>((BaseCounter state) => state.count).listen(
        expectAsync1((SubStateChange<int> change) {
          expect(change.prev, 1);
          expect(change.next, 5);
          sub.cancel();
        }),
      );

      store.actions.increment(4);
      sub.pause();
      sub.resume();
    });

    test('state transformer handles errors', () async {
      setup();

      Completer onStreamError = new Completer<Error>();

      final sub = store
          .substateStream<int>(
              (BaseCounter state) => state.indexOutOfRangeList[1])
          .handleError(onStreamError.complete)
          .listen((_) => fail("error should be handled"));

      store.actions.increment(4);
      await onStreamError.future;
      sub.cancel();
    });

    test('nextState stream', () async {
      setup();
      store.actions.increment(4);
      var stateChange = await store.nextState.first;
      expect(stateChange.count, 5);
    });

    test('nextSubState stream', () async {
      setup();

      final sub = store.nextSubState<int>((BaseCounter state) => state.count);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.nestedCounterActions.increment(1);

      var change = await sub.first;
      expect(change, 5);
    });

    test('ActionDispatcher<Null>', () async {
      setup();
      store.actions.incrementOne(null);
      var stateChange = await store.stream.first;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 2);
    });

    test('ActionDispatcher<SomeTypeDef>', () async {
      setup();
      store.actions.foo((MiddlewareApi api) {
        (api.actions as BaseCounterActions).incrementOne(null);
      });
      var stateChange = await store.stream.first;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 2);
    });

    test('payload with generic type', () async {
      setup();
      store.actions.genericAction1(<int>[1, 2, 3]);
      var stateChange = await store.stream.first;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 7);

      store.actions.genericAction2(<String, List<int>>{
        'add': [1, 2, 3]
      });
      stateChange = await store.stream.first;
      expect(stateChange.prev.count, 7);
      expect(stateChange.next.count, 13);
    });
  });
}
