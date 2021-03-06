import 'package:todo_sandbox/data/datasource/local/dbo/note_dbo.dart';
import 'package:todo_sandbox/data/models/base_note.dart';

class NoteModel extends BaseNote {
  final String category;

  const NoteModel({
    required this.category,
    required String title,
    int? id,
    required String content,
    required int createdAt,
    required int updatedAt,
  }) : super(
          id: id,
          title: title,
          content: content,
          createAt: createdAt,
          updateAt: updatedAt,
        );

  bool get hasFilledTitle => title.isNotEmpty;

  bool get hasFilledContent => content.isNotEmpty;

  static List<NoteModel> fromList(List<NoteDbo> noteDboList) =>
      noteDboList.map((NoteDbo noteDbo) => noteDbo.toNoteModel()).toList();

  NoteDbo toNoteDbo() => NoteDbo(
      id: id,
      category: category,
      title: title,
      content: content,
      createAt: createAt,
      updateAt: updateAt);

  @override
  String toString() => '[category: $category, '
      'id: $id, '
      'title: $title, '
      'content: $content]';
}
