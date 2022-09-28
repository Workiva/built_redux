import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class BuiltReduxGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final result = StringBuffer();
    var hasWrittenHeaders = false;
    for (final element in library.allElements.whereType<InterfaceElement>()) {
      if (_isReduxActions(element)) {
        if (!hasWrittenHeaders) {
          hasWrittenHeaders = true;
          result.writeln(_lintIgnores);
        }
        log.info('Generating action classes for ${element.name}');
        result.writeln(_generateActions(element));
      }
    }

    return result.toString();
  }
}

const _lintIgnores = """
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: overridden_fields
// ignore_for_file: type_annotate_public_apis
""";

ActionsClass _actionsClassFromElement(InterfaceElement element) => ActionsClass(
      element.name,
      _actionsFromElement(element).toSet(),
      _composedActionClasses(element).toSet(),
      _actionsClassFromInheritedElements(element).toSet(),
    );

Iterable<ComposedActionClass> _composedActionClasses(InterfaceElement element) =>
    element.fields.where((f) => _isReduxActions(f.type.element2)).map((f) =>
        ComposedActionClass(
            f.name, f.type.getDisplayString(withNullability: true)));

Iterable<Action> _actionsFromElement(InterfaceElement element) => element.fields
    .where(_isActionDispatcher)
    .map((field) => _fieldElementToAction(element, field));

Iterable<ActionsClass> _actionsClassFromInheritedElements(
        InterfaceElement element) =>
    element.allSupertypes
        .map((s) => s.element2)
        .where(_isReduxActions)
        .map(_actionsClassFromElement);

Action _fieldElementToAction(InterfaceElement element, FieldElement field) =>
    Action('${element.name}-${field.name}', field.name,
        _fieldType(element, field));

// hack to return the generics for the action
// this is used so action whose payloads are of generated types
// will not result in dynamic
String _fieldType(InterfaceElement element, FieldElement field) {
  if (field.isSynthetic) {
    return _syntheticFieldType(element, field);
  }
  return _getGenerics(field.source!.contents.data, field.nameOffset);
}

String _syntheticFieldType(InterfaceElement element, FieldElement field) {
  final method = element.getGetter(field.name);
  return _getGenerics(method!.source.contents.data, method.nameOffset);
}

String _getGenerics(String source, int nameOffset) {
  final trimAfterName = source.substring(0, nameOffset);
  final trimBeforeActionDispatcher =
      trimAfterName.substring(trimAfterName.lastIndexOf('ActionDispatcher'));
  return trimBeforeActionDispatcher.substring(
      trimBeforeActionDispatcher.indexOf('<') + 1,
      trimBeforeActionDispatcher.lastIndexOf('>'));
}

bool _isReduxActions(Element? element) =>
    element is InterfaceElement && _hasSuperType(element, 'ReduxActions');

bool _isActionDispatcher(FieldElement element) => element.type
    .getDisplayString(withNullability: true)
    .startsWith('ActionDispatcher<');

bool _hasSuperType(InterfaceElement InterfaceElement, String type) =>
    InterfaceElement.allSupertypes
        .any((interfaceType) => interfaceType.element2.name == type) &&
    !InterfaceElement.displayName.startsWith('_\$');

String _generateActions(InterfaceElement element) {
  final actionClass = _actionsClassFromElement(element);
  return _generateDispatchersIfNeeded(element, actionClass) +
      _actionNamesClassTemplate(actionClass);
}

String _generateDispatchersIfNeeded(
        InterfaceElement element, ActionsClass actionsClass) =>
    element.constructors.length > 1
        ? _actionDispatcherClassTemplate(actionsClass)
        : '';

/*

  Action Dispatcher

*/

String _actionDispatcherClassTemplate(ActionsClass actionsClass) => '''
  class _\$${actionsClass.className} extends ${actionsClass.className}{
    factory _\$${actionsClass.className}() => _\$${actionsClass.className}._();
    _\$${actionsClass.className}._() : super._();

    ${_allActionDispatcherFieldsTemplate(actionsClass)}
    ${_allComposedActionClassesFieldsTemplate(actionsClass)}

    @override
    void setDispatcher(Dispatcher dispatcher) {
      ${_allActionDispatcherSetDispatchersTemplate(actionsClass)}
      ${_allComposedActionClassesSetDispatchersTemplate(actionsClass)}
    }
  }
''';

String _allActionDispatcherFieldsTemplate(ActionsClass actionsClass) =>
    actionsClass.allActions.fold(
        '', (comb, next) => '$comb\n${_actionDispatcherFieldTemplate(next)}');

String _allComposedActionClassesFieldsTemplate(ActionsClass actionsClass) =>
    actionsClass.allComposed.fold('',
        (comb, next) => '$comb\n${_composedActionClassesFieldTemplate(next)}');

String _actionDispatcherFieldTemplate(Action action) =>
    'final ${action.fieldName} =  ActionDispatcher<${action.type}>(\'${action.actionName}\');';

String _composedActionClassesFieldTemplate(
        ComposedActionClass composedActionClass) =>
    'final ${composedActionClass.fieldName} = ${composedActionClass.type}();';

String _allActionDispatcherSetDispatchersTemplate(ActionsClass actionsClass) =>
    actionsClass.allActions.fold(
        '', (comb, next) => '$comb\n${_setDispatcheTemplate(next.fieldName)}');

String _allComposedActionClassesSetDispatchersTemplate(
        ActionsClass actionsClass) =>
    actionsClass.allComposed.fold(
        '', (comb, next) => '$comb\n${_setDispatcheTemplate(next.fieldName)}');

String _setDispatcheTemplate(String fieldName) =>
    '${fieldName}.setDispatcher(dispatcher);';

// /*

//   Action Names

// */

String _actionNamesClassTemplate(ActionsClass actionsClass) => '''
  class ${actionsClass.className}Names {
    ${_allActionNamesFieldsTemplate(actionsClass)}
  }
''';

String _allActionNamesFieldsTemplate(ActionsClass actionsClass) =>
    actionsClass.allActions
        .fold('', (comb, next) => '$comb\n${_actionNameTemplate(next)}');

String _actionNameTemplate(Action action) =>
    'static final ${action.fieldName} = ActionName<${action.type}>(\'${action.actionName}\');';

class ActionsClass {
  final String className;
  final Set<Action> actions;
  final Set<ComposedActionClass> composed;
  final Set<ActionsClass> inherited;
  ActionsClass(this.className, this.actions, this.composed, this.inherited);
  Set<Action> get allActions => Set<Action>.from(
        actions.toList()
          ..addAll(inherited.map((ac) => ac.actions).expand((a) => a)),
      );
  Set<ComposedActionClass> get allComposed => Set<ComposedActionClass>.from(
        composed.toList()
          ..addAll(inherited.map((ac) => ac.composed).expand((c) => c)),
      );

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActionsClass && className == other.className;
  }

  @override
  int get hashCode => className.hashCode;
}

class Action {
  final String actionName;
  final String fieldName;
  final String type;
  Action(this.actionName, this.fieldName, this.type);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Action && fieldName == other.fieldName;
  }

  @override
  int get hashCode => fieldName.hashCode;
}

class ComposedActionClass {
  final String fieldName;
  final String type;
  ComposedActionClass(this.fieldName, this.type);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Action && fieldName == other.fieldName;
  }

  @override
  int get hashCode => fieldName.hashCode;
}
