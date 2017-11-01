import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

main() {
  group('state transformer', () {
    Store<BaseCounter, BaseCounterBuilder, BaseCounterActions> store;

    setUp(() {
      store = new Store(reducer, new BaseCounter(), new BaseCounterActions());
    });

    tearDown(() {
      store.dispose();
    });

    test('state transformer', () async {
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

    test('state transformer pause / resume', () async {
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
  });
}
