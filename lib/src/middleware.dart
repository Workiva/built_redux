import 'package:built_value/built_value.dart';

import 'action.dart';
import 'store.dart';
import 'typedefs.dart';

/// [MiddlewareApi] put in scope to your [Middleware] function by redux.
/// When using [MiddlewareBuilder] (recommended) [MiddlewareApi] is passed to your [MiddlewareHandler]
class MiddlewareApi<
    State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>,
    Actions extends ReduxActions> {
  final State Function() _state;
  final Actions Function() _actions;

  MiddlewareApi._(this._state, this._actions);

  factory MiddlewareApi(Store<State, StateBuilder, Actions> _store) =>
      MiddlewareApi._(() => _store.state, () => _store.actions);

  /// [state] returns the current state
  State get state => _state();

  /// [actions] returns the actions synced with this redux store
  Actions get actions => _actions();
}

/// [MiddlewareBuilder] allows you to build a reducer that handles many different actions
/// with many different payload types, while maintaining type safety.
/// Each [MiddlewareHandler] added with add<T> must take a state of type State, an Action of type
/// Action<T>, and a builder of type StateBuilder
class MiddlewareBuilder<
    State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>,
    Actions extends ReduxActions> {
  var _map =
      Map<String, MiddlewareHandler<State, StateBuilder, Actions, dynamic>>();

  void add<Payload>(ActionName<Payload> aMgr,
      MiddlewareHandler<State, StateBuilder, Actions, Payload> handler) {
    _add(aMgr.name, handler);
  }

  void _add<Payload>(String name,
      MiddlewareHandler<State, StateBuilder, Actions, Payload> handler) {
    final oldMiddlware = _map[name];
    _map[name] = (api, next, action) {
      if (oldMiddlware != null) oldMiddlware(api, next, action);
      handler(api, next, action as Action<Payload>);
    };
  }

  /// [combine] combines this MiddlewareBuilder with another MiddlewareBuilder
  /// for the same type
  void combine(MiddlewareBuilder<State, StateBuilder, Actions> other) {
    for (final entry in other._map.entries) {
      _add<dynamic>(entry.key, entry.value);
    }
  }

  @pragma('dart2js:noInline')
  void combineNested<
          NestedState extends Built<NestedState, NestedStateBuilder>,
          NestedStateBuilder extends Builder<NestedState, NestedStateBuilder>,
          NestedActions extends ReduxActions>(
      NestedMiddlewareBuilder<State, StateBuilder, Actions, NestedState,
              NestedStateBuilder, NestedActions>
          other) {
    for (final entry in other._map.entries) {
      _add<dynamic>(entry.key, entry.value);
    }
  }

  /// [build] returns a [Middleware] function that handles all actions added with [add]
  Middleware<State, StateBuilder, Actions> build() =>
      (MiddlewareApi<State, StateBuilder, Actions> api) =>
          (ActionHandler next) => (Action<dynamic> action) {
                var handler = _map[action.name];
                if (handler != null) {
                  handler(api, next, action);
                  return;
                }

                next(action);
              };
}

class NestedMiddlewareBuilder<
    State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>,
    Actions extends ReduxActions,
    NestedState extends Built<NestedState, NestedStateBuilder>,
    NestedStateBuilder extends Builder<NestedState, NestedStateBuilder>,
    NestedActions extends ReduxActions> {
  final _map =
      Map<String, MiddlewareHandler<State, StateBuilder, Actions, dynamic>>();

  final NestedState Function(State) _stateMapper;
  final NestedActions Function(Actions) _actionsMapper;

  NestedMiddlewareBuilder(this._stateMapper, this._actionsMapper);

  void add<Payload>(
      ActionName<Payload> aMgr,
      MiddlewareHandler<NestedState, NestedStateBuilder, NestedActions, Payload>
          handler) {
    _add(aMgr.name, handler);
  }

  void _add<Payload>(
      String name,
      MiddlewareHandler<NestedState, NestedStateBuilder, NestedActions, Payload>
          handler) {
    final oldMiddlware = _map[name];
    _map[name] = (api, next, action) {
      if (oldMiddlware != null) oldMiddlware(api, next, action);
      handler(
        MiddlewareApi._(
            () => _stateMapper(api.state), () => _actionsMapper(api.actions)),
        next,
        action as Action<Payload>,
      );
    };
  }

  /// [combineMiddlewareBuilder] takes a `MiddlewareBuilder` with the type arguments
  /// `NestedState`, `NestedStateBuilder`, `NestedActions` and combines it with
  /// this `NestedMiddlewareBuilder`.
  void combineMiddlewareBuilder(
      MiddlewareBuilder<NestedState, NestedStateBuilder, NestedActions> other) {
    for (final entry in other._map.entries) {
      _add<dynamic>(entry.key, entry.value);
    }
  }
}

/// [MiddlewareHandler] is a function that handles an action in a middleware. Its is only for
/// use with [MiddlewareBuilder]. If you are not using [MiddlewareBuilder] middleware must be
/// declared as a [Middleware] function.
typedef MiddlewareHandler<
        State extends Built<State, StateBuilder>,
        StateBuilder extends Builder<State, StateBuilder>,
        Actions extends ReduxActions,
        Payload>
    = void Function(MiddlewareApi<State, StateBuilder, Actions> api,
        ActionHandler next, Action<Payload> action);
