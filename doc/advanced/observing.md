# Observing

## Observing state changes

The store's stream fires with a payload of type StoreChange. This is an object
that contains the action, the previous state, and the next state. 

```dart

print(store.state.count); // 0

store.nextState.listen((change) {
    print('Previous: ${change.prev.count}');
    print('Next: ${change.next.count}');
    print('Action: ${change.action.name}');
});

store.actions.increment(1);

// Previous: 0
// Next: 1
// Action: AppActions-increment

```

If you would
like to set up a stream thats payload is simply the next state, use store.nextState

```dart

print(store.state.count); // 1

store.nextState.listen(print);

store.actions.increment(1);
store.actions.increment(3);

// 2
// 5

```

## Observing substate

Streams can easily be accessed to observe any piece of your state tree by passing a mapper the store's substateStream function. For example, say I only care about BaseCounter.count in the previous example and I do not want to be notified when BaseCounter.nestedCounter changes. I can create a stream that will only emit an event when BaseCounter.count changes, as so:

```dart

print(store.state.count); // 0

final countStream = store.substateStream<int>((BaseCounter state) => state.count);

.listen((change) {
    print('Previous: ${change.prev}');
    print('Next: ${change.next}');
});

store.actions.increment(1);
store.actions.nestedCounter.increment(2); // nothing will be printed for this action

// Previous: 0
// Next: 1


```

In the case of substate streams, the payload is of type SubStateChange. This is an object the previous state, and the next state. If you would like to set up a stream thats payload is simply the next subState, use store.nexSubstate

```dart

print(store.state.count); // 0

store.nextSubstate((BaseCounter state) => state.count)
  .listen(print);

store.actions.increment(1);
store.actions.increment(3);

// 1
// 4

```

## Observing changes caused by a given action

Streams can easily be accessed to observe any time a specific action causes a state change:

```dart

print(store.state.count); // 0

store.actionStream(AppActionNames.increment).listen((change) {
    print('Previous: ${change.prev.count}');
    print('Next: ${change.next.count}');
    print('Action: ${change.action.name}');
});

store.actions.increment(1);
store.actions.decrement(1); // prints nothing

// Previous: 0
// Next: 1
// Action: AppActions-increment

```
