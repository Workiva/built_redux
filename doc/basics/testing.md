# Testing

## Reducers

Just dispatch an action, verify the state before and after.
The following tests test the reducer from the counter example, verifying the reducer increments on the increment action and decrements on the decrement action.

``` dart
void main() {
  group('example reducer test', () {
    Store<Counter, CounterBuilder, CounterActions> store;

    setUp(() {
      var actions = new CounterActions();
      var defaultValue = new Counter();
      store = new Store<Counter, CounterBuilder, CounterActions>(
          reducer, defaultValue, actions);
    });

    tearDown(() {
      store.dispose();
    });

    test('handles increment and decrement', () async {
      expect(store.state.count, 0);
      store.actions.increment(2);
      expect(store.state.count, 2);
      store.actions.decrement(1);
      expect(store.state.count, 1);
    });
  });
}
```

## Verifying actions are dispatched

Use ActionDispatcher's setDispatch to call an expectDispatched to verify a given action was called. For example, say I'm testing when a button is clicked my increment action is called. Under the hood, expectDispatched calls expectAsync1, so you don't have to worry about the test finishing before the expect is run.

``` dart

import 'package:built_redux/built_redux_test_utils.dart';

void main() {
  group('increment button', () {
    CounterActions actions;
    var uiButton;

    setUp(() {
      actions = new CounterActions();
      uiButton = renderButton(actions);
    });

    test('handles increment and decrement', () async {
      expectDispatched(actions.increment, verfier: (action) {
          expect(action.payload, 5);
      });

      uiButton.click();
    });
  });
}

```
