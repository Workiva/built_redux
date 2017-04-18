import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

main() {
  group('redux', () {
    Store<BaseCounter, BaseCounterActions> store;

    setUp(() {
      var actions = new BaseCounterActions();
      var defaultValue = new BaseCounter((BaseCounterBuilder b) => b
        ..count = 0
        ..nestedCounter = new NestedCounter((NestedCounterBuilder b) => b..count = 0).toBuilder());
      store = new Store(
        defaultValue,
        actions,
        middleware: [createCounterMiddleware],
      );
    });

    tearDown(() {
      store.dispose();
    });

    test('base action updates state', () async {
      Completer onStateChangeCompleter = new Completer<BaseCounter>();
      store.subscribe.listen((BaseCounter state) => onStateChangeCompleter.complete(state));
      store.actions.increment(2);
      var nextState = await onStateChangeCompleter.future;
      expect(nextState.count, 2);
    });

    test('nested action updates state', () async {
      Completer onStateChangeCompleter = new Completer<BaseCounter>();
      store.subscribe.listen((BaseCounter state) => onStateChangeCompleter.complete(state));
      store.actions.nestedCounterActions.increment(2);
      var nextState = await onStateChangeCompleter.future;
      expect(nextState.nestedCounter.count, 2);
    });

    test('middleware action doubles count and updates state', () async {
      Completer onStateChangeCompleter = new Completer<BaseCounter>();
      store.subscribe.listen((BaseCounter state) => onStateChangeCompleter.complete(state));
      store.actions.middlewareActions.increment(2);
      var nextState = await onStateChangeCompleter.future;
      expect(nextState.count, 4);
    });
  });
}
