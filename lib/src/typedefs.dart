import 'package:built_value/built_value.dart';

import 'action.dart';
import 'middleware.dart';

/// [Reducer] is a function that given a state of type V, an Action of type Action<P>, and a
/// builder of type B builds the next state
typedef Reducer<
  State extends Built<State, StateBuilder>,
  StateBuilder extends Builder<State, StateBuilder>,
  Payload
> = void Function(State state, Action<Payload> action, StateBuilder builder);

/// [ActionHandler] handles an action, this will contain the actual middleware logic
typedef ActionHandler = void Function(Action<dynamic> a);

/// [NextActionHandler] takes the next [ActionHandler] in the middleware chain and returns
/// an [ActionHandler] for the middleware
typedef NextActionHandler = ActionHandler Function(ActionHandler next);

/// [Middleware] is a function that given the store's [MiddlewareApi] returns a [NextActionHandler].
typedef Middleware<
  State extends Built<State, StateBuilder>,
  StateBuilder extends Builder<State, StateBuilder>,
  Actions extends ReduxActions
> = NextActionHandler Function(MiddlewareApi<State, StateBuilder, Actions> api);

/// [SubstateChange] is the payload for `StateChangeTransformer`'s stream. It contains
/// the previous and next value of the state resulting from the mapper provided to `StateChangeTransformer`
class SubstateChange<Substate> {
  Substate prev;
  Substate next;
  SubstateChange(this.prev, this.next);
}

/// [StateMapper] takes a state model and maps it to the values one cares about
typedef StateMapper<
  State extends Built<State, StateBuilder>,
  StateBuilder extends Builder<State, StateBuilder>,
  Substate
> = Substate Function(State state);
