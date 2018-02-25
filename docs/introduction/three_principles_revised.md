# Three Principles Revised

## 1. Single source of truth
    
The state of your whole application is stored in an object tree within a single store.
    
This makes it easy to create universal apps, as the state from your server can be serialized and hydrated into the client with no extra coding effort. A single state tree also makes it easier to debug or inspect an application; it also enables you to persist your app's state in development, for a faster development cycle. Some functionality which has been traditionally difficult to implement - Undo/Redo, for example - can suddenly become trivial to implement, if all of your state is stored in a single tree.

## 2. State is read-only
    
The only way to change the state is to emit an action, an object describing what happened.

This ensures that neither the views nor the network callbacks will ever write directly to the state. Instead, they express an intent to transform the state. Because all changes are centralized and happen one by one in a strict order, there are no subtle race conditions to watch out for.

Rather than letting actions be dynamically typed, built redux requires every action dispatched through the ecosystem be an object of type `Action`, which contains a name and a generic payload. This action object is based on the [flux-standard-action](https://github.com/reduxactions/flux-standard-action). They can still be logged, ~~serialized~~, stored, and later replayed for debugging or testing purposes, just like redux.js actions.

## 3. ~~Changes are made with pure functions~~

## 3. Changes are made mutating a builder object
      
To specify how the state tree is transformed by actions, you write reducers.
      
In redux.js and redux.dart, reducers are just pure functions that take the previous state and an action, and return the next state. You are required to return new state objects, instead of mutating the previous state. This is where built_redux differs.
    
With built_redux your reducer functions are passed a referenece to a builder for your state object and you apply any changes to that builder. This means your reducers are actually void functions. This is because, behind the scenes, built_redux calls `.toBuilder()` on your state object once, and passes you a reference to the builder to mutate so you do not have to call `.toBuilder()` or `.rebuild(updates)` on your state objects manually.