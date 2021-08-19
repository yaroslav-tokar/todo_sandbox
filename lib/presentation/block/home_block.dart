import 'dart:async';

import 'package:todo_sandbox/config/navigation/navigation.dart';
import 'package:todo_sandbox/config/route/router.dart';
import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/data/models/note_open_mode.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_use_case.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';

class HomeBlock extends BaseBloc {
  HomeBlock(this._getAllNotesUseCase);

  final GetAllNotesUseCase _getAllNotesUseCase;

  final _notesListSc = StreamController<List<NoteModel>>();

  Future<void> onNoteTapped(NoteModel noteModel) async {
    Navigation.I.pushNamed(AppRoute.noteDetails,
        args: NoteDetailsArgument(
          mode: NoteOpenMode.update,
          noteModel: noteModel,
        ));
  }

  Future<void> fetchNotes() async {
    logInfo('Start requesting data');

    final DataState<List<NoteModel>> result = await _getAllNotesUseCase();

    if (result is DataStateSuccess) {
      _notesListSc.add(result.data!);
    } else if (result is DataStateFailed) {
      logInfo('Something went wrong\t${result.error?.error.toString()}');
    }
  }

  Future<void> onFloatingActionButtonClicked() async =>
      Navigation.I.pushNamed(AppRoute.noteDetails,
          args: NoteDetailsArgument(
            mode: NoteOpenMode.create,
          ));

  @override
  void dispose() {
    super.dispose();
    _notesListSc.close();
  }

  Stream<List<NoteModel>> get noteListStream => _notesListSc.stream;
}
