enum NoteOpenMode { create, update }

extension NoteOpenModeEx on NoteOpenMode {
  bool get isCrateMode => this == NoteOpenMode.create;
}
