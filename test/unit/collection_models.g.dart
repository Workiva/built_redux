// GENERATED CODE - DO NOT MODIFY BY HAND

part of collection_models;

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides

class _$CollectionActions extends CollectionActions {
  factory _$CollectionActions() => new _$CollectionActions._();
  _$CollectionActions._() : super._();

  final ActionDispatcher<Null> builtListAction =
      new ActionDispatcher<Null>('CollectionActions-builtListAction');
  final ActionDispatcher<Null> builtListMultimapAction =
      new ActionDispatcher<Null>('CollectionActions-builtListMultimapAction');
  final ActionDispatcher<Null> builtMapAction =
      new ActionDispatcher<Null>('CollectionActions-builtMapAction');
  final ActionDispatcher<Null> builtSetAction =
      new ActionDispatcher<Null>('CollectionActions-builtSetAction');
  final ActionDispatcher<Null> builtSetMultimapAction =
      new ActionDispatcher<Null>('CollectionActions-builtSetMultimapAction');

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
  static final ActionName<Null> builtListAction =
      new ActionName<Null>('CollectionActions-builtListAction');
  static final ActionName<Null> builtListMultimapAction =
      new ActionName<Null>('CollectionActions-builtListMultimapAction');
  static final ActionName<Null> builtMapAction =
      new ActionName<Null>('CollectionActions-builtMapAction');
  static final ActionName<Null> builtSetAction =
      new ActionName<Null>('CollectionActions-builtSetAction');
  static final ActionName<Null> builtSetMultimapAction =
      new ActionName<Null>('CollectionActions-builtSetMultimapAction');
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

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

  factory _$Collection([void updates(CollectionBuilder b)]) =>
      (new CollectionBuilder()..update(updates)).build();

  _$Collection._(
      {this.builtList,
      this.builtListMultimap,
      this.builtMap,
      this.builtSet,
      this.builtSetMultimap})
      : super._() {
    if (builtList == null)
      throw new BuiltValueNullFieldError('Collection', 'builtList');
    if (builtListMultimap == null)
      throw new BuiltValueNullFieldError('Collection', 'builtListMultimap');
    if (builtMap == null)
      throw new BuiltValueNullFieldError('Collection', 'builtMap');
    if (builtSet == null)
      throw new BuiltValueNullFieldError('Collection', 'builtSet');
    if (builtSetMultimap == null)
      throw new BuiltValueNullFieldError('Collection', 'builtSetMultimap');
  }

  @override
  Collection rebuild(void updates(CollectionBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionBuilder toBuilder() => new CollectionBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Collection) return false;
    return builtList == other.builtList &&
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
    return (newBuiltValueToStringHelper('Collection')
          ..add('builtList', builtList)
          ..add('builtListMultimap', builtListMultimap)
          ..add('builtMap', builtMap)
          ..add('builtSet', builtSet)
          ..add('builtSetMultimap', builtSetMultimap))
        .toString();
  }
}

class CollectionBuilder implements Builder<Collection, CollectionBuilder> {
  _$Collection _$v;

  ListBuilder<int> _builtList;
  ListBuilder<int> get builtList =>
      _$this._builtList ??= new ListBuilder<int>();
  set builtList(ListBuilder<int> builtList) => _$this._builtList = builtList;

  ListMultimapBuilder<int, int> _builtListMultimap;
  ListMultimapBuilder<int, int> get builtListMultimap =>
      _$this._builtListMultimap ??= new ListMultimapBuilder<int, int>();
  set builtListMultimap(ListMultimapBuilder<int, int> builtListMultimap) =>
      _$this._builtListMultimap = builtListMultimap;

  MapBuilder<int, int> _builtMap;
  MapBuilder<int, int> get builtMap =>
      _$this._builtMap ??= new MapBuilder<int, int>();
  set builtMap(MapBuilder<int, int> builtMap) => _$this._builtMap = builtMap;

  SetBuilder<int> _builtSet;
  SetBuilder<int> get builtSet => _$this._builtSet ??= new SetBuilder<int>();
  set builtSet(SetBuilder<int> builtSet) => _$this._builtSet = builtSet;

  SetMultimapBuilder<int, int> _builtSetMultimap;
  SetMultimapBuilder<int, int> get builtSetMultimap =>
      _$this._builtSetMultimap ??= new SetMultimapBuilder<int, int>();
  set builtSetMultimap(SetMultimapBuilder<int, int> builtSetMultimap) =>
      _$this._builtSetMultimap = builtSetMultimap;

  CollectionBuilder();

  CollectionBuilder get _$this {
    if (_$v != null) {
      _builtList = _$v.builtList?.toBuilder();
      _builtListMultimap = _$v.builtListMultimap?.toBuilder();
      _builtMap = _$v.builtMap?.toBuilder();
      _builtSet = _$v.builtSet?.toBuilder();
      _builtSetMultimap = _$v.builtSetMultimap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Collection other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Collection;
  }

  @override
  void update(void updates(CollectionBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Collection build() {
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
      String _$failedField;
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
            'Collection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
