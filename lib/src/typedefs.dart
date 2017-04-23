import 'package:built_value/built_value.dart';

import 'action.dart';
import 'built_reducer.dart';
import 'middleware.dart';

/// [Reducer] is a function that given a state of type V, an Action of type Action<P>, and a
/// builder of type B builds the next state
typedef void Reducer<
    Payload,
    State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State,
        StateBuilder>>(State state, Action<Payload> action, StateBuilder builder);

/// [ActionHandler] handles an action, this will contain the actual middleware logic
typedef ActionHandler(Action a);

/// [NextActionHandler] takes the next [ActionHandler] in the middlware chain and returns
/// an [ActionHandler] for the middleware
typedef ActionHandler NextActionHandler(ActionHandler next);

/// [Middleware] is a function that given the store's [MiddlewareApi] returns a [NextActionHandler].
typedef NextActionHandler Middleware<
    State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>,
    Actions extends ReduxActions>(MiddlewareApi<State, StateBuilder, Actions> api);
