import 'dart:async';

import 'package:todo_sandbox/data/datasource/local/dao/note_dao.dart';
import 'package:todo_sandbox/data/datasource/local/dbo/note_dbo.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/entities/note_request_params.dart';
import 'package:todo_sandbox/domain/provider/base_provider.dart';
import 'package:todo_sandbox/data/datasource/local/db/app_db.dart';

class NoteLocalDataProvider extends DataProvider {
  final AppDatabase _appDatabase;

  NoteLocalDataProvider(this._appDatabase);

  NoteDao get _noteDao => _appDatabase.noteDao;

  Future<int> createNote(NoteModel noteModel) async {
    final int newNoteId = await _noteDao.insertItem(noteModel.toNoteDbo());
    return newNoteId;
  }

  Future<int?> deleteNoteById(int noteId) async {
    final deletedNoteId = await _noteDao.deleteNoteById(noteId);
    return deletedNoteId;
  }

  Future<List<NoteModel>> getAllNotes(
    NoteRequestParams? noteRequestParams,
  ) async {
    final notesList = await _noteDao.findAllNotes();
    return notesList.map((NoteDbo noteDbo) => noteDbo.toNoteModel()).toList();
  }

  Stream<List<NoteModel>> getAllNotesAsStream(
    NoteRequestParams? noteRequestParams,
  ) {
    return _noteDao.findAllAllNotesAsStream().map(
          (List<NoteDbo> noteDboList) => NoteModel.fromList(noteDboList),
        );
  }

  Future<NoteModel?> getNoteById(int noteId) async {
    final NoteDbo? searchedNote = await _noteDao.findNoteById(noteId);
    return searchedNote?.toNoteModel();
  }

  Future<int> updateNote(NoteModel noteModel) async {
    final int updatedNoteId = await _noteDao.updateItem(noteModel.toNoteDbo());
    return updatedNoteId;
  }
}

class NoteRemoteDataProvider extends DataProvider {}
