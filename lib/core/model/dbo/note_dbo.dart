import 'package:hive/hive.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/core/model/base_note.dart';
import 'package:todo_sandbox/core/model/note_model.dart';

part 'note_dbo.g.dart';

@HiveType(typeId: 0)
class NoteDbo extends BaseNote {
  @HiveField(0)
  NoteCategory? category;

  NoteDbo({this.category, id, title, content}) : super(id, title, content);

  NoteModel toNoteModel() => NoteModel(
        id: id,
        category: category,
        title: title,
        content: content,
      );
}
