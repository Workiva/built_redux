# Store

In the previous sections, we defined the [actions](actions.md) that represent the facts about “what happened” and the [reducers](reducers.md) that update the state according to those [actions](actions.md).

The Store is the object that brings them together. The store has the following responsibilities:

Holds application state, listens for actions, and rebuilds the state when an action is dispatched.

Allows access to state the state getter.

Allows state to be updated via the actions getter.

Registers listeners to store changes via stream/nextState stream.

Registers listeners to changes to specific peices of state via substateStream/nextSubstate stream.

Registers listeners to changes caused by specific actions via the actionStream stream.

It's important to note that you'll only have a single store in a Redux application. When you want to split your data handling logic, you'll use reducer composition instead of many stores.

A store requires 3 parameters:

- Actions
- Default State
- Reducer

And accepts and optional parameter

- []Middleware