import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'inheritance_test_models.dart';

void main() {
  group('inheritence', () {
    Store<Child, ChildBuilder, ChildActions> store;

    setUp(() {
      store = Store<Child, ChildBuilder, ChildActions>(
          getInheritanceReducer(), Child(), ChildActions());
    });

    tearDown(() {
      store.dispose();
    });

    test('update each interface', () async {
      expect(store.state.childCount, 0);
      expect(store.state.parentCount, 0);
      expect(store.state.grandparentCount, 0);
      store.actions.childAction();
      expect(store.state.childCount, 1);
      expect(store.state.parentCount, 0);
      expect(store.state.grandparentCount, 0);
      store.actions.parentAction();
      expect(store.state.childCount, 1);
      expect(store.state.parentCount, 2);
      expect(store.state.grandparentCount, 0);
      store.actions.grandparentAction();
      expect(store.state.childCount, 1);
      expect(store.state.parentCount, 2);
      expect(store.state.grandparentCount, 3);
    });
  });
}
