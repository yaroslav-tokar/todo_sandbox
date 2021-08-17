import 'package:flutter/material.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/presentation/block/home_block.dart';
import 'package:todo_sandbox/presentation/custom_view/note_view.dart';
import 'package:todo_sandbox/presentation/screens/base/base_screen.dart';
import 'package:todo_sandbox/presentation/screens/base/base_state.dart';

@immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStateWithModel<HomeBlock, HomeScreen> {
  @override
  void initState() {
    super.initState();
    statefulModel.fetchNotes();
  }

  @override
  Widget build(BuildContext context) => BaseScreenView<HomeBlock>(
      hasBackBtn: false,
      block: statefulModel,
      hasToolbar: true,
      onFloatingActionButtonTapped: statefulModel.onFloatingActionButtonClicked,
      content: buildBody()!,
      title: 'Notes');

  @override
  Widget? buildBody() => Column(children: <Widget>[_buildNoteList()]);

  Widget _buildNoteList() => StreamBuilder<List<NoteModel>>(
      stream: statefulModel.noteListStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
        return ListView.separated(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) => NoteView(
                  model: snapshot.data![index],
                  onClicked: () =>
                      statefulModel.onNoteTapped(snapshot.data![index]),
                ),
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 24));
      });
}
