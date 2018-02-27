import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

enum StreamAction { subscribe, unsubscribe }

class PayloadAction<P> {
  PayloadAction({@required this.action, this.payload}) : assert(action != null);

  final StreamAction action;

  final P payload;
}

/// To use this middleware, in your [ReduxActions] class, add an action with [StreamAction] as the [Action.payload] of
/// the action. Then you can call that action to subscribe or unsubscribe from the desired stream.
/// Example:
///
///  The following actions
///
///  ```dart
///  abstract class AppActions extends ReduxActions {
///     factory AppActions() => new _$AppActions();
///
///     AppActions._();
///
///     ActionDispatcher<ActionPayload<String>> get fooStream;
///  }
///  ```
///
/// Them in your lifecycle callback you can:
/// ```dart
/// store.actions.chatsSubscription(new ActionPayload<String>(action: StreamAction.subscribe, payload: 'Some Text'));
/// ```
///
/// or
///
/// ```dart
/// store.actions.chatsSubscription(new ActionPayload<Null>(action: StreamAction.unsubscribe));
/// ```
class MiddlewareStreamBuilder<State extends Built<State, StateBuilder>, StateBuilder extends Builder<State, StateBuilder>,
    Actions extends ReduxActions> {
  BuiltMap<String, StreamSubscription<dynamic>> _streams = new BuiltMap<String, StreamSubscription<dynamic>>();

  final Map<String, MiddlewareStreamHandler<State, StateBuilder, Actions, dynamic, dynamic>> _map =
      <String, MiddlewareStreamHandler<State, StateBuilder, Actions, dynamic, dynamic>>{};

  void add<Payload, StreamType>(ActionName<PayloadAction<Payload>> aMgr,
      MiddlewareStreamHandler<State, StateBuilder, Actions, Payload, StreamType> handler) {
    if (!_map.containsKey(aMgr.name)) {
      _map[aMgr.name] = handler;
    }
  }

  /// [combine] combines this MiddlewareBuilder with another MiddlewareBuilder
  /// for the same type
  void combine(MiddlewareStreamBuilder<State, StateBuilder, Actions> other) {
    _map.addAll(other._map);
  }

  /// [build] returns a [Middleware] function that handles all actions added with [add]
  Middleware<State, StateBuilder, Actions> build() {
    return (MiddlewareApi<State, StateBuilder, Actions> api) {
      return (ActionHandler next) => (Action<dynamic> action) {
            final dynamic subscriptionAction = action.payload;
            final String actionName = action.name;

            if (subscriptionAction is PayloadAction) {
              if (subscriptionAction.action == StreamAction.unsubscribe) {
                final StreamSubscription<dynamic> streamSubscription = _streams[actionName];
                streamSubscription.cancel();

                final MapBuilder<String, StreamSubscription<dynamic>> mapBuilder = _streams.toBuilder();
                mapBuilder.remove(actionName);
                _streams = (mapBuilder).build();
              } else {
                if (!_streams.containsKey(actionName)) {
                  final MiddlewareStreamHandler<State, StateBuilder, Actions, dynamic, dynamic> handler = _map[actionName];

                  final MapBuilder<String, StreamSubscription<dynamic>> mapBuilder = _streams.toBuilder();

                  mapBuilder[actionName] = handler.getStream(subscriptionAction.payload).listen(
                    (dynamic event) {
                      handler.onData(api, next, action, event);
                    },
                    onError: (dynamic error, StackTrace stackTrace) {
                      if (handler.cancelOnError) {
                        final StreamSubscription<dynamic> streamSubscription = _streams[actionName];
                        streamSubscription.cancel();

                        final MapBuilder<String, StreamSubscription<dynamic>> mapBuilder = _streams.toBuilder();
                        mapBuilder.remove(actionName);
                        _streams = (mapBuilder).build();
                      }
                      handler.onError(error, stackTrace);
                    },
                    onDone: handler.onDone,
                    cancelOnError: handler.cancelOnError,
                  );

                  _streams = (mapBuilder).build();
                }
              }
            } else {
              next(action);
            }
          };
    };
  }
}

/// This class should only be used in [MiddlewareStreamBuilder]. This provide all the need callback for
/// [Stream.listen] method.
///
/// Example:
/// ```dart
/// class ChatHandler extends MiddlewareStreamHandler<AppState, AppStateBuilder, AppActions, String, Event> {
/// static final Log log = new Log('ChatHandler');
///
/// @override
/// Stream<Event> getStream(String ref) => FirebaseDatabase.instance.reference().child(ref);
///
/// @override
/// void onData(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next, Action action, Event event) {
///   log.d(event.snapshot.value);
///   api.actions.setChats(event.snapshot.value);
/// }
///
/// @override
/// void onDone() => log.d('onDone');
///
/// @override
///   void onError(dynamic error, StackTrace stackTrace) => log.e('onError called with: error:[$error], stackTrace:[$stackTrace]');
/// }
/// ```
abstract class MiddlewareStreamHandler<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, Actions extends ReduxActions, Payload, StreamType> {
  /// The stream you want to listen for events.
  Stream<StreamType> getStream(Payload payload);

  /// see [Stream.listen]
  bool cancelOnError = false;

  /// This will be trigger every time the stream has new data.
  void onData(MiddlewareApi<State, StateBuilder, Actions> api, ActionHandler next, Action action, StreamType event);

  /// see [Stream.listen], this callback is optional
  void onDone() {}

  /// see [Stream.listen], this callback is optional
  void onError(dynamic error, StackTrace stackTrace) {}
}
