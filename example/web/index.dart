library example;

import 'dart:async';
import 'dart:html';

import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;
import 'package:built_redux/built_redux.dart';
import 'package:react_built_redux/react_built_redux.dart';
import 'package:recompose_dart/recompose_dart.dart';

import 'package:example/example.dart';

Future main() async {
  react_client.setClientConfiguration();

  var reduxStore = new Store<AppState, AppStateBuilder, AppStateActions>(
    new AppState(),
    new AppStateActions(),
    middleware: [creatorMiddeware],
  );

  ReactElement base = todosReduxBuilder(null);
  print(base);

  react_dom.render(
    (Provider()..store = reduxStore)(
      todosReduxBuilder(null),
    ),
    querySelector('#container'),
  );
}
