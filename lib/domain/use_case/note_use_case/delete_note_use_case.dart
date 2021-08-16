import 'package:todo_sandbox/core/usecase/use_case.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';

class DeleteNoteUseCase extends UseCase<int?, int> {
  final NoteRepository _noteRepository;

  DeleteNoteUseCase(this._noteRepository);

  @override
  Future<int?> call({int? params}) async =>
      _noteRepository.deleteNoteById(params!);
}
