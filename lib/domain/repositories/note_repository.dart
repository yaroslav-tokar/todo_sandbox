import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/data/enums.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/entities/note_request_params.dart';

abstract class NoteRepository {
  Future<DataState<List<NoteModel>>> getAllNotes(NoteRequestParams? noteRequestParams);

  Stream<List<NoteModel>> getAllNotesAsStream(NoteRequestParams? noteRequestParams);

  Future<NoteModel?> getNoteById(NoteRequestParams? noteRequestParams);

  Future<int> createNote(NoteModel noteModel);

  Future<int> updateNote(NoteModel noteModel);

  Future<int?> deleteNoteById(int noteId);
}
