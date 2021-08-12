import 'package:flutter/foundation.dart';
import 'package:todo_sandbox/core/api_components.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/core/model/note_model.dart';
import 'package:todo_sandbox/data/provider/base_provider.dart';
import 'package:todo_sandbox/data/provider/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  NoteRepositoryImpl(DataProvider dataProvider);

  final List<NoteModel> mockNotes = List.generate(
      5,
      (index) => NoteModel(
            category: NoteCategory.learning,
            content: 'Some $index',
            title: 'Title $index',
            id: 100001 + index,
          )).toList();

  @override
  DataProvider get dataProvider => dataProvider;

  @override
  Future<Result<List<NoteModel>>> findAllNotes() async => Result(
        isSuccess: true,
        data: mockNotes,
        error: ResponseError(Object(), 'aaa'),
      );

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
