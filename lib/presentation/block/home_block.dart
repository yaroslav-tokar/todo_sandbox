import 'dart:async';

import 'package:todo_sandbox/config/navigation/navigation.dart';
import 'package:todo_sandbox/config/route/router.dart';
import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/data/models/note_open_mode.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_use_case.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/arguments/screen_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';

class HomeBlock extends BaseBloc {
  final GetAllNotesUseCase getAllNotesUseCase;

  HomeBlock(this.getAllNotesUseCase);

  Future<void> onNoteTapped(NoteModel noteModel) async {}

  Future<void> fetchNotes() async {
    final DataState<List<NoteModel>> result = await getAllNotesUseCase();
  }

  void dispose() {
    super.dispose();
    _notesListSc.close();
  }

  final _notesListSc = StreamController<List<NoteModel>>();

  Stream<List<NoteModel>> get noteListStream => _notesListSc.stream;

  Future<void> onFloatingActionButtonClicked() async {
    logInfo('On floating action button clicked');
    Navigation.I.pushNamed(AppRoute.noteDetails,
        args: NoteDetailsArgument(
          mode: NoteOpenMode.create,
        ));
  }

  @override
  void attachArguments({ScreenArguments? args}) {}
}
