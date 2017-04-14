import 'package:func_comp/func_comp.dart';
import 'package:over_react/over_react.dart';

typedef OnSubmit(String p);

class CreatorProps extends StateMgr {
  OnSubmit onSubmit;
  String name;
}

FunctionalComponent<CreatorProps> creatorComponent =
    withState<CreatorProps>({'creating': false})(createBranch);

FunctionalComponent<CreatorProps> createBranch = branch<CreatorProps>(
  (CreatorProps props) => props.state['creating'],
  creator,
  initiator,
);

ReactElement initiator(CreatorProps props) => (Dom.button()
  ..onClick = (_) => props.setState({
        'creating': true,
        'value': '',
      }))('add ${props.name}');

ReactElement creator(CreatorProps props) => Dom.div()(
      textInput(props),
      submitButton(props),
      cancelButton(props),
    );

ReactElement textInput(CreatorProps props) => (Dom.input()
  ..type = "text"
  ..value = props.state['value']
  ..onChange = (e) => props.setState({'value': e.target.value}))();

ReactElement submitButton(CreatorProps props) => (Dom.button()
  ..onClick = (_) {
    props.onSubmit(props.state['value']);
    props.setState({'creating': false});
  })('submit');

ReactElement cancelButton(CreatorProps props) =>
    (Dom.button()..onClick = (_) => props.setState({'creating': false}))('cancel');
