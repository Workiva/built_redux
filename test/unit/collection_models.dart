library collection_models;

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'collection_models.g.dart';
part 'collection_models.built_redux.g.dart';

// CollectionActions contains actions that mutate the different
// built collections contained inside Collection
abstract class CollectionActions extends ReduxActions {
  CollectionActions._();
  factory CollectionActions() => new _$CollectionActions();

  ActionDispatcher<Null> get builtListAction;
  ActionDispatcher<Null> get builtListMultimapAction;
  ActionDispatcher<Null> get builtMapAction;
  ActionDispatcher<Null> get builtSetAction;
  ActionDispatcher<Null> get builtSetMultimapAction;
}

// Collection contains one of each built_collection type
abstract class Collection implements Built<Collection, CollectionBuilder> {
  BuiltList<int> get builtList;
  BuiltListMultimap<int, int> get builtListMultimap;
  BuiltMap<int, int> get builtMap;
  BuiltSet<int> get builtSet;
  BuiltSetMultimap<int, int> get builtSetMultimap;

  Collection._();
  factory Collection() => new _$Collection();
}

// getCollectionReducer returns a Reducer that rebuilds Collection.
// It combines the child and grandchild ReducerBuilders.
// This ReducerBuilder could be modified to handle more
// actions that could rebuild any peice of state within the Collection object.
// Reducers added to the ReducerBuilder must have the signature:
// (Collection, Action<T>, CollectionBuilder)
Reducer<Collection, CollectionBuilder, dynamic> getCollectionReducer() =>
    (new ReducerBuilder<Collection, CollectionBuilder>()
          ..combineList(getListReducer())
          ..combineListMultimap(getListMultimapReducer())
          ..combineMap(getMapReducer())
          ..combineSet(getSetReducer())
          ..combineSetMultimap(getSetMultimapReducer()))
        .build();

// getListReducer returns a ListReducerBuilder that rebuilds the list
// when builtListAction is dispatched. This ListReducerBuilder
// could be modified to handle more actions that rebuild builtList.
// Reducers added to the ListReducerBuilder must have the signature:
// (BuiltList<int>, Action<T>, ListBuilder<int>)
ListReducerBuilder<Collection, CollectionBuilder, int> getListReducer() =>
    new ListReducerBuilder<Collection, CollectionBuilder, int>(
        (s) => s.builtList, (b) => b.builtList)
      ..add<Null>(
          CollectionActionsNames.builtListAction, (s, a, b) => b.add(0));

// getListMultimapReducer returns a ListMultimapReducerBuilder that rebuilds the list multimap
// when builtListMultimapAction is dispatched. This ListMultimapReducerBuilder
// could be modified to handle more actions that rebuild builtListMultimap.
// Reducers added to the ListMultimapReducerBuilder must have the signature:
// (BuiltListMultimap<int, int>, Action<T>, ListMultimapBuilder<int, int>)
ListMultimapReducerBuilder<Collection, CollectionBuilder, int, int>
    getListMultimapReducer() =>
        new ListMultimapReducerBuilder<Collection, CollectionBuilder, int, int>(
            (s) => s.builtListMultimap, (b) => b.builtListMultimap)
          ..add<Null>(CollectionActionsNames.builtListMultimapAction,
              (s, a, b) => b.add(0, 0));

// getMapReducer returns a MapReducerBuilder that rebuilds the map
// when builtMapAction is dispatched. This MapReducerBuilder
// could be modified to handle more actions that rebuild builtMap.
// Reducers added to the MapReducerBuilder must have the signature:
// (BuiltMap<int, int>, Action<T>, MapBuilder<int, int>)
MapReducerBuilder<Collection, CollectionBuilder, int, int> getMapReducer() =>
    new MapReducerBuilder<Collection, CollectionBuilder, int, int>(
        (s) => s.builtMap, (b) => b.builtMap)
      ..add<Null>(CollectionActionsNames.builtMapAction, (s, a, b) => b[0] = 0);

// getSetReducer returns a SetReducerBuilder that rebuilds the set
// when builtSetAction is dispatched. This SetReducerBuilder
// could be modified to handle more actions that rebuild builtSet.
// Reducers added to the SetReducerBuilder must have the signature:
// (Set<int>, Action<T>, SetBuilder<int>)
SetReducerBuilder<Collection, CollectionBuilder, int> getSetReducer() =>
    new SetReducerBuilder<Collection, CollectionBuilder, int>(
        (s) => s.builtSet, (b) => b.builtSet)
      ..add<Null>(CollectionActionsNames.builtSetAction, (s, a, b) => b.add(0));

// getSetMultimapReducer returns a SetMultimapReducerBuilder that rebuilds the set multimap
// when builtSetMultimapAction is dispatched. This SetMultimapReducerBuilder
// could be modified to handle more actions that rebuild builtSetMultimap.
// Reducers added to the SetMultimapReducerBuilder must have the signature:
// (BuiltSetMultimap<int, int>, Action<T>, SetMultimapBuilder<int, int>)
SetMultimapReducerBuilder<Collection, CollectionBuilder, int, int>
    getSetMultimapReducer() =>
        new SetMultimapReducerBuilder<Collection, CollectionBuilder, int, int>(
            (s) => s.builtSetMultimap, (b) => b.builtSetMultimap)
          ..add<Null>(CollectionActionsNames.builtSetMultimapAction,
              (s, a, b) => b.add(0, 0));
