import 'package:equatable/equatable.dart';
import 'package:todo_sandbox/data/models/note_model.dart';
import 'package:todo_sandbox/data/models/note_open_mode.dart';
import 'package:todo_sandbox/presentation/arguments/screen_arguments.dart';

class NoteDetailsArgument extends ScreenArguments with EquatableMixin {
  final NoteOpenMode mode;
  NoteModel? noteModel;

  NoteDetailsArgument({
    required this.mode,
    this.noteModel,
  });

  @override
  List<Object?> get props => <Object?>[mode, noteModel];

  @override
  bool get stringify => true;
}
