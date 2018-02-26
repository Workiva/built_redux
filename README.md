# built_redux

[![Pub](https://img.shields.io/pub/v/built_redux.svg)](https://pub.dartlang.org/packages/built_redux)
[![codecov.io](http://codecov.io/github/davidmarne/built_redux/coverage.svg?branch=master)](http://codecov.io/github/davidmarne/built_redux?branch=master)

built_redux is a state management library written in dart that enforces immutability.
built_redux is not only an implementation of [redux][redux_git], but also a framework for building middleware and reducers in a type safe manner.

Inspired by [redux][redux_git]

Built using [built_value][built_value_git]

## Framework bindings

[flutter]

## Examples

[counter app](example/example.dart)

flutter [todo_mvc], written by [Brian Egan]

vanilla dart, angular, and wui_builder [todoMVCs]

[retro] - firebase and angular

## Libraries

[thunk][built_redux_thunk]

[rx][built_redux_rx]

[repatch][built_redux_repatch]

## Documentation

* [Introduction](docs/introduction/README.md)
  * [Three Principles Revised](docs/introduction/three_principles_revised.md)
  * [built_value](docs/introduction/built_value.md)
  * [Using built_value with redux.dart vs built_redux](docs/introduction/built_value_with_redux.md)
  * [ReduxActions](docs/introduction/redux_actions.md)
* [Basics](docs/basics/README.md)
  * [setup](docs/basics/setup.md)
  * [actions](docs/basics/actions.md)
  * [reducers](docs/basics/reducers.md)
  * [store](docs/basics/store.md)
  * [middleware](docs/basics/middleware.md)
  * [testing](docs/basics/testing.md)
* [Advanced](docs/advanced/README.md)
  * [Observing](docs/advanced/observing.md)
  * [ReducerBuilder](docs/advanced/building_reducers.md)
  * [Nesting Reducers](docs/advanced/nested_reducers.md)
  * [MiddlewareBuilder](docs/advanced/building_middleware.md)
  * [Async Flow](docs/advanced/async_flow.md)

[built_value_blog]: https://medium.com/dartlang/darts-built-value-for-immutable-object-models-83e2497922d4

[built_value_git]: https://github.com/google/built_value.dart/

[redux_git]: https://github.com/reactjs/redux

[redux_docs]: http://redux.js.org/

[todoMVCs]: https://github.com/davidmarne/built_redux_todos

[flutter]: https://github.com/davidmarne/flutter_built_redux

[built_redux_thunk]: https://github.com/davidmarne/built_redux_thunk

[built_redux_rx]: https://github.com/davidmarne/built_redux_rx

[built_redux_repatch]: https://github.com/davidmarne/built_redux_repatch

[flutter_built_redux]: https://github.com/davidmarne/flutter_built_redux

[retro]: https://github.com/davidmarne/retro

[todo_mvc]: https://gitlab.com/brianegan/flutter_architecture_samples/tree/master/example/built_redux

[Brian Egan]: https://gitlab.com/brianegan
