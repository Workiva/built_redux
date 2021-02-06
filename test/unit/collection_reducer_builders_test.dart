import 'package:built_redux/built_redux.dart';
import 'package:test/test.dart';

import 'collection_models.dart';

void main() {
  group('collection reducer builders', () {
    late Store<Collection, CollectionBuilder, CollectionActions> store;

    setUp(() {
      store = Store<Collection, CollectionBuilder, CollectionActions>(
        getCollectionReducer(),
        Collection(),
        CollectionActions(),
      );
    });

    tearDown(() {
      store.dispose();
    });

    test('all collections', () {
      expect(store.state.builtList.length, 0);
      expect(store.state.builtListMultimap.keys.length, 0);
      expect(store.state.builtMap.keys.length, 0);
      expect(store.state.builtSet.length, 0);
      expect(store.state.builtSetMultimap.keys.length, 0);

      store.actions.builtListAction(null);
      expect(store.state.builtList.length, 1);
      expect(store.state.builtListMultimap.keys.length, 0);
      expect(store.state.builtMap.keys.length, 0);
      expect(store.state.builtSet.length, 0);
      expect(store.state.builtSetMultimap.keys.length, 0);

      store.actions.builtListMultimapAction(null);
      expect(store.state.builtList.length, 1);
      expect(store.state.builtListMultimap.keys.length, 1);
      expect(store.state.builtMap.keys.length, 0);
      expect(store.state.builtSet.length, 0);
      expect(store.state.builtSetMultimap.keys.length, 0);

      store.actions.builtMapAction(null);
      expect(store.state.builtList.length, 1);
      expect(store.state.builtListMultimap.keys.length, 1);
      expect(store.state.builtMap.keys.length, 1);
      expect(store.state.builtSet.length, 0);
      expect(store.state.builtSetMultimap.keys.length, 0);

      store.actions.builtSetAction(null);
      expect(store.state.builtList.length, 1);
      expect(store.state.builtListMultimap.keys.length, 1);
      expect(store.state.builtMap.keys.length, 1);
      expect(store.state.builtSet.length, 1);
      expect(store.state.builtSetMultimap.keys.length, 0);

      store.actions.builtSetMultimapAction(null);
      expect(store.state.builtList.length, 1);
      expect(store.state.builtListMultimap.keys.length, 1);
      expect(store.state.builtMap.keys.length, 1);
      expect(store.state.builtSet.length, 1);
      expect(store.state.builtSetMultimap.keys.length, 1);
    });
  });
}
