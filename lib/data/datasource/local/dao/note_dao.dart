import 'package:floor/floor.dart';
import 'package:todo_sandbox/core/dao/base_dao.dart';
import 'package:todo_sandbox/data/datasource/local/dbo/note_dbo.dart';

@dao
abstract class NoteDao extends BaseDao<NoteDbo> {
  @Query('SELECT * FROM notes')
  Future<List<NoteDbo>> findAllNotes();

  @Query('SELECT * FROM notes WHERE id = :noteId')
  Future<NoteDbo?> findNoteById(int noteId);

  @Query('DELETE FROM notes WHERE id = :noteId')
  Future<int?> deleteNoteById(int noteId);
}
