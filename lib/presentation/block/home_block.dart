import 'dart:async';

import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/data/network/api_components.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_use_case.dart';
import 'package:todo_sandbox/presentation/block/base_block.dart';
import 'package:todo_sandbox/presentation/di/di.dart';

class HomeBlock extends BaseBlock {
  final GetAllNotesUseCase getAllNotesUseCase;

  HomeBlock(this.getAllNotesUseCase);

  Future<void> onNoteTapped(NoteModel noteModel) async {


  }

  Future<void> fetchNotes()async{
    final DataState<List<NoteModel>> result = await getAllNotesUseCase();
  }

  void dispose() {
    super.dispose();
    _notesListSc.close();
  }

  final _notesListSc = StreamController<List<NoteModel>>();

  Stream<List<NoteModel>> get noteListStream => _notesListSc.stream;
}
