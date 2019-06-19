import 'package:built_redux/built_redux_test_utils.dart';
import 'package:test/test.dart';

import 'test_counter.dart';

void main() {
  group('expectDispatch', () {
    CounterActions actions;

    setUp(() {
      actions = new CounterActions();
    });

    test('expectDispatch no verifier', () {
      expectDispatched(actions.increment);
      actions.increment(1);
    });

    test('expectDispatch verifier', () {
      expectDispatched<int>(actions.increment, verifier: (action) {
        expect(action.payload, 1);
      });

      actions.increment(1);
    });

    test('expectDispatch verifier count 2', () {
      expectDispatched<int>(actions.increment, count: 2, verifier: (action) {
        expect(action.payload, 1);
      });

      actions.increment(1);
      actions.increment(1);
    });
  });
}
