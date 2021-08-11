import 'package:hive/hive.dart';
import 'package:todo_sandbox/core/model/note_model.dart';
import 'package:todo_sandbox/data/provider/base_provider.dart';
import 'package:todo_sandbox/core/model/dbo/note_dbo.dart';

class HiveBoxName {
  static const note = 'note_box';
}

class NoteLocalDataProvider extends DataProvider {
  final Box<NoteDbo> _box;

  NoteLocalDataProvider(this._box);

  Future<List<NoteModel>> getAllNotes() async {
    return noteStorage.values
        .toList()
        .map((noteDbo) => noteDbo.toNoteModel())
        .toList();
  }

  Future<int> insertNote(NoteModel noteModel) async {
    return await noteStorage.add(noteModel.toNoteDbo());
  }

  Future<NoteModel?> getNoteById(int noteId) async {
    return noteStorage.get(noteId)?.toNoteModel();
  }

  Box<NoteDbo> get noteStorage => _box;
}
