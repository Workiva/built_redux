# Nesting Reducers

## Nested built_value

Nesting reducers in built_redux is a bit different than redux.js or redux.dart. Rather than composing a reducer with child reducers, the NestedReducerBuilder class is used to register reducer functions to state nested within your state tree. In the following example Base is the main built class that contains all of the state of the application. Within Base, exists Child. childReducerBuilder is used to register reducer functions that only rebuild base.Child. It is then passed to the baseReducerBuilder via the combineNested method.

```dart

// Base is the main built class that contains all of the state
// for your store. It is passed to the store at instantiation.
// It contains an count and a reference to an instance of Child.
abstract class Base implements Built<Base, BaseBuilder> {
  int get count;
  Child get child;

  Base._();
  factory Base() => new _$Base._(count: 0, child: new Child());
}

// Child contains an count and a reference to an instance of Grandchild.
abstract class Child implements Built<Child, ChildBuilder> {
  int get count;

  Child._();
  factory Child() => new _$Child._(count: 0, grandchild: new Grandchild());
}

// baseReducerBuilder is a reducer that rebuilds Base when baseAction is dispatched.
// It combines the child ReducerBuilder.
// This ReducerBuilder could be modified to handle more
// actions that could rebuild any peice of state within the Base object.
// Reducers added to the ReducerBuilder must have the signature:
// (Base, Action<T>, BaseBuilder)
ReducerBuilder<Base, BaseBuilder> baseReducerBuilder = new ReducerBuilder<Base, BaseBuilder>()
  ..add<Null>(BaseActionsNames.baseAction, (s, a, b) => b.count++)
  ..combineNested(childReducerBuilder);

// childReducerBuilder is a nested reducer builder that rebuilds the
// child built when childAction is dispatched. This NestedReducerBuilder
// could be modified to handle more actions that rebuild Child.
// Reducers added to the NestedReducerBuilder must have the signature:
// (Child, Action<T>, ChildBuilder)
NestedReducerBuilder<Base, BaseBuilder, Child, ChildBuilder> childReducerBuilder =
    new NestedReducerBuilder<Base, BaseBuilder, Child, ChildBuilder>(
        (s) => s.child, (b) => b.child) // maps from the main state object to the nested state
      ..add<Null>(ChildActionsNames.childAction, (s, a, b) => b.count++);

```

## Nested built_collection

One can also create reducer builders that only rebuild built_collections nested within the main state object. In the following example Base is the main built class that contains all of the state of the application. Within Base, exists a BuiltList. listReducerBuilder is used to register reducer functions that only rebuild base.builtList. It is then passed to the baseReducerBuilder via the combineList method. A similiar ReducerBuilder and combine method exists for each collection type in the built_collection library.

```dart

// Base is the main built class that contains all of the state
// for your store. It is passed to the store at instantiation.
// It contains an count and a reference to an instance of Child.
abstract class Base implements Built<Base, BaseBuilder> {
  int get count;
  BuiltList<int> get builtList;

  Base._();
  factory Base() => new _$Base._(count: 0, child: new Child());
}


// baseReducerBuilder is a reducer that rebuilds Base when baseAction is dispatched.
// It combines the child ReducerBuilder.
// This ReducerBuilder could be modified to handle more
// actions that could rebuild any peice of state within the Base object.
// Reducers added to the ReducerBuilder must have the signature:
// (Base, Action<T>, BaseBuilder)
ReducerBuilder<Base, BaseBuilder> baseReducerBuilder = new ReducerBuilder<Base, BaseBuilder>()
  ..add<Null>(BaseActionsNames.baseAction, (s, a, b) => b.count++)
  ..combineList(listReducerBuilder);

// listReducerBuilder is a ListReducerBuilder that rebuilds the list
// when builtListAction is dispatched. This ListReducerBuilder
// could be modified to handle more actions that rebuild builtList.
// Reducers added to the ListReducerBuilder must have the signature:
// (BuiltList<int>, Action<T>, ListBuilder<int>)
ListReducerBuilder<Collection, CollectionBuilder, int> listReducerBuilder =
    new ListReducerBuilder<Collection, CollectionBuilder, int>(
        (s) => s.builtList, (b) => b.builtList) // maps from the main state object to the nested collection
      ..add<Null>(
          CollectionActionsNames.builtListAction, (s, a, b) => b.add(0));

```