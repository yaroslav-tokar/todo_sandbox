import 'package:todo_sandbox/core/usecase/use_case.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';


class CreateNoteUseCase extends UseCase<int, NoteModel> {
  final NoteRepository _noteRepository;

  CreateNoteUseCase(this._noteRepository);

  @override
  Future<int> call({NoteModel? params}) async =>
      _noteRepository.createNote(params!);
}
