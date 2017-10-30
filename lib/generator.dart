import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class BuiltReduxGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final result = new StringBuffer();
    for (final element in library.allElements) {
      if (_needsReduxActions(element) &&
          element is ClassElement &&
          element.constructors.length > 1) {
        log.info('Generating action classes for ${element.name}');
        result.writeln(_generateActions(element));
      }
    }

    return result.toString();
  }
}

String _generateActions(ClassElement element) =>
    _actionDispatcherClassTemplate(element) +
    _actionNamesClassTemplate(element);

/*

  Action Dispatcher

*/

String _actionDispatcherClassTemplate(ClassElement element) => '''
  class _\$${element.name} extends ${element.name}{
    factory _\$${element.name}() => new _\$${element.name}._();
    _\$${element.name}._() : super._();

    ${_allActionDispatcherFieldsTemplate(element)}

    @override
    void setDispatcher(Dispatcher dispatcher) {
      ${_allSetDispatchersTemplate(element)}
    }
  }
''';

String _allActionDispatcherFieldsTemplate(ClassElement element) =>
    _forEachFieldWithInherited(
        element, _actionDispatcherFieldTemplate, _isActionDispatcher) +
    _forEachFieldWithInherited(
        element, _reduxActionFieldTemplate, _needsReduxActions);

String _actionDispatcherFieldTemplate(ClassElement e, FieldElement f) {
  final genericType = _getActionGenericType(f);
  return 'final ActionDispatcher<${genericType}> ${f.name} = new ActionDispatcher<${genericType}>(\'${e.name}-${f.name}\');';
}

String _reduxActionFieldTemplate(ClassElement e, FieldElement f) {
  final typeName = f.type.element.name;
  return 'final $typeName ${f.name} = new $typeName();';
}

String _allSetDispatchersTemplate(ClassElement element) =>
    _forEachFieldWithInherited(
        element, _setDispatcheTemplate, _isActionDispatcher) +
    _forEachFieldWithInherited(
        element, _setDispatcheTemplate, _needsReduxActions);

String _setDispatcheTemplate(ClassElement e, FieldElement f) =>
    '${f.name}.setDispatcher(dispatcher);';

/*

  Action Names

*/

String _actionNamesClassTemplate(ClassElement element) => '''
  class ${element.name}Names {
    ${_allActionNamesFieldsTemplate(element)}
  }
''';

String _allActionNamesFieldsTemplate(ClassElement element) =>
    _forEachFieldWithInherited(
        element, _actionNameTemplate, _isActionDispatcher);

String _actionNameTemplate(ClassElement e, FieldElement f) {
  final genericType = _getActionGenericType(f);
  return 'static final ActionName<${genericType}> ${f.name} = new ActionName<${genericType}>(\'${e.name}-${f.name}\');';
}

/*

  Util

*/
String _forEachField(
  ClassElement element,
  String fieldTemplate(ClassElement e, FieldElement f),
  bool fieldTest(Element e),
) =>
    element.fields
        .where(
          (f) => fieldTest(f.type.element),
        )
        .fold(
          '',
          (combined, next) => '$combined${fieldTemplate(element, next)}',
        );

String _forEachFieldWithInherited(
  ClassElement element,
  String fieldTemplate(ClassElement e, FieldElement f),
  bool fieldTest(Element e),
) =>
    element.allSupertypes
        .map(
          (s) => _forEachField(s.element, fieldTemplate, fieldTest),
        )
        .fold(
          _forEachField(element, fieldTemplate, fieldTest),
          (combined, next) => '$combined$next',
        );

bool _needsReduxActions(Element element) =>
    element is ClassElement && _hasSuperType(element, 'ReduxActions');

bool _isActionDispatcher(Element element) =>
    element is ClassElement && element.name == 'ActionDispatcher';

bool _hasSuperType(ClassElement classElement, String type) =>
    classElement.allSupertypes
        .any((interfaceType) => interfaceType.name == type) &&
    !classElement.displayName.startsWith('_\$');

String _getActionGenericType(FieldElement e) {
  var typeArgument =
      (e.type as InterfaceType).typeArguments.first as ParameterizedType;
  // generic type has generic type parameters?
  if (typeArgument.typeArguments.isEmpty ||
      typeArgument.typeArguments.every((ta) => ta.name == 'dynamic')) {
    return typeArgument.name;
  }

  final typeArguments =
      typeArgument.typeArguments.map((ta) => ta.toString()).toList();

  // hack for thunks/repatches or any other type argument list where
  // any given argument is a Built and the proceding is a Builder
  // and the builder is dynamic in the typeArguments list becauses it is
  // yet to be generated. This is complex and a bit awkward but
  // it is written this way to be very careful not to make any unintended
  // changes the the typeArguments list.
  final boundParams = typeArgument.typeParameters.map((e) => e.bound);
  for (int i = 0; i < boundParams.length; i++) {
    // get the bound param at this spot
    final b = boundParams.elementAt(i);

    // if it is a Built and there is another argument after it
    // check if it is supposed to be a Builder
    if (b != null &&
        b.name.startsWith('Built') &&
        i != boundParams.length - 1) {
      final next = boundParams.elementAt(i + 1);
      if (next != null &&
          next.name.startsWith('Builder') &&
          typeArguments.elementAt(i + 1) == 'dynamic') {
        log.info(
            "replacing unresolved builder name ${typeArguments.elementAt(i)}Builder");
        // if it is a builder replace typeArguments at this location as
        // the Built's name + Builder
        typeArguments.replaceRange(
          i + 1,
          i + 2,
          ['${typeArguments.elementAt(i)}Builder'],
        );
      }
    }
  }

  return '${typeArgument.name}<${typeArguments.join(',')}>';
}
