import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/entities/note_request_params.dart';
import 'package:todo_sandbox/domain/provider/note_local_data_provider.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final NoteLocalDataProvider _localDataProvider;
  final NoteRemoteDataProvider _remoteDataProvider;

  NoteRepositoryImpl(this._localDataProvider, this._remoteDataProvider);

  @override
  Future<int> createNote(NoteModel? noteModel) async {
    final newNoteId = await _localDataProvider.createNote(noteModel!);
    return newNoteId;
  }

  @override
  Future<int?> deleteNoteById(int noteId) async {
    final deletedNoteId = await _localDataProvider.deleteNoteById(noteId);
    return deletedNoteId;
  }

  @override
  Future<DataState<List<NoteModel>>> getAllNotes(
      NoteRequestParams? noteRequestParams) async {
    final notesList = await _localDataProvider.getAllNotes(noteRequestParams);
    return DataStateSuccess<List<NoteModel>>(notesList);
  }

  @override
  Future<int> updateNote(NoteModel noteModel) async {
    final updatedNoteId = await _localDataProvider.updateNote(noteModel);
    return updatedNoteId;
  }

  @override
  Future<NoteModel?> getNoteById(NoteRequestParams? noteRequestParams) async {
    final NoteModel? searchedNote = await _localDataProvider.getNoteById(
      noteRequestParams!.id!,
    );

    return searchedNote;
  }
}
