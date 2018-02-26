# Using built_value with redux.dart vs built_redux

## Eliminate unneccessary garbage

So, built_value is legit right? It makes sense to use it with your dart redux application. But why what does built_redux do to make reduxing with built_value easier? Why shouldn’t I just use built_value with redux.dart? Let’s run through an example. Say I’m using redux.dart and my state is a built_value is defined as follows:

```dart
abstract class State implements Built<State, StateBuilder> {
    State._();
    factory State(void updates(StateBuilder b)) = _$State;
    NestedStateA get nestedA;
    NestedStateB get nestedB;
}
```

As I have started writing my reducer for State I’ve noticed the reducer is becoming very complex, so I’ve decided to create a couple nested reducers. One to reduce nestedA and one to reduce nestedB. I end up with something like:

```dart
State reducer(State state, dynamic a) => state.rebuild((StateBuilder builder, dynamic a) => builder
    ..nestedA = nestedAReducer(state.nestedA, a).toBuilder()
    ..nestedB = nestedBReducer(state.nestedB, a).toBuilder());
```

You will notice nestedAReducer and nestedBReducer call toBuilder() immediately after being executed. This is because StateBuilder has setters for nestedA and nestedB, but they are of type NestedABuilder and NestedBBuilder, not NestedA and NestedB.

This sucks for a couple reasons:

- If nestedAReducer doesn’t end up handling an action it will return the last instance of nestedA. However, I still have to call toBuilder() and create a new object in order to assign the result back to State’s builder. This seems totally unnecessary because nothing even changed.

- If nestedAReducer does end up handling an action it will have to create an instance of NestedABuilder in order to build an instance of NestedA to return from nestedAReducer. We then have to turn around and create a whole new instance of NestedABuilder even though we literally just had one. GAHHH.

All of this unnecessary calling of toBuilder() means running my reducer will take longer allocating memory and my app will spend more time garbage collecting later.
So what can I do to alleviate this issue? Instead I decide to pass the builders from State’s builder to the nested reducer functions:

```dart
State reducer(State state, dynamic a) => state.rebuild((builder, a) => builder
    ..nestedA = nestedAReducer(state.nestedA, a, builder.nestedA)
    ..nestedB = nestedBReducer(state.nestedB, a, builder.nestedB))
```

However, now I cannot use redux.dart’s combineTypedReducers for my nested reducers since (state, action, builder) doesn’t match the Reducer typedef. Plus what if nestedAReducer doesn’t even handle an action? I created an instance of NestedABuilder just to pass to a function that doesn’t use it. (This is because StateBuilder will not instantiate an instance of NestedABuilder until nestedA is accessed.)

Behind the scenes, the built_redux library calls rebuild on your main state object once, and lets you define reducer & nested reducer functions that have the signature void (state, action, builder). By design, built_redux will only create nested builders if they are used in the reducer function that is mapped to the action being handled. built_redux also lets you create nested said reducer functions for built_collections. More documentation on nested reducer functions exists [here](../advanced/nested_reducers.md).
