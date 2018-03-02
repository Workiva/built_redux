library example;

import 'package:built_value/built_value.dart';
import 'package:built_redux/built_redux.dart';

part 'example.g.dart';
part 'example.built_redux.g.dart';

void main() {
// Create a redux store holding the state of your app.
// Its API contains three getters: stream, state, and actions.
  final store = new Store<Counter, CounterBuilder, CounterActions>(
    reducerBuilder.build(), // build returns a reducer function
    new Counter(),
    new CounterActions(),
  );

  print(store.state.count); // 0
  store.actions.increment(1);
  print(store.state.count); // 1
  store.actions.increment(2);
  print(store.state.count); // 3
  store.actions.decrement(1);
  print(store.state.count); // 2
}

// This is a an implementation of ReduxActions. Actions are what middleware and ui
// components invoke a change to the redux store's state. By extending ReduxActions
// the built_redux generator will generate the required boilerplate to create
// each action and an ActionNames class. The ActionNames class is used to register
// reducers
abstract class CounterActions extends ReduxActions {
  ActionDispatcher<int> get increment;
  ActionDispatcher<int> get decrement;

  // factory to create on instance of the generated implementation of CounterActions
  CounterActions._();
  factory CounterActions() => new _$CounterActions();
}

// This is a built value. It is an immutable model that implements the Built interface.
// All of the state in your redux store is contained in a single built value model.
abstract class Counter implements Built<Counter, CounterBuilder> {
  /// [count] value of the counter
  int get count;

  // Built value constructor. The factory is returning the default state
  Counter._();
  factory Counter() => new _$Counter._(count: 0);
}

// These are reducer functions. They have a (state, action, builder) => void signature.
// They describes how an action transforms the state into the next state by applying changes to the builder supplied.
// You are required to use the builder passed, calling state.rebuild will NOT update the state in your redux store.
void increment(Counter state, Action<int> action, CounterBuilder builder) =>
    builder.count = state.count + action.payload;

void decrement(Counter state, Action<int> action, CounterBuilder builder) =>
    builder.count = state.count - action.payload;

// This is a reducer builder. Use of ReducerBuilder is not required, however it
// is strongly recommended as it gives you static type checking to make sure
// the payload for action name provided is the same as the expected payload
// for the action provided to your reducer. Calling .build() returns a reducer function
// that can be passed to the store's constructor.
final reducerBuilder = new ReducerBuilder<Counter, CounterBuilder>()
  ..add(CounterActionsNames.increment, increment)
  ..add(CounterActionsNames.decrement, decrement);
