// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_models.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis

class _$CollectionActions extends CollectionActions {
  factory _$CollectionActions() => _$CollectionActions._();
  _$CollectionActions._() : super._();

  final builtListAction =
      ActionDispatcher<Null>('CollectionActions-builtListAction');
  final builtListMultimapAction =
      ActionDispatcher<Null>('CollectionActions-builtListMultimapAction');
  final builtMapAction =
      ActionDispatcher<Null>('CollectionActions-builtMapAction');
  final builtSetAction =
      ActionDispatcher<Null>('CollectionActions-builtSetAction');
  final builtSetMultimapAction =
      ActionDispatcher<Null>('CollectionActions-builtSetMultimapAction');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    builtListAction.setDispatcher(dispatcher);
    builtListMultimapAction.setDispatcher(dispatcher);
    builtMapAction.setDispatcher(dispatcher);
    builtSetAction.setDispatcher(dispatcher);
    builtSetMultimapAction.setDispatcher(dispatcher);
  }
}

class CollectionActionsNames {
  static final builtListAction =
      ActionName<Null>('CollectionActions-builtListAction');
  static final builtListMultimapAction =
      ActionName<Null>('CollectionActions-builtListMultimapAction');
  static final builtMapAction =
      ActionName<Null>('CollectionActions-builtMapAction');
  static final builtSetAction =
      ActionName<Null>('CollectionActions-builtSetAction');
  static final builtSetMultimapAction =
      ActionName<Null>('CollectionActions-builtSetMultimapAction');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Collection extends Collection {
  @override
  final BuiltList<int> builtList;
  @override
  final BuiltListMultimap<int, int> builtListMultimap;
  @override
  final BuiltMap<int, int> builtMap;
  @override
  final BuiltSet<int> builtSet;
  @override
  final BuiltSetMultimap<int, int> builtSetMultimap;

  factory _$Collection([void Function(CollectionBuilder)? updates]) =>
      (CollectionBuilder()..update(updates))._build();

  _$Collection._(
      {required this.builtList,
      required this.builtListMultimap,
      required this.builtMap,
      required this.builtSet,
      required this.builtSetMultimap})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        builtList, r'Collection', 'builtList');
    BuiltValueNullFieldError.checkNotNull(
        builtListMultimap, r'Collection', 'builtListMultimap');
    BuiltValueNullFieldError.checkNotNull(builtMap, r'Collection', 'builtMap');
    BuiltValueNullFieldError.checkNotNull(builtSet, r'Collection', 'builtSet');
    BuiltValueNullFieldError.checkNotNull(
        builtSetMultimap, r'Collection', 'builtSetMultimap');
  }

  @override
  Collection rebuild(void Function(CollectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionBuilder toBuilder() => CollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Collection &&
        builtList == other.builtList &&
        builtListMultimap == other.builtListMultimap &&
        builtMap == other.builtMap &&
        builtSet == other.builtSet &&
        builtSetMultimap == other.builtSetMultimap;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, builtList.hashCode);
    _$hash = $jc(_$hash, builtListMultimap.hashCode);
    _$hash = $jc(_$hash, builtMap.hashCode);
    _$hash = $jc(_$hash, builtSet.hashCode);
    _$hash = $jc(_$hash, builtSetMultimap.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Collection')
          ..add('builtList', builtList)
          ..add('builtListMultimap', builtListMultimap)
          ..add('builtMap', builtMap)
          ..add('builtSet', builtSet)
          ..add('builtSetMultimap', builtSetMultimap))
        .toString();
  }
}

class CollectionBuilder implements Builder<Collection, CollectionBuilder> {
  _$Collection? _$v;

  ListBuilder<int>? _builtList;
  ListBuilder<int> get builtList => _$this._builtList ??= ListBuilder<int>();
  set builtList(ListBuilder<int>? builtList) => _$this._builtList = builtList;

  ListMultimapBuilder<int, int>? _builtListMultimap;
  ListMultimapBuilder<int, int> get builtListMultimap =>
      _$this._builtListMultimap ??= ListMultimapBuilder<int, int>();
  set builtListMultimap(ListMultimapBuilder<int, int>? builtListMultimap) =>
      _$this._builtListMultimap = builtListMultimap;

  MapBuilder<int, int>? _builtMap;
  MapBuilder<int, int> get builtMap =>
      _$this._builtMap ??= MapBuilder<int, int>();
  set builtMap(MapBuilder<int, int>? builtMap) => _$this._builtMap = builtMap;

  SetBuilder<int>? _builtSet;
  SetBuilder<int> get builtSet => _$this._builtSet ??= SetBuilder<int>();
  set builtSet(SetBuilder<int>? builtSet) => _$this._builtSet = builtSet;

  SetMultimapBuilder<int, int>? _builtSetMultimap;
  SetMultimapBuilder<int, int> get builtSetMultimap =>
      _$this._builtSetMultimap ??= SetMultimapBuilder<int, int>();
  set builtSetMultimap(SetMultimapBuilder<int, int>? builtSetMultimap) =>
      _$this._builtSetMultimap = builtSetMultimap;

  CollectionBuilder();

  CollectionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _builtList = $v.builtList.toBuilder();
      _builtListMultimap = $v.builtListMultimap.toBuilder();
      _builtMap = $v.builtMap.toBuilder();
      _builtSet = $v.builtSet.toBuilder();
      _builtSetMultimap = $v.builtSetMultimap.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Collection other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Collection;
  }

  @override
  void update(void Function(CollectionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Collection build() => _build();

  _$Collection _build() {
    _$Collection _$result;
    try {
      _$result = _$v ??
          _$Collection._(
              builtList: builtList.build(),
              builtListMultimap: builtListMultimap.build(),
              builtMap: builtMap.build(),
              builtSet: builtSet.build(),
              builtSetMultimap: builtSetMultimap.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'builtList';
        builtList.build();
        _$failedField = 'builtListMultimap';
        builtListMultimap.build();
        _$failedField = 'builtMap';
        builtMap.build();
        _$failedField = 'builtSet';
        builtSet.build();
        _$failedField = 'builtSetMultimap';
        builtSetMultimap.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Collection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
