import 'package:built_redux/built_redux.dart';

import '../reducers/group.dart';

import '../reducers/app_state.dart';
import '../reducers/groups.dart';

var createGroupName = 'CREATE_GROUP';

createGroup(String name) => new Action<String>()
  ..name = createGroupName
  ..payload = name;

newGroupMiddleware(MiddlewareApi api) => (ActionHandler next) => (Action action) {
      if (action.name != createGroupName) return next(action);

      var newGroup = _newGroup(action.payload);
      api.dispatch(addGroup(newGroup));
      api.dispatch(setCurrentGroup(newGroup.id));
    };

// util
_newGroup(String name) => new Group((b) => b
  ..id = new DateTime.now().millisecondsSinceEpoch
  ..name = name
  ..done = false);
