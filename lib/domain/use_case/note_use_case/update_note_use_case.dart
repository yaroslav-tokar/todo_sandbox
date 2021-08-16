import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/usecase/use_case.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';

class UpdateNoteUseCase extends UseCase<int, NoteModel> {
  final NoteRepository _noteRepository;

  UpdateNoteUseCase(this._noteRepository);

  @override
  Future<int> call({NoteModel? params}) async =>
      _noteRepository.updateNote(params!);
}
