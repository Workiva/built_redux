import 'package:built_value/built_value.dart';

import 'action.dart';
import 'middleware.dart';

/// [Reducer] is a function that given a state of type V, an Action of type Action<P>, and a
/// builder of type B builds the next state
typedef void Reducer<P, V extends Built<V, B>, B extends Builder<V, B>>(
    V state, Action<P> action, B builder);

/// [ActionHandler] handles an action, this will contain the actual middleware logic
typedef ActionHandler(Action a);

/// [NextActionHandler] takes the next [ActionHandler] in the middlware chain and returns
/// an [ActionHandler] for the middleware
typedef ActionHandler NextActionHandler(ActionHandler next);

/// [Middleware] is a function that given the store's [MiddlewareApi] returns a [NextActionHandler].
typedef NextActionHandler Middleware<State>(MiddlewareApi api);
