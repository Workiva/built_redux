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
      expect(store.state.count, 1);
      store.actions.increment(4);
      expect(store.state.count, 5);
    });

    test('nested built value', () async {
      setup();
      expect(store.state.nestedCounter.count, 1);
      store.actions.nestedCounterActions.increment(4);
      expect(store.state.nestedCounter.count, 5);
    });

    test('middleware action doubles count and updates state', () async {
      setup();
      expect(store.state.count, 1);
      store.actions.middlewareActions.increment(0);
      expect(store.state.count, 3);
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

      // should add double the current state twice
      store.actions.middlewareActions.increment(0);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
      stateChange = await onStateChangeCompleter2.future;
      expect(stateChange.prev.count, 3);
      expect(stateChange.next.count, 9);
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
      final completer = new Completer<SubstateChange<int>>();
      final sub = store.substateStream<int>((BaseCounter state) => state.count);
      sub.first.then(completer.complete);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.nestedCounterActions.increment(1);

      var change = await completer.future;
      expect(change.prev, 1);
      expect(change.next, 5);
    });

    test('state transformer pause / resume', () async {
      setup();
      StreamSubscription<SubstateChange<int>> sub;
      sub =
          store.substateStream<int>((BaseCounter state) => state.count).listen(
        expectAsync1((SubstateChange<int> change) {
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
      final completer = new Completer<BaseCounter>();
      store.nextState.first.then(completer.complete);
      store.actions.increment(4);
      var stateChange = await completer.future;
      expect(stateChange.count, 5);
    });

    test('nextSubstate stream', () async {
      setup();

      final sub = store.nextSubstate<int>((BaseCounter state) => state.count);
      final completer = new Completer<int>();
      sub.first.then(completer.complete);

      store.actions.increment(4);
      // would cause completer to complete twice and fail the test
      store.actions.nestedCounterActions.increment(1);

      var change = await completer.future;
      expect(change, 5);
    });

    test('ActionDispatcher<Null>', () async {
      setup();
      expect(store.state.count, 1);
      store.actions.incrementOne();
      expect(store.state.count, 2);
    });

    test('ActionDispatcher<Null> with null payload', () async {
      setup();
      expect(store.state.count, 1);
      store.actions.incrementOne(null);
      expect(store.state.count, 2);
    });

    test('ActionDispatcher<SomeTypeDef>', () async {
      setup();
      expect(store.state.count, 1);
      store.actions.thunkDispatcher(
          (MiddlewareApi<BaseCounter, BaseCounterBuilder, BaseCounterActions>
              api) {
        api.actions.incrementOne();
      });
      expect(store.state.count, 2);
    });

    test('payload with generic type', () async {
      setup();
      expect(store.state.count, 1);
      store.actions.genericAction1(<int>[1, 2, 3]);
      expect(store.state.count, 7);
      store.actions.genericAction2(<String, List<int>>{
        'add': [1, 2, 3]
      });
      expect(store.state.count, 13);
    });
  });
}
