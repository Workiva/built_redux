import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'action.dart';
import 'typedefs.dart';

/// [ReducerBuilder] allows you to build a reducer that handles many different actions
/// with many different payload types, while maintaining type safety.
/// Each [Reducer] added with add<T> must take a state of type State, an Action of type
/// Action<T>, and a builder of type B.
/// Nested reducers can be added with [combineNested]
class ReducerBuilder<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>> {
  final _map = Map<String, Reducer<State, StateBuilder, dynamic>>();

  ReducerBuilder();

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(ActionName<Payload> actionName,
      Reducer<State, StateBuilder, Payload> reducer) {
    _map[actionName.name] = (state, action, builder) {
      reducer(state, action as Action<Payload>, builder);
    };
  }

  /// [combine] combines this ReducerBuilder with another ReducerBuilder
  /// for the same type
  void combine(ReducerBuilder<State, StateBuilder> other) {
    _map.addAll(other._map);
  }

  /// [combineNested] combines this ReducerBuilder with a NestedReducerBuilder
  @pragma('dart2js:noInline')
  void combineNested<N extends Built<N, NB>, NB extends Builder<N, NB>>(
      NestedReducerBuilder<State, StateBuilder, N, NB> nested) {
    _map.addAll(nested._map);
  }

  /// [combineAbstract] combines this ReducerBuilder with an AbstractReducerBuilder.
  /// This function takes the result of AbstractReducerBuilder's .build() function,
  /// which is a map. It does not take an AbstractReducerBuilder directly.
  void combineAbstract(
      Map<String, Reducer<State, StateBuilder, dynamic>> other) {
    _map.addAll(other);
  }

  /// [combineList] combines this ReducerBuilder with a ListReducerBuilder
  void combineList<T>(ListReducerBuilder<State, StateBuilder, T> other) {
    _map.addAll(other._map);
  }

  /// [combineListMultimap] combines this ReducerBuilder with a ListMultimapReducerBuilder
  void combineListMultimap<K, V>(
      ListMultimapReducerBuilder<State, StateBuilder, K, V> other) {
    _map.addAll(other._map);
  }

  /// [combineMap] combines this ReducerBuilder with a MapReducerBuilder
  void combineMap<K, V>(MapReducerBuilder<State, StateBuilder, K, V> other) {
    _map.addAll(other._map);
  }

  /// [combineSet] combines this ReducerBuilder with a SetReducerBuilder
  void combineSet<T>(SetReducerBuilder<State, StateBuilder, T> other) {
    _map.addAll(other._map);
  }

  /// [combineSetMultimap] combines this ReducerBuilder with a SetMultimapReducerBuilder
  void combineSetMultimap<K, V>(
      SetMultimapReducerBuilder<State, StateBuilder, K, V> other) {
    _map.addAll(other._map);
  }

  /// [build] returns a reducer function that can be passed to a [Store].
  Reducer<State, StateBuilder, dynamic> build() =>
      (State state, Action<dynamic> action, StateBuilder builder) {
        final reducer = _map[action.name];
        if (reducer != null) reducer(state, action, builder);
      };
}

/// [Mapper] is a function that takes an object and maps it to another object.
/// Used for state and builder mappers passed to [NestedReducerBuilder].
typedef Mapper<State, NestedState> = NestedState Function(State state);

/// [NestedReducerBuilder] allows you to build a reducer that rebuilds built values
/// nested within your main app state model. For example, consider the following built value
///
/// ```dart
/// abstract class BaseState implements Built<BaseState, BaseStateBuilder> {
///
///  NestedBuiltValue get nestedBuiltValue;
///
///  // Built value constructor
///  BaseState._();
///  factory BaseState() => new _$BaseState._(
///        count: 1,
///        nestedBuiltValue: new NestedBuiltValue(),
///      );
/// }
/// ```
/// A NestedReducerBuilder can be used to map certain actions to reducer
/// functions that only rebuild nestedBuiltValue
///
/// Two mapper functions are required by the constructor to map the state and state builder objects
/// to the nested value and nested builder.
///
/// [_stateMapper] maps the state built to the nested built, in this case:
/// ```dart
///   (BaseCounter state) => state.nestedBuiltValue
/// ```
///
/// [_builderMapper] maps the state builder to the nested builder, in this case:
/// ```dart
///   (BaseCounterBuilder stateBuilder) => stateBuilder.nestedBuiltValue
/// ```
///
class NestedReducerBuilder<
    State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>,
    NestedState extends Built<NestedState, NestedStateBuilder>,
    NestedStateBuilder extends Builder<NestedState, NestedStateBuilder>> {
  final _map = Map<String, Reducer<State, StateBuilder, dynamic>>();
  Mapper<State, NestedState> _stateMapper;
  Mapper<StateBuilder, NestedStateBuilder> _builderMapper;

  NestedReducerBuilder(this._stateMapper, this._builderMapper);

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(ActionName<Payload> actionName,
      Reducer<NestedState, NestedStateBuilder, Payload> reducer) {
    _map[actionName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action as Action<Payload>,
          _builderMapper(builder),
        );
  }

  /// [combineReducerBuilder] takes a `ReducerBuilder` with the type arguments
  /// `NestedState`, `NestedStateBuilder`, and combines it with this `NestedReducerBuilder`.
  void combineReducerBuilder(
      ReducerBuilder<NestedState, NestedStateBuilder> other) {
    final adapted = other._map.map((name, reducer) => MapEntry(
        name,
        (State state, Action<dynamic> action, StateBuilder builder) => reducer(
              _stateMapper(state),
              action,
              _builderMapper(builder),
            )));
    _map.addAll(adapted);
  }
}

