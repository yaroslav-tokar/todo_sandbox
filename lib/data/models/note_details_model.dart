import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/domain/provider/note_local_data_provider.dart';
import 'package:todo_sandbox/presentation/arguments/note_details_arguments.dart';
import 'package:todo_sandbox/presentation/block/base_block.dart';

class NoteDetailsBloc extends BaseBlock<NoteDetailsArgument> {
  final TextEditingController _titleEtc = TextEditingController();
  final TextEditingController _contentEtc = TextEditingController();

  final NoteLocalDataProvider _localDataProvider;

  NoteDetailsBloc(this._localDataProvider);

  Future<void> onSubmitButtonTapped() async {
    final String title = _titleEtc.text;
    final String content = _titleEtc.text;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void attachArguments({NoteDetailsArgument? args}) {
    logInfo('NoteDetails args\t$args');
  }
}
