import 'dart:async';

import 'package:todo_sandbox/core/api_components.dart';
import 'package:todo_sandbox/core/model/note_model.dart';
import 'package:todo_sandbox/data/provider/repository/note_repository.dart';
import 'package:todo_sandbox/data/provider/repository/note_repository_impl.dart';
import 'package:todo_sandbox/di/di.dart';
import 'package:todo_sandbox/stateful_model/base_model.dart';
import 'package:todo_sandbox/util/logger.dart';

class HomeModel extends BaseBlock {
  NoteRepository get _noteRepository => locator<NoteRepositoryImpl>();
  final _notesListSc = StreamController<List<NoteModel>>();

  void onItemCLicked(NoteModel noteModel) async {

  }

  void fetchNotes() async => consumeSimpleCall<List<NoteModel>>(
        call: _noteRepository.findAllNotes(),
        onError: (ResponseError errorMessage) {
          Logger.i('Error');
        },
        onSuccess: (List<NoteModel>? data) async {
          Logger.i('${data?.join('a')}');
          if (data != null) _notesListSc.add(data);
        },
      );

  void dispose() {
    super.dispose();
    _notesListSc.close();
  }

  Stream<List<NoteModel>> get noteListStream => _notesListSc.stream;
}