/// [AbstractReducerBuilder] returns a reducer builder that
/// rebuilds an abstract, or mixed in, piece of state. For most cases
/// AbstractReducerBuilder is not recommended. When defining your state
/// model favor composition over inheritance. However, this may be
/// useful when trying to share functionaity between two separate redux stores.
class AbstractReducerBuilder<AState, AStateBuilder> {
  final _map = Map<String, CReducer<AState, AStateBuilder, dynamic>>();

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(ActionName<Payload> actionName,
      CReducer<AState, AStateBuilder, Payload> reducer) {
    _map[actionName.name] = (state, action, builder) {
      reducer(state, action as Action<Payload>, builder);
    };
  }

  Map<String, CReducer<AState, AStateBuilder, dynamic>> build() => _map;
}

/// This is the Reducer typedef without the Built/Builder constraints
/// Used for built_collections since they do not implement Built/Builder
/// but follow the same pattern.
typedef CReducer<AState, AStateBuilder, P> = void Function(
    AState state, Action<P> action, AStateBuilder builder);

/// [ListReducerBuilder] returns a reducer builder that
/// rebuilds a List nested within the state tree
class ListReducerBuilder<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, T> {
  final _map = Map<String, Reducer<State, StateBuilder, dynamic>>();
  Mapper<State, BuiltList<T>> _stateMapper;
  Mapper<StateBuilder, ListBuilder<T>> _builderMapper;

  ListReducerBuilder(this._stateMapper, this._builderMapper);

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(ActionName<Payload> actionName,
      CReducer<BuiltList<T>, ListBuilder<T>, Payload> reducer) {
    _map[actionName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action as Action<Payload>,
          _builderMapper(builder),
        );
  }
}

/// [ListMultimapReducerBuilder] returns a reducer builder that
/// rebuilds a ListMultimap nested within the state tree
class ListMultimapReducerBuilder<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, K, V> {
  final _map = Map<String, Reducer<State, StateBuilder, dynamic>>();
  Mapper<State, BuiltListMultimap<K, V>> _stateMapper;
  Mapper<StateBuilder, ListMultimapBuilder<K, V>> _builderMapper;

  ListMultimapReducerBuilder(this._stateMapper, this._builderMapper);

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(
      ActionName<Payload> actionName,
      CReducer<BuiltListMultimap<K, V>, ListMultimapBuilder<K, V>, Payload>
          reducer) {
    _map[actionName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action as Action<Payload>,
          _builderMapper(builder),
        );
  }
}

/// [MapReducerBuilder] returns a reducer builder that
/// rebuilds a Map nested within the state tree
class MapReducerBuilder<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, K, V> {
  final _map = Map<String, Reducer<State, StateBuilder, dynamic>>();
  Mapper<State, BuiltMap<K, V>> _stateMapper;
  Mapper<StateBuilder, MapBuilder<K, V>> _builderMapper;

  MapReducerBuilder(this._stateMapper, this._builderMapper);

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(ActionName<Payload> actionName,
      CReducer<BuiltMap<K, V>, MapBuilder<K, V>, Payload> reducer) {
    _map[actionName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action as Action<Payload>,
          _builderMapper(builder),
        );
  }
}

/// [SetReducerBuilder] returns a reducer builder that
/// rebuilds a Set nested within the state tree
class SetReducerBuilder<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, T> {
  final _map = Map<String, Reducer<State, StateBuilder, dynamic>>();
  Mapper<State, BuiltSet<T>> _stateMapper;
  Mapper<StateBuilder, SetBuilder<T>> _builderMapper;

  SetReducerBuilder(this._stateMapper, this._builderMapper);

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(ActionName<Payload> actionName,
      CReducer<BuiltSet<T>, SetBuilder<T>, Payload> reducer) {
    _map[actionName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action as Action<Payload>,
          _builderMapper(builder),
        );
  }
}

/// [SetMultimapReducerBuilder] returns a reducer builder that
/// rebuilds a SetMultimap nested within the state tree
class SetMultimapReducerBuilder<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, K, V> {
  final _map = Map<String, Reducer<State, StateBuilder, dynamic>>();
  Mapper<State, BuiltSetMultimap<K, V>> _stateMapper;
  Mapper<StateBuilder, SetMultimapBuilder<K, V>> _builderMapper;

  SetMultimapReducerBuilder(this._stateMapper, this._builderMapper);

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(
      ActionName<Payload> actionName,
      CReducer<BuiltSetMultimap<K, V>, SetMultimapBuilder<K, V>, Payload>
          reducer) {
    _map[actionName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action as Action<Payload>,
          _builderMapper(builder),
        );
  }
}
