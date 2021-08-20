import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_sandbox/core/util/logger.dart';
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
  Widget build(BuildContext context) => BaseScreenView<HomeBlock>(
      bloc: bloc,
      hasToolbar: true,
      onFloatingActionButtonTapped: bloc.onFloatingActionButtonClicked,
      content: buildBody,
      title: 'Notes');

  @override
  Widget get buildBody => Column(
        children: <Widget>[Expanded(child: _buildNoteList())],
      );

  Widget _buildNoteList() => StreamBuilder<List<NoteModel>>(
      stream: bloc.notesStream,
      initialData: [],
      builder: (BuildContext context,
              AsyncSnapshot<List<NoteModel>> snapshot) =>
          StaggeredGridView.countBuilder(
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int index) =>
                  NoteView(
                      model: snapshot.data![index],
                      onClicked: () => bloc.onNoteTapped(
                            snapshot.data![index],
                          )),
              itemCount: snapshot.data!.length,
              crossAxisCount: 2));
}
