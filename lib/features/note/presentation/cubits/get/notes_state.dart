import '../../../../home/data/models/note_model.dart';

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

class ToggleNoteFavoriteSuccessState extends NotesStates {
  bool? isFavorite;
  ToggleNoteFavoriteSuccessState({this.isFavorite});
}

class NoteActionsDeleteSuccessState extends NotesStates {}

class ToggleNoteActionsPinSuccessState extends NotesStates {
  bool? isPinned;
  ToggleNoteActionsPinSuccessState({this.isPinned});
}

class ToggleNoteActionsArchiveSuccessState extends NotesStates {
  bool? isArchived;
  ToggleNoteActionsArchiveSuccessState({this.isArchived});
}

class NoteSelectionState extends NotesStates {
  final bool isSelectionMode;
  final List<NoteModel> selectedNotes;

  NoteSelectionState({
    this.isSelectionMode = false,
    this.selectedNotes = const [],
  });

  NoteSelectionState copyWith({
    bool? isSelectionMode,
    List<NoteModel>? selectedNotes,
  }) {
    return NoteSelectionState(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedNotes: selectedNotes ?? this.selectedNotes,
    );
  }
}
