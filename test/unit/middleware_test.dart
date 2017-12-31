import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

void main() {
  group('middleware', () {
    Store<Counter, CounterBuilder, CounterActions> store;

    setup({int numMiddleware: 1}) {
      var actions = new CounterActions();
      var defaultValue = new Counter();
      final middleware =
          <Middleware<Counter, CounterBuilder, CounterActions>>[];
      for (int i = 0; i < numMiddleware; i++) {
        middleware.add(counterMiddleware);
      }

      store = new Store<Counter, CounterBuilder, CounterActions>(
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
      store.actions.middlewareActions.increment(0);
      expect(store.state.count, 3);
    });

    test('2 middlewares doubles count twice and updates state', () async {
      setup(numMiddleware: 2);
      final onStateChangeCompleter =
          new Completer<StoreChange<Counter, CounterBuilder, dynamic>>();
      final onStateChangeCompleter2 =
          new Completer<StoreChange<Counter, CounterBuilder, dynamic>>();

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
  });
}
