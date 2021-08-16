import 'package:flutter/material.dart';
import 'package:todo_sandbox/presentation/screens/base/base_stateful_screen.dart';

class BaseScreenWithToolbar extends StatefulWidget {
  const BaseScreenWithToolbar({Key? key}) : super(key: key);

  @override
  _BaseScreenWithToolbarState createState() => _BaseScreenWithToolbarState();
}

class _BaseScreenWithToolbarState extends State<BaseScreenWithToolbar> {
  @override
  Widget build(BuildContext context) => BaseStatefulScreen(
      onModelReady: (model) => null,
      builder: (context, model, child) => Container(color: Colors.blueAccent));
}
