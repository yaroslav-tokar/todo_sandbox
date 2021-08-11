import 'package:todo_sandbox/core/api_components.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/core/model/note_model.dart';
import 'package:todo_sandbox/data/provider/base_provider.dart';
import 'package:todo_sandbox/data/provider/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  NoteRepositoryImpl(DataProvider dataProvider);

  @override
  DataProvider get dataProvider => dataProvider;

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
