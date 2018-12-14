# built_value

We are going to get started with a quick introduction to built_value.dart because built_redux is tightly coupled with built_value.dart.

If you have used dart much you probably know value types are not built into the language. However, value types are incredibly powerful for many reasons, and are very applicable to the redux pattern because when using redux you are storing all of your application’s state in a single immutable object. That object would ideally be an value type and not a class because it is simply data. It shouldn’t have instance methods, or private state. It should just be data.

That state object should also be immutable because you only want your store’s state to be updated by dispatching actions. If the state was mutable, and was mutated by means other than an action, the store would not know to dispatch an event notifying it’s subscribers of the change.

[built_value.dart](https://github.com/google/built_value.dart) is a library written by David Morgan that provides a solution implementing immutable value types in dart. The library lets you define your value types as abstract classes and includes a generator for implementing all of the boilerplate. This means you don’t have to implement equality checks, hashCode, toString, clone functions, or serialization logic yourself. It also means its impossible for bugs in said functions to sneak in. built_value also generates serializers for your models which makes network communication easy. It also opens doors for other common redux practices such as persisting and reloading your app state to and from local storage.

Take [this model](https://github.com/MSzalek-Mobile/weight_tracker/blob/v1.3/lib/model/weight_entry.dart) for example. That is simple model from a redux.dart application. It only has 4 properties but ends up being 55 lines! With built_value, that model can be reduced to about a fourth of the size. The built value implementation would include all of the same functionality plus a nice toString implementation.

```dart
abstract class WeightEntry implements Built<WeightEntry, WeightEntryBuilder> {
    static Serializer<WeightEntry> get serializer => _$weightEntrySerializer;

    WeightEntry._();
    factory WeightEntry(updates(WeightEntryBuilder b)) = _$WeightEntry;

    WeightEntry.fromSnapshot(DataSnapshot snapshot) =>
        serializers.deserializeWith(serializers.WeightEntry, snapshot.val());

    String get key;
    DateTime get dateTime;
    double get weight;
    String get note;
}
```
