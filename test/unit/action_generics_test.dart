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

    test('all generic types', () {
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
      store.actions.typdefAction((
        MiddlewareApi<ActionGenerics, ActionGenericsBuilder,
                ActionGenericsActions>
            api,
      ) {
        api.actions.intAction(4);
      });
      expect(store.state.count, 21);
    });
  });
}
