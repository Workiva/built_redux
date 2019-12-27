# ReduxActions

## Defining Actions

Redux makes your state easy to manage and reason about. However, the same cannot be said for actions. Actions in any reduxjs or redux.dart app can be difficult to manage, organize, and defining them is often quite verbose.

built_redux and redux.dart approach defining and dispatching actions differently.

In redux.dart each action is defined as its own type. This means an action can be a class, typedef, or enum. The store’s dispatcher takes a single dynamic argument, which lets you dispatch an action of any given type.

built_redux requires you define action dispatchers, which all dispatch an object of type Action. An Action object contains an action name and a generically type payload. A given action dispatcher can only be called with a single argument that matches its generic payload type. This action object is based on the [flux-standard-action](https://github.com/reduxactions/flux-standard-action).

Before we dive into the reasoning behind all of this, lets take a quick look at some example code that defines some actions for a todo application in both redux.dart and built_redux.

redux.dart:

```dart
class AddTodo {
  final String name;
  AddTodo(this.name);
}
class RemoveTodo {
  final String id;
  RemoveTodo(this.id);
}
class ToggleTodoState {
  final String id;
  ToggleTodoState(this.id);
}
class MarkAllTodosAsComplete {}
class SetFilter {
  final int filterType;
  SetFilter(this.filterType);
}
class ClearFilter {}
```

built_redux:

```dart
// _$AppActions is generated
abstract class AppActions extends ReduxActions {
  AppActions._();
  factory AppActions() => _$AppActions();
  ActionDispatcher<String> get addTodo;
  ActionDispatcher<String> get removeTodo;
  ActionDispatcher<String> get toggleTodoState;
  ActionDispatcher<Null> get markAllTodosAsComplete;
  ActionDispatcher<int> get setFilter;
  ActionDispatcher<Null> get clearFilter;
}
```

With built_redux, you can optionally nest multiple instances of ReduxActions. This helps with organization and helps isolate actions that pair to different reducers. The following shows my actions split into two containers; TodosActions and FilterActions:

```dart
// _$AppActions is generated
abstract class AppActions extends ReduxActions {
  AppActions._();
  factory AppActions() => _$AppActions();
  TodosActions todos;
  FilterActions filter;
}
// _$TodosActions is generated
abstract class TodosActions extends ReduxActions {
  TodosActions._();
  factory TodosActions() => _$TodosActions();
  ActionDispatcher<String> get addTodo;
  ActionDispatcher<String> get removeTodo;
  ActionDispatcher<String> get toggleTodoState;
  ActionDispatcher<Null> get markAllTodosAsComplete;
}
// _$FilterActions is generated
abstract class FilterActions extends ReduxActions {
  FilterActions._();
  factory FilterActions() => _$FilterActions();
  ActionDispatcher<int> get setFilter;
  ActionDispatcher<Null> get clearFilter;
}
```

## Dispatching Actions

Now that we have an idea of how actions are defined in the two different libraries, lets take a quick look at the differences in how actions are dispatched.

redux.dart:

```dart
import 'actions.dart';

store.dispatch(AddTodo('get some eggs'));
```

built_redux:

```dart
store.actions.addTodo('get some eggs');
```

So dispatching actions in both systems feels very similar. Let’s discuss why built_redux requires the use of ReduxActions.

- If you're writing a webapp, you probably chose dart partly because of it is statically typed. So the fact that actions are dynamically typed in redux.dart is kind of unfortunate.

- It makes you think of your actions as a single interface rather than many atomic things. This helps you organize and reason about your application’s actions.

- It provides nice autocomplete in your IDE. You simply type store.actions. and you are presented with all your application’s actions. You also don’t have to import any files containing your actions when you are looking to dispatch an action.

- It prevents you from dispatching garbage values.

So the first three points are pretty straight forward, but what exactly does item 4 mean? Let’s discuss at a couple examples. First, in redux.dart nothing is preventing me from calling 

```dart
store.dispatch(4);
```

even though 4 obviously isn’t an action, its an integer. Next, say I’m using thunks. I should be required to dispatch a function that meets the typedef:

```dart
typedef void ThunkAction<State>(Store<State> store);
```

However, I didn’t need the store in my thunk so I simply dispatched:

```dart
store.dispatch(() {
  // my thunk body
});
```

The function dispatched didn’t meet the thunk typedef, and therefore doesn’t get called by my thunk middleware. Now I’m stuck debugging my code trying to figure out why my thunk isn’t working.
