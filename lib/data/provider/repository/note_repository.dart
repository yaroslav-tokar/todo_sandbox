import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/core/api_components.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/core/model/note_model.dart';
import 'package:todo_sandbox/data/provider/base_provider.dart';

abstract class NoteRepository<T extends DataProvider> {
  @protected
  T get dataProvider;

  Future<Result<List<NoteModel>>> findAllNotes();

  Future<Result<NoteModel>> findNoteById(int noteId);

  Future<Result<NoteModel>> findNoteByCategory(NoteCategory noteCategory);

  Future<Result<NoteModel>> findNoteByName(String noteName);
}
