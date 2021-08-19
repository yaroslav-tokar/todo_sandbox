import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/data/models/note_open_mode.dart';
import 'package:todo_sandbox/domain/provider/note_local_data_provider.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_bloc_with_arguments.dart';

class NoteDetailsBloc extends BaseBlocWithArguments<NoteDetailsArgument> {
  final TextEditingController titleEtc = TextEditingController();
  final TextEditingController contentEtc = TextEditingController();

  final NoteLocalDataProvider _localDataProvider;

  NoteDetailsBloc(this._localDataProvider);

  Future<void> initTextFields() async {
    titleEtc.text = 'title';
    contentEtc.text = 'Content';
  }

  Future<void> onSubmitButtonTapped() async {
    final String title = titleEtc.text;
    final String content = contentEtc.text;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void attachArguments({NoteDetailsArgument? args}) {
    arguments = args;

    if (arguments != null) {
      updateToolbarTitle(
          arguments!.mode.isCrateMode ? 'Create new note' : 'Note details');
    }
  }
}
