import 'package:todo_sandbox/data/provider/repository/note_repository.dart';
import 'package:todo_sandbox/stateful_model/base_stateful_model.dart';

class NoteStatefulModel extends BaseStatefulModel {
  final NoteRepository noteRepository;

  NoteStatefulModel(this.noteRepository);

  void createNote() async {}

  void updateNote() async {}
}
