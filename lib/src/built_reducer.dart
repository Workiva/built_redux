import 'package:built_value/built_value.dart';
import 'action.dart';
import 'typedefs.dart';

typedef NestedState Mapper<State, NestedState>(State state);

class NestedReducerBuilder<
    State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>,
    NestedState,
    NestedStateBuilder> {
  var _map = new Map<String, Reducer<State, StateBuilder, dynamic>>();

  Mapper<State, NestedState> _stateMapper;
  Mapper<StateBuilder, NestedStateBuilder> _builderMapper;

  NestedReducerBuilder(this._stateMapper, this._builderMapper);

  void add<Payload>(ActionName<Payload> aName,
      Reducer<NestedState, NestedStateBuilder, Payload> reducer) {
    _map[aName.name] = (state, action, builder) => reducer(
          _stateMapper(state),
          action,
          _builderMapper(builder),
        );
  }
}

/// [ReducerBuilder] allows you to build a reducer that handles many different actions
/// with many different payload types, while maintaining type safety.
/// Each [Reducer] added with add<T> must take a state of type State, an Action of type
/// Action<T>, and a builder of type B
class ReducerBuilder<V extends Built<V, B>, B extends Builder<V, B>> {
  var _map = new Map<String, Reducer<V, B, dynamic>>();

  ReducerBuilder();

  void add<Payload>(ActionName<Payload> aName, Reducer<V, B, Payload> reducer) {
    _map[aName.name] = reducer;
  }

  void addNestedReducer(NestedReducerBuilder<V, B, dynamic, dynamic> nested) {
    _map.addAll(nested._map);
  }

  Reducer<V, B, dynamic> build() =>
      (V state, Action<dynamic> action, B builder) {
        final reducer = _map[action.name];
        if (reducer != null) reducer(state, action, builder);
      };
}
