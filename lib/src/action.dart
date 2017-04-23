/// [Action] is the object passed to your reducer to signify the state change that needs to take place.
/// Action [name]s should always be unique!
class Action<Payload> {
  /// A unique action name.
  String name;

  /// The actions payload.
  Payload payload;
}

// Dispatches an action to the store
typedef Dispatcher<P>(Action<P> action);

/// [ActionDispatcher] dispatches an action with the name provided
/// in the constructor and the payload supplied when called. You will notice
/// [ActionDispatcher] is an object, however it is to be used like a function.
/// In the following example increment is an action dispatcher, that when called
/// dispatches an action to the redux store with the name increment and the payload 3.
///
/// ```dart
/// store.actions.increment(3);
/// ```
class ActionDispatcher<P> {
  Dispatcher _dispatcher;
  final String _name;

  String get name => _name;

  call(P payload) => _dispatcher(new Action<P>()
    ..name = name
    ..payload = payload);

  ActionDispatcher(this._name);

  syncWithStore(dispatcher) {
    _dispatcher = dispatcher;
  }
}

/// [ReduxActions] is a container for all of your applications actions.
///
/// When using [ReduxActions] the developer does not have to instantiate their [ActionDispatcher]s,
/// they only need to define them.
///
/// The generator will generate a class with all of the boilerplate need to instantiate the
/// [ActionDispatcher]s and sync them with the redux action dispatcher.
///
/// The generator will also generate another class, [ActionNames], that contains
/// a static accessors for each [ActionDispatcher] that is typed with a generic that is the same
/// as the [ActionDispatcher] payload generic. This allows you to build reducer handlers with type
/// safety without having to instantiate your instance of [ReduxActions].
///
/// One can also next [ReduxActions] just like one can nest [BuiltReducer]s.
///
///  Example:
///
///  The following actions generate to
///  ```dart
///
///  abstract class BaseActions {
///   ActionDispatcher<int> foo;
///   NestedActions nestedActions;
///  }
///
///  abstract class NestedActions {
///   ActionDispatcher<int> bar;
///  }
///  ```
///
///  ```dart
///  class _$BaseActions extends BaseActions {
///   final ActionDispatcher<int> foo = new ActionDispatcher<int>('BaseActions-foo');
///   final NestedActions nestedActions = new NestedActions();
///
///   factory _$BaseActions() => new _$BaseActions._();
///   _$BaseActions._() : super._();
///
///   syncWithStore(dispatcher) {
///     foo.syncWithStore(dispatcher);
///     nestedActions.syncWithStore(dispatcher);
///   }
/// }
///
///  class AppStateActionsNames {
///   static ActionName foo = new ActionName<int>('BaseActions-foo');
/// }
/// ```
///
abstract class ReduxActions {
  syncWithStore(dispatcher);
}

/// [ActionName] is an object that simply contains the action name but is typed with a generic that
/// is the same as the relative [ActionDispatcher]s payload generic. This allows you to declare reducer
/// handlers with safety without having to instantiate your instance of [ReduxActions].
class ActionName<T> {
  String name;
  ActionName(this.name);
}
