import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/config/navigation/navigation.dart';
import 'package:todo_sandbox/config/route/router.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/data/models/note_open_mode.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_steram_use_case.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';

class HomeBlock extends BaseBloc {
  HomeBlock(this._getAllNotesStreamUseCase);

  final List<NoteModel> _selectedNoteList = <NoteModel>[];

  final GetAllNotesStreamUseCase _getAllNotesStreamUseCase;

  Future<void> onNoteLongPressed(NoteModel noteModel) async {
    logInfo('OnLongPressHappen');
    if (!_selectedNoteList.contains(noteModel)) {
      _selectedNoteList.add(noteModel);
    } else {
      _selectedNoteList.remove(noteModel);
    }
  }

  Future<void> handleToolbarState() async {
    final currentToolbarSettingsState = toolbarCurrentSettings;

    updateToolbarSettings(currentToolbarSettingsState);
  }

  Future<void> onNoteTapped(NoteModel noteModel) async {
    logInfo('size\t${_selectedNoteList.length}');
    if (canNavigateToNoteDetails) {
      Navigation.I.pushNamed(AppRoute.noteDetails,
          args: NoteDetailsArgument(
            mode: NoteOpenMode.update,
            noteModel: noteModel,
          ));
    }
  }

  Future<void> onFloatingActionButtonClicked() async =>
      Navigation.I.pushNamed(AppRoute.noteDetails,
          args: NoteDetailsArgument(
            mode: NoteOpenMode.create,
          ));

  Stream<List<NoteModel>> get notesStream => _getAllNotesStreamUseCase();

  bool get canNavigateToNoteDetails => _selectedNoteList.isEmpty;
}
