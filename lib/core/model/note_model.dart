import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/core/model/base_note.dart';
import 'package:todo_sandbox/core/model/dbo/note_dbo.dart';

class NoteModel extends BaseNote {
  NoteCategory? category;

  NoteModel({this.category, id, title, content}) : super(id, title, content);

  NoteDbo toNoteDbo() => NoteDbo(
        id: id,
        category: category,
        title: title,
        content: content,
      );

  @override
  String toString() => '[category: $category, '
      'id: $id, '
      'title: $title, '
      'content: $content]';
}
