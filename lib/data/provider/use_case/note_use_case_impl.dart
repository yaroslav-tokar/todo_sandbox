import 'package:todo_sandbox/core/api_components.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/core/model/note_model.dart';
import 'package:todo_sandbox/data/provider/repository/note_repository.dart';
import 'package:todo_sandbox/data/provider/use_case/note_use_case.dart';

class NoteUseCaseImpl extends NoteUseCase {
  final NoteRepository noteRepository;

  NoteUseCaseImpl(this.noteRepository);

  @override
  Future<Result<List<NoteModel>>> findAllNotes() {
    // TODO: implement findAllNotes
    throw UnimplementedError();
  }

  @override
  Future<Result<NoteModel>> findNoteByCategory(NoteCategory noteCategory) {
    // TODO: implement findNoteByCategory
    throw UnimplementedError();
  }

  @override
  Future<Result<NoteModel>> findNoteById(int noteId) {
    // TODO: implement findNoteById
    throw UnimplementedError();
  }

  @override
  Future<Result<NoteModel>> findNoteByName(String noteName) {
    // TODO: implement findNoteByName
    throw UnimplementedError();
  }
}
