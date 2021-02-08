import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

void main() {
  group('middleware', () {
    late Store<Counter, CounterBuilder, CounterActions> store;

    setup({int numMiddleware = 1}) {
      var actions = CounterActions();
      var defaultValue = Counter();
      final middleware =
          <Middleware<Counter, CounterBuilder, CounterActions>>[];
      for (int i = 0; i < numMiddleware; i++) {
        middleware.add(counterMiddleware);
      }

      store = Store<Counter, CounterBuilder, CounterActions>(
        reducer,
        defaultValue,
        actions,
        middleware: middleware,
      );
    }

    tearDown(() {
      store.dispose();
    });

    test('1 middleware doubles count and updates state', () async {
      setup();
      expect(store.state.count, 1);
      store.actions.middlewareActions.doubleIt(0);
      expect(store.state.count, 3);
    });

    test('2 middlewares doubles count twice and updates state', () async {
      setup(numMiddleware: 2);
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

      // should add double the current state twice
      store.actions.middlewareActions.doubleIt(0);
      var stateChange = await onStateChangeCompleter.future;
      expect(stateChange.prev.count, 1);
      expect(stateChange.next.count, 3);
      stateChange = await onStateChangeCompleter2.future;
      expect(stateChange.prev.count, 3);
      expect(stateChange.next.count, 9);
    });

    test('combine works with tripleIt', () async {
      setup();
      expect(store.state.count, 1);
      store.actions.middlewareActions.tripleIt(0);
      expect(store.state.count, 4);
    });

    test('combineNested works with SubCounter doubleIt', () async {
      setup();
      expect(store.state.subCounter.subCount, 1);
      store.actions.subCounterActions.doubleIt(0);
      expect(store.state.subCounter.subCount, 3);
    });
  });
}
