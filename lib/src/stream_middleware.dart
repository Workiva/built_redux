import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';

enum SubscriptionAction { subscribe, unsubscribe }

class MiddlewareStreamBuilder<State extends Built<State, StateBuilder>, StateBuilder extends Builder<State, StateBuilder>,
    Actions extends ReduxActions> {
  BuiltMap<String, StreamSubscription<dynamic>> _streams = new BuiltMap<String, StreamSubscription<dynamic>>();

  final Map<String, MiddlewareStreamHandler<State, StateBuilder, Actions, dynamic>> _map =
      <String, MiddlewareStreamHandler<State, StateBuilder, Actions, dynamic>>{};

  void add<T>(ActionName<T> aMgr, MiddlewareStreamHandler<State, StateBuilder, Actions, T> handler) {
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

            if (action.payload is SubscriptionAction) {
              if (subscriptionAction == SubscriptionAction.unsubscribe) {
                final StreamSubscription<dynamic> streamSubscription = _streams[actionName];
                streamSubscription.cancel();

                final MapBuilder<String, StreamSubscription<dynamic>> mapBuilder = _streams.toBuilder();
                mapBuilder.remove(actionName);
                _streams = (mapBuilder).build();
              } else {
                if (!_streams.containsKey(actionName)) {
                  final MiddlewareStreamHandler<State, StateBuilder, Actions, dynamic> handler = _map[actionName];

                  final MapBuilder<String, StreamSubscription<dynamic>> mapBuilder = _streams.toBuilder();

                  mapBuilder[actionName] = handler.stream.listen(
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
/// [Stream.listen] method
abstract class MiddlewareStreamHandler<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, Actions extends ReduxActions, T> {
  /// The stream you want to listen for events.
  Stream<T> get stream;

  /// see [Stream.listen]
  bool cancelOnError = false;

  /// This will be trigger every time the stream has new data.
  void onData(MiddlewareApi<State, StateBuilder, Actions> api, ActionHandler next, Action action, T event);

  /// see [Stream.listen], this callback is optional
  void onDone() {}

  /// see [Stream.listen], this callback is optional
  void onError(dynamic error, StackTrace stackTrace) {}
}
