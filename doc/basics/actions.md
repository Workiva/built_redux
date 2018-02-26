# Actions

## What is an action

Actions are objects that contain information that send data from your application to your store. They are the only source of information for the store. You send them to the store using action dispatchers. The action class is defined in the redux repo, but you write action dispatchers that dispatch actions.

## Defining Action Dispatchers

Say I'm writing a simple counter app and my built_redux store is storing the state of the counter. My ui has two buttons, increment and decrement. When those buttons are clicked I want to notify the store to update the value of the counter. Since the store's state is immutable, I cannot just call

```dart
store.state.count++
```

or

```dart
store.state.count--
```

I must dispatch an action to tell the store to update. So I want to define two actions dispatchers, increment and decrement.

```dart
abstract class AppActions extends ReduxActions {
  AppActions._();
  factory AppActions() => new _$AppActions();
  ActionDispatcher<Null> increment;
  ActionDispatcher<Null> decrement;
}
```

When these action dispatchers are called, an instance of `Action` will be dispatched. Its name property will be either 'AppActions-increment` or 'AppActions-decrement'.

The actions can be dispatched by calling

```dart
store.actions.increment();
```

or

```dart
store.actions.decrement();
```

Notice the generic of both action dispatchers is Null and nothing is passed to the dispatchers when they are called. This is because no payload information is required to tell a reducer registered to these actions how to increment or decrement. This also means the payload property of the action will always be null.

However, say my ui had a number input field next to each button, signifying how much to increment or decrement by. In this case I would want to send that value to the store along with my action. Therefore I would use int as the generic type of the payload, like so:

```dart
abstract class AppActions extends ReduxActions {
  AppActions._();
  factory AppActions() => new _$AppActions();
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;
}
```

The actions can be dispatched by calling

```dart
store.actions.increment(2);
```

or

```dart
store.actions.decrement(3);
```

When these action dispatchers are called the name property will still be either 'AppActions-increment` or 'AppActions-decrement'. However, the payload property will be an integer with the value passed to the dispatcher.

## Action Boilerplate Code Generation

Notice the AppActions classes defined in the previous section were abstract classes, the dispatchers were not assigned a value, and there is some funkiness going on with the constructors.

This is because built_redux provides a code generator to generate all of the boilerplate needed to define and configure each action dispatcher.

The generator will generate two classes.

One is the implementation of AppActions, which is generated as _$AppActions. This class assigns a value to each action dispatcher and implements `ReduxActions` setDispatcher method.

The second is a class with an 'ActionName' for each dispatcher, which is generated as AppActionsNames. This class provides a static accessor for each `ActionDispatcher` that is typed with a generic that is the same as the `ActionDispatcher` payload generic. This allows you to build reducer and middleware handlers with type safety without having to instantiate your instance of [ReduxActions]

It is important to note that you must follow the same pattern as built value to define your library with parts.

For example my file for AppActions would like like

```dart
library app_actions;

import 'package:built_redux/built_redux.dart';

part 'app_actions.g.dart';

abstract class AppActions extends ReduxActions {
  AppActions._();
  factory AppActions() => new _$AppActions();
  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;
}
```