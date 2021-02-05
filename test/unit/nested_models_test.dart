import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'nested_models.dart';

void main() {
  group('nested builts and actions', () {
    late Store<Base, BaseBuilder, BaseActions> store;

    setUp(() {
      store = Store<Base, BaseBuilder, BaseActions>(
        getBaseReducer(),
        Base(),
        BaseActions(),
      );
    });

    tearDown(() {
      store.dispose();
    });

    test('all nesting levels', () {
      expect(store.state.count, 0);
      expect(store.state.child.count, 0);
      expect(store.state.child.grandchild.count, 0);
      store.actions.baseAction(null);
      expect(store.state.count, 1);
      expect(store.state.child.count, 0);
      expect(store.state.child.grandchild.count, 0);
      store.actions.child.childAction(null);
      expect(store.state.count, 1);
      expect(store.state.child.count, 1);
      expect(store.state.child.grandchild.count, 0);
      store.actions.child.grandchild.grandchildAction(null);
      expect(store.state.count, 1);
      expect(store.state.child.count, 1);
      expect(store.state.child.grandchild.count, 1);
    });
  });
}
