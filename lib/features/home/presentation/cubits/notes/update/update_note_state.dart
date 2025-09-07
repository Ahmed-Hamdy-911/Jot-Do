abstract class UpdateNoteStates {}

class UpdateNoteInitialState extends UpdateNoteStates {}

class UpdateNoteLoadingState extends UpdateNoteStates {}

class UpdateNoteSuccessState extends UpdateNoteStates {}

class UpdateNoteErrorState extends UpdateNoteStates {
  final String errorMessage;
  UpdateNoteErrorState(this.errorMessage);
}
