// GENERATED CODE - DO NOT MODIFY BY HAND

part of collection_models;

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
      (new CollectionBuilder()..update(updates))._build();

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
  CollectionBuilder toBuilder() => new CollectionBuilder()..replace(this);

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
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, builtList.hashCode), builtListMultimap.hashCode),
                builtMap.hashCode),
            builtSet.hashCode),
        builtSetMultimap.hashCode));
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
  ListBuilder<int> get builtList =>
      _$this._builtList ??= new ListBuilder<int>();
  set builtList(ListBuilder<int>? builtList) => _$this._builtList = builtList;

  ListMultimapBuilder<int, int>? _builtListMultimap;
  ListMultimapBuilder<int, int> get builtListMultimap =>
      _$this._builtListMultimap ??= new ListMultimapBuilder<int, int>();
  set builtListMultimap(ListMultimapBuilder<int, int>? builtListMultimap) =>
      _$this._builtListMultimap = builtListMultimap;

  MapBuilder<int, int>? _builtMap;
  MapBuilder<int, int> get builtMap =>
      _$this._builtMap ??= new MapBuilder<int, int>();
  set builtMap(MapBuilder<int, int>? builtMap) => _$this._builtMap = builtMap;

  SetBuilder<int>? _builtSet;
  SetBuilder<int> get builtSet => _$this._builtSet ??= new SetBuilder<int>();
  set builtSet(SetBuilder<int>? builtSet) => _$this._builtSet = builtSet;

  SetMultimapBuilder<int, int>? _builtSetMultimap;
  SetMultimapBuilder<int, int> get builtSetMultimap =>
      _$this._builtSetMultimap ??= new SetMultimapBuilder<int, int>();
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
          new _$Collection._(
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
        throw new BuiltValueNestedFieldError(
            r'Collection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
