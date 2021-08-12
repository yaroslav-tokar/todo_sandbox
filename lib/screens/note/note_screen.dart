import 'package:flutter/material.dart';
import 'package:todo_sandbox/di/di.dart';
import 'package:todo_sandbox/screens/base/base_screen.dart';
import 'package:todo_sandbox/stateful_model/note_stateful_model.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) => BaseStatefulScreen<NoteStatefulModel>(
      onModelReady: (model) => locator<NoteStatefulModel>(),
      builder: (context, model, child) {
        return Container(color: Colors.blue);
      });
}
