abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class GetAllNotesSuccessState extends NotesStates {}

class GetAllNotesErrorState extends NotesStates {
  final String message;
  GetAllNotesErrorState(this.message);
}

class DeleteNoteLoadingState extends NotesStates {}

class DeleteNoteSuccessState extends NotesStates {}

class DeleteNoteErrorState extends NotesStates {}

class ChangeNoteState extends NotesStates {}

class UpdateNoteState extends NotesStates {}

class DeleteAllNotesState extends NotesStates {}
