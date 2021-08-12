import 'package:flutter/material.dart';
import 'package:todo_sandbox/screens/base/base_state.dart';
import 'package:todo_sandbox/state/base_state.dart';
import 'package:todo_sandbox/view_model.dart';

@immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStateWithModel<HomeModel, HomeScreen> {
  @override
  Widget build(BuildContext context) => BaseScreenView<HomeModel>(
      hasBackBtn: false,
      model: statefulModel,
      hasToolbar: true,
      content: buildBody()!,
      title: 'Notes');

  @override
  Widget? buildBody() => Container(
          child: Column(
        children: [
          Center(
              child: ElevatedButton(
            onPressed: statefulModel.makeRequest,
            child: Text('press to load'),
          ))
        ],
      ));
}
