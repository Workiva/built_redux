import 'dart:async';
import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'action_generics_models.dart';

void main() {
  group('action generics', () {
    Store<ActionGenerics, ActionGenericsBuilder, ActionGenericsActions> store;

    setUp(() {
      store = new Store<ActionGenerics, ActionGenericsBuilder,
          ActionGenericsActions>(
        getActionGenericsReducer(),
        new ActionGenerics(),
        new ActionGenericsActions(),
        middleware: [thunkMiddleware],
      );
    });

    tearDown(() {
      store.dispose();
    });

    test('all generic types', () async {
      expect(store.state.count, 0);
      store.actions.intAction(3);
      expect(store.state.count, 3);
      store.actions.nullAction();
      expect(store.state.count, 4);
      store.actions.nullAction(null);
      expect(store.state.count, 5);
      store.actions.listIntAction([1, 2, 3]);
      expect(store.state.count, 11);
      store.actions.mapStringToListIntAction({
        'k': [1, 2, 3],
      });
      expect(store.state.count, 17);
      store.actions.typdefAction(testThunk);
      expect(store.state.count, 21);
      store.actions.typdefAction(testThunkAsync);
      await new Future<void>.delayed(const Duration(microseconds: 0));
      expect(store.state.count, 29);
    });
  });
}

void testThunk(
    MiddlewareApi<ActionGenerics, ActionGenericsBuilder, ActionGenericsActions>
        api) {
  api.actions.intAction(4);
}

Future<void> testThunkAsync(
    MiddlewareApi<ActionGenerics, ActionGenericsBuilder, ActionGenericsActions>
        api) async {
  api.actions.intAction(8);
}
