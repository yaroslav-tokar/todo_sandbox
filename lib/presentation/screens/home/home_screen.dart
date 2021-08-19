import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/presentation/block/home_block.dart';
import 'package:todo_sandbox/presentation/custom_view/material_note_card_view.dart';
import 'package:todo_sandbox/presentation/custom_view/note_view.dart';
import 'package:todo_sandbox/presentation/screens/base/screen/base_screen.dart';
import 'package:todo_sandbox/presentation/screens/base/state/base_state.dart';

@immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeBlock, HomeScreen> {
  @override
  void initState() {
    super.initState();
    bloc.fetchNotes();
  }

  @override
  Widget build(BuildContext context) => BaseScreenView<HomeBlock>(
      bloc: bloc,
      hasToolbar: true,
      onFloatingActionButtonTapped: bloc.onFloatingActionButtonClicked,
      content: buildBody,
      title: 'Notes');

  @override
  Widget get buildBody => SingleChildScrollView(
          child: Column(
        children: <Widget>[_buildNoteList()],
      ));

  //TODO: fix scroll view
  Widget _buildNoteList() => StreamBuilder<List<NoteModel>>(
      stream: bloc.noteListStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
        return ListView.separated(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final NoteModel note = snapshot.data![index];

              return MaterialCardNoteView(
                noteModel: note,
                onClicked: () => bloc.onNoteTapped(note),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 2));
      });
}
