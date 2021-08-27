import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/usecase/use_case.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/domain/entities/note_request_params.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';

class GetAllNotesUseCase implements UseCase<DataState<List<NoteModel>>, NoteRequestParams> {
  final NoteRepository _noteRepository;

  GetAllNotesUseCase(this._noteRepository);

  @override
  Future<DataState<List<NoteModel>>> call({NoteRequestParams? params}) {
    return _noteRepository.getAllNotes(params);
  }
}
