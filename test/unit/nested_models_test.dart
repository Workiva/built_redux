import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'nested_models.dart';

main() {
  group('nested builts and actions', () {
    Store<Base, BaseBuilder, BaseActions> store;

    setUp(() {
      store = new Store(
        getBaseReducer(),
        new Base(),
        new BaseActions(),
      );
    });

    tearDown(() {
      store.dispose();
    });

    test('all nesting levels', () {
      expect(store.state.count, 0);
      expect(store.state.child.count, 0);
      expect(store.state.child.grandchild.count, 0);
      store.actions.baseAction();
      expect(store.state.count, 1);
      expect(store.state.child.count, 0);
      expect(store.state.child.grandchild.count, 0);
      store.actions.child.childAction();
      expect(store.state.count, 1);
      expect(store.state.child.count, 1);
      expect(store.state.child.grandchild.count, 0);
      store.actions.child.grandchild.grandchildAction();
      expect(store.state.count, 1);
      expect(store.state.child.count, 1);
      expect(store.state.child.grandchild.count, 1);
    });
  });
}
