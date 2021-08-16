import 'package:floor/floor.dart';
import 'package:todo_sandbox/data/models/base_note.dart';
import 'package:todo_sandbox/data/models/note_model.dart';

@Entity(tableName: 'notes')
class NoteDbo extends BaseNote {
  @ColumnInfo(name: 'category')
  final String category;

  const NoteDbo({
    required this.category,
    required int id,
    required String title,
    required String content,
    required int createAt,
    required int updateAt,
  }) : super(
          updateAt: updateAt,
          createAt: createAt,
          id: id,
          content: content,
          title: title,
        );

  NoteModel toNoteModel() => NoteModel(
        id: id,
        category: category,
        title: title,
        content: content,
        createdAt: createAt,
        updatedAt: updateAt,
      );
}
