import 'dart:async';
import 'package:built_value/built_value.dart';
import 'store_change.dart';

/// [SubstateChange] is the payload for `StateChangeTransformer`'s stream. It contains
/// the previous and next value of the state resulting from the mapper provided to `StateChangeTransformer`
class SubstateChange<Substate> {
  Substate prev;
  Substate next;
  SubstateChange(this.prev, this.next);
}

/// [StateMapper] takes a state model and maps it to the values one cares about
typedef Substate StateMapper<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, Substate>(State state);

/// [StateChangeTransformer] transforms the store's stream to emit an event only when the state resulting from the
/// mapper provided changes
class StateChangeTransformer<State extends Built<State, StateBuilder>,
        StateBuilder extends Builder<State, StateBuilder>, Substate>
    implements
        StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
            SubstateChange<Substate>> {
  final StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
      SubstateChange<Substate>> transformer;

  StateChangeTransformer(StateMapper<State, StateBuilder, Substate> mapper)
      : transformer = _buildTransformer(mapper);

  @override
  Stream<SubstateChange<Substate>> bind(
          Stream<StoreChange<State, StateBuilder, dynamic>> stream) =>
      transformer.bind(stream);

  static StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
          SubstateChange<Substate>>
      _buildTransformer<
          State extends Built<State, StateBuilder>,
          StateBuilder extends Builder<State, StateBuilder>,
          Substate>(StateMapper<State, StateBuilder, Substate> mapper) {
    return new StreamTransformer<StoreChange<State, StateBuilder, dynamic>,
            SubstateChange<Substate>>(
        (Stream<StoreChange<State, StateBuilder, dynamic>> input,
            bool cancelOnError) {
      StreamController<SubstateChange<Substate>> controller;
      StreamSubscription<StoreChange<State, StateBuilder, dynamic>>
          subscription;

      controller = new StreamController<SubstateChange<Substate>>(
          sync: true,
          onListen: () {
            subscription = input.listen(
              (StoreChange<State, StateBuilder, dynamic> value) {
                try {
                  final nextSubstate = mapper(value.next);
                  final prevSubstate = mapper(value.prev);
                  if (nextSubstate != prevSubstate)
                    controller.add(new SubstateChange(
                      prevSubstate,
                      nextSubstate,
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
