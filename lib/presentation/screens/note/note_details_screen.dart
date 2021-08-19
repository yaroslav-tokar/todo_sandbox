import 'package:flutter/material.dart';
import 'package:todo_sandbox/data/models/note_details_model.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/screens/base/screen/base_screen.dart';
import 'package:todo_sandbox/presentation/screens/base/state/base_state_with_arguments.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({Key? key}) : super(key: key);

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends BaseStateWithArguments<NoteDetailsBloc,
    NoteDetailsScreen, NoteDetailsArgument> {
  @override
  Widget build(BuildContext context) => BaseScreenView<NoteDetailsBloc>(
      hasBackBtn: false,
      bloc: block,
      hasToolbar: true,
      title: 'Note details',
      content: buildBody);

  @override
  Widget get buildBody => Column(children: const <Widget>[
        Expanded(child: Center(child: Text('Note details')))
      ]);
}
