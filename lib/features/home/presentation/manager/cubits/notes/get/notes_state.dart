abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class GetAllNotesSuccessState extends NotesStates {}

class GetAllNotesErrorState extends NotesStates {
  final String message;
  GetAllNotesErrorState(this.message);
}

class NoteActionsErrorState extends NotesStates {
  final String error;
  NoteActionsErrorState(this.error);
}

class ToggleNoteFavoriteSuccessState extends NotesStates {}

class NoteActionsDeleteSuccessState extends NotesStates {}

class ToggleNoteActionsPinSuccessState extends NotesStates {}

class ToggleNoteActionsArchiveSuccessState extends NotesStates {}
