import 'package:built_value/built_value.dart';
import 'action.dart';
import 'typedefs.dart';

/// [ReducerBuilder] allows you to build a reducer that handles many different actions
/// with many different payload types, while maintaining type safety.
/// Each [Reducer] added with add<T> must take a state of type State, an Action of type
/// Action<T>, and a builder of type B.
/// Nested reducers can be added with [addNestedReducer]
class ReducerBuilder<V extends Built<V, B>, B extends Builder<V, B>> {
  var _map = new Map<String, Reducer<V, B, dynamic>>();

  ReducerBuilder();

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(
      ActionName<Payload> actionName, Reducer<V, B, Payload> reducer) {
    _map[actionName.name] = reducer;
  }

  /// [combineReducer] combines this ReducerBuilder with another ReducerBuilder
  /// for the same type
  void combineReducer(ReducerBuilder<V, B> other) {
    _map.addAll(other._map);
  }

  /// [addNestedReducer] combines this ReducerBuilder with a NestedReducerBuilder
  /// for the same base state
  void addNestedReducer<N extends Built<N, NB>, NB extends Builder<N, NB>>(
      NestedReducerBuilder<V, B, N, NB> nested) {
    _map.addAll(nested._map);
  }

  /// [build] returns a reducer function that can be passed to a [Store].
  Reducer<V, B, dynamic> build() =>
      (V state, Action<dynamic> action, B builder) {
        final reducer = _map[action.name];
        if (reducer != null) reducer(state, action, builder);
      };
}

/// [Mapper] is a function that takes an object and maps it to another object.
/// Used for state and builder mappers passed to [NestedReducerBuilder].
typedef NestedState Mapper<State, NestedState>(State state);

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
  var _map = new Map<String, Reducer<State, StateBuilder, dynamic>>();

  Mapper<State, NestedState> _stateMapper;
  Mapper<StateBuilder, NestedStateBuilder> _builderMapper;

  NestedReducerBuilder(this._stateMapper, this._builderMapper);

  /// Registers [reducer] function to the given [actionName]
  void add<Payload>(ActionName<Payload> actionName,
      Reducer<NestedState, NestedStateBuilder, Payload> reducer) {
    _map[actionName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action,
          _builderMapper(builder),
        );
  }
}
