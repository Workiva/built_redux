import 'dart:async';
import 'package:built_value/built_value.dart';
import 'built_reducer.dart';
import 'store_change.dart';

/// [SubStateChange] is the payload for `StateChangeTransformer`'s stream. It contains
/// the previous and next value of the state resulting from the mapper provided to `StateChangeTransformer`
class SubStateChange<SubState> {
  SubState prev;
  SubState next;
  SubStateChange(this.prev, this.next);
}

/// [StateMapper] takes a state model and maps it to the values one cares about
typedef SubState StateMapper<State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, SubState>(State state);

/// [StateChangeTransformer] transforms the store's stream to emit an event only when the state resulting from the
/// mapper provided changes
class StateChangeTransformer<State extends BuiltReducer<State, StateBuilder>,
        StateBuilder extends Builder<State, StateBuilder>, SubState>
    implements
        StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
            SubStateChange<SubState>> {
  final StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
      SubStateChange<SubState>> transformer;

  StateChangeTransformer(StateMapper<State, StateBuilder, SubState> mapper)
      : transformer = _buildTransformer(mapper);

  @override
  Stream<SubStateChange<SubState>> bind(
          Stream<StoreChange<State, StateBuilder, dynamic>> stream) =>
      transformer.bind(stream);

  static StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
          SubStateChange<SubState>>
      _buildTransformer<
          State extends BuiltReducer<State, StateBuilder>,
          StateBuilder extends Builder<State, StateBuilder>,
          SubState>(StateMapper<State, StateBuilder, SubState> mapper) {
    return new StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
            SubStateChange<SubState>>(
        (Stream<StoreChange<State, StateBuilder, dynamic>> input,
            bool cancelOnError) {
      StreamController<SubStateChange<SubState>> controller;
      StreamSubscription<StoreChange<State, StateBuilder, dynamic>>
          subscription;

      controller = new StreamController<SubStateChange<SubState>>(
          sync: true,
          onListen: () {
            subscription = input.listen(
              (StoreChange<State, StateBuilder, dynamic> value) {
                try {
                  final nextSubState = mapper(value.next);
                  final prevSubState = mapper(value.prev);
                  if (nextSubState != prevSubState)
                    controller.add(new SubStateChange(
                      prevSubState,
                      nextSubState,
                    ));
                } catch (e, s) {
                  controller.addError(e, s);
                }
              },
              onError: controller.addError,
              onDone: controller.close,
              cancelOnError: cancelOnError,
            );
          },
          onPause: ([Future<dynamic> resumeSignal]) =>
              subscription.pause(resumeSignal),
          onResume: () => subscription.resume(),
          onCancel: () => subscription.cancel());

      return controller.stream.listen(null);
    });
  }
}
