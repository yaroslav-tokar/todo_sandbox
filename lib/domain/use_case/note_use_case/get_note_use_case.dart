import 'package:todo_sandbox/core/exception/exceptions.dart';
import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/usecase/use_case.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/entities/note_request_params.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';

class GetNoteByIdUseCase extends UseCase<DataState<NoteModel>, NoteRequestParams> {
  final NoteRepository _noteRepository;

  GetNoteByIdUseCase(this._noteRepository);

  @override
  Future<DataState<NoteModel>> call({NoteRequestParams? params}) async {
    final NoteModel? searchedNote = await _noteRepository.getNoteById(
      NoteRequestParams(id: params?.id),
    );

    if (searchedNote != null) {
      return DataStateSuccess<NoteModel>(searchedNote);
    }

    return DataStateFailed(
        AppError(errorType: ErrorType.local, error: EntityNotFoundException()));
  }
}
