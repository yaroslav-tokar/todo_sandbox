import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/core/model/note_model.dart';
import 'package:todo_sandbox/screens/base/base_state.dart';
import 'package:todo_sandbox/state/base_screen.dart';
import 'package:todo_sandbox/screens/home/note_view.dart';
import 'package:todo_sandbox/view_model.dart';

@immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStateWithModel<HomeModel, HomeScreen> {
  @override
  void initState() {
    super.initState();
    statefulModel.fetchNotes();
  }

  @override
  Widget build(BuildContext context) => BaseScreenView<HomeModel>(
      hasBackBtn: false,
      block: statefulModel,
      screenViewState: ScreenViewState.ready,
      hasToolbar: true,
      content: buildBody()!,
      title: 'Notes');

  @override
  Widget? buildBody() => Column(children: [_buildNoteList()]);

  Widget _buildNoteList() => StreamBuilder<List<NoteModel>>(
      stream: statefulModel.noteListStream,
      initialData: [],
      builder: (context, model) {
        return ListView.separated(
            shrinkWrap: true,
            itemCount: model.data!.length,
            itemBuilder: (context, index) => NoteView(
                  model: model.data![index],
                  onClicked: () =>
                      statefulModel.onItemCLicked(model.data![index]),
                ),
            separatorBuilder: (context, index) => Container(height: 24));
      });
}
