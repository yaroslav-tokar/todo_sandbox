import 'package:flutter/material.dart';
import 'package:todo_sandbox/data/enums.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/presentation/block/home_block.dart';
import 'package:todo_sandbox/presentation/screens/base/base_screen.dart';
import 'package:todo_sandbox/presentation/screens/base/base_state.dart';
import 'package:todo_sandbox/presentation/screens/home/note_view.dart';

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
      content: buildBody()!,
      title: 'Notes');

  @override
  Widget? buildBody() => Column(children: [_buildNoteList()]);

  Widget _buildNoteList() => StreamBuilder<List<NoteModel>>(
      stream: statefulModel.noteListStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
        return ListView.separated(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => NoteView(
                  model: snapshot.data![index],
                  onClicked: () =>
                      statefulModel.onNoteTapped(snapshot.data![index]),
                ),
            separatorBuilder: (context, index) => Container(height: 24));
      });
}
