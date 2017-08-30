import 'package:built_value/built_value.dart';
import 'action.dart';
import 'typedefs.dart';

/// [BuiltReducer] can be extended by a built value to give the model a reducer function
abstract class BuiltReducer<State extends Built<State, StateBuilder>,
        StateBuilder extends Builder<State, StateBuilder>>
    implements Built<State, StateBuilder> {
    
  /// [reduce] describes how an action transforms the state into the next state by applying changes to the builder supplied.
  /// You are required to builder passed, calling state.rebuild will NOT update the state in your redux store.
  void reduce(State state, Action<dynamic> a, StateBuilder builder);
}

/// [ReducerBuilder] allows you to build a reducer that handles many different actions
/// with many different payload types, while maintaining type safety.
/// Each [Reducer] added with add<T> must take a state of type State, an Action of type
/// Action<T>, and a builder of type B
class ReducerBuilder<State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>> {
  var _map = new Map<String, Reducer<dynamic, State, StateBuilder>>();

  void add<Payload>(ActionName<Payload> aName,
      Reducer<Payload, State, StateBuilder> reducer) {
    _map[aName.name] = reducer;
  }

  Map<String, Reducer<dynamic, State, StateBuilder>> build() => _map;
}
