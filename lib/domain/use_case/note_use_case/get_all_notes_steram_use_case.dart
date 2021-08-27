import 'package:todo_sandbox/core/usecase/use_case.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/entities/note_request_params.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';

class GetAllNotesStreamUseCase
    extends StreamableUseCase<List<NoteModel>, NoteRequestParams> {
  final NoteRepository _repository;

  GetAllNotesStreamUseCase(this._repository);

  @override
  Stream<List<NoteModel>> call({NoteRequestParams? params}) =>
      _repository.getAllNotesAsStream(params);
}
