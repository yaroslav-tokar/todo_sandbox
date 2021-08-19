import 'package:flutter/material.dart';
import 'package:todo_sandbox/data/models/note_details_model.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/screens/base/screen/base_screen.dart';
import 'package:todo_sandbox/presentation/screens/base/state/base_state_with_arguments.dart';
import 'package:todo_sandbox/presentation/screens/note/text_field.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({Key? key}) : super(key: key);

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends BaseStateWithArguments<NoteDetailsBloc,
    NoteDetailsScreen, NoteDetailsArgument> {
  @override
  Widget build(BuildContext context) => BaseScreenView<NoteDetailsBloc>(
        bloc: bloc,
        onBackBtnPressed: bloc.onBackButtonPressed,
        hasToolbar: true,
        content: buildBody,
      );

  @override
  Widget get buildBody => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: <Widget>[
              NoteEditTextField(
                height: 52,
                controller: bloc.titleEtc,
                etName: 'Title',
              ),
              NoteEditTextField(
                controller: bloc.contentEtc,
                etName: 'Content',
              )
            ],
          ),
        ),
      );
}
