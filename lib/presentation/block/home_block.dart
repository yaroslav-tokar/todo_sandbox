import 'dart:async';

import 'package:todo_sandbox/config/navigation/navigation.dart';
import 'package:todo_sandbox/config/route/router.dart';
import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/data/models/note_open_mode.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_steram_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_use_case.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';

class HomeBlock extends BaseBloc {
  HomeBlock(this._getAllNotesUseCase, this._getAllNotesStreamUseCase);

  final GetAllNotesUseCase _getAllNotesUseCase;
  final GetAllNotesStreamUseCase _getAllNotesStreamUseCase;

  Future<void> onNoteTapped(NoteModel noteModel) async {
    Navigation.I.pushNamed(AppRoute.noteDetails,
        args: NoteDetailsArgument(
          mode: NoteOpenMode.update,
          noteModel: noteModel,
        ));
  }

  Future<void> onFloatingActionButtonClicked() async =>
      Navigation.I.pushNamed(AppRoute.noteDetails,
          args: NoteDetailsArgument(
            mode: NoteOpenMode.create,
          ));

  Stream<List<NoteModel>> get notesStream => _getAllNotesStreamUseCase();
}
