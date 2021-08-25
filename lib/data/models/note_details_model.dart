import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/data/models/note_open_mode.dart';
import 'package:todo_sandbox/data/models/toolbar_settings.dart';
import 'package:todo_sandbox/domain/entities/note_request_params.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/create_note_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_note_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/update_note_use_case.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_bloc_with_arguments.dart';

class NoteDetailsBloc extends BaseBlocWithArguments<NoteDetailsArgument> {
  final TextEditingController titleEtc = TextEditingController();
  final TextEditingController contentEtc = TextEditingController();

  final CreateNoteUseCase _createNoteUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final GetNoteByIdUseCase _getNoteByIdUseCase;

  NoteDetailsBloc(
    this._createNoteUseCase,
    this._updateNoteUseCase,
    this._getNoteByIdUseCase,
  );

  Future<void> initTextFields() async {
    titleEtc.text = 'title';
    contentEtc.text = 'Content';
  }

  @override
  Future<void> onBackButtonPressed() async {
    final NoteOpenMode noteOpenMode = arguments!.mode;

    final String noteTitle = titleEtc.text;
    final String noteContent = contentEtc.text;

    if (noteTitle.isEmpty && noteContent.isEmpty) return;

    switch (noteOpenMode) {
      case NoteOpenMode.create:
        handleCrateNoteCase(noteTitle, noteContent);
        break;
      case NoteOpenMode.update:
        handleUpdateNoteCase(noteTitle, noteContent);
        break;
    }
  }

  Future<void> handleCrateNoteCase(String noteTitle, String noteContent) async {
    final NoteModel noteModel = NoteModel(
      category: 'common',
      title: noteTitle,
      content: noteContent,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _createNoteUseCase(params: noteModel);
  }

  Future<void> handleUpdateNoteCase(
      String noteTitle, String noteContent) async {
    final DataState<NoteModel> searchedNote = await _getNoteByIdUseCase.call(
      params: NoteRequestParams(id: currentNoteIdOrNull),
    );

    if (currentNoteIdOrNull != null) {
      if (searchedNote is DataStateSuccess) {
        final NoteModel noteModel = NoteModel(
            id: currentNoteIdOrNull,
            category: 'common',
            title: noteTitle,
            content: noteContent,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            updatedAt: DateTime.now().millisecondsSinceEpoch);

        _updateNoteUseCase(params: noteModel);
      }

      if (searchedNote is DataStateFailed) {
        logInfo('Error, can find note with id\t$currentNoteIdOrNull');
      }
    } else {
      handleCrateNoteCase(noteTitle, noteContent);
    }
  }

  @override
  void attachArguments({NoteDetailsArgument? args}) {
    arguments = args;

    if (arguments != null) checkModeAndReact(arguments?.noteModel);
  }

  Future<void> checkModeAndReact(NoteModel? noteModel) async {
    if (isUpdateMode) {
      titleEtc.text = noteModel!.title;
      contentEtc.text = noteModel.content;

      if (noteModel.hasFilledTitle) {
        final String title = arguments!.mode.isCrateMode
            ? 'Create new note'
            : arguments?.noteModel?.title ?? '';

        saveToolbarStateAndUpdate(
            ToolbarSettings(title: title, hasBackButton: true));
      }
    }
  }

  bool get isUpdateMode =>
      arguments?.noteModel != null && currentNoteIdOrNull != null;

  int? get currentNoteIdOrNull => arguments?.noteModel?.id;

  @override
  void dispose() {
    super.dispose();
  }
}
