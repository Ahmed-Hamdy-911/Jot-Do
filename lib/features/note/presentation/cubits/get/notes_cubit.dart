import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../data/models/note_model.dart';
import '../../../data/repository/smart_note_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  final _smartNoteRepository = SmartNoteRepository();
  List<NoteModel> notesList = [];

  Future<void> getNotes([String? filterId]) async {
    final safeFilter = filterId ?? "all";
    if ((safeFilter == "all") && notesList.isEmpty) {
      emit(NotesLoadingState());
    }
    try {
      notesList = await _smartNoteRepository.getNotes(safeFilter);
      emit(GetAllNotesSuccessState());
    } catch (e) {
      log(e.toString());
      emit(GetAllNotesErrorState(e.toString()));
    }
  }

  void togglePinNote(String id, NoteModel noteModel) async {
    try {
      final updatedNote = noteModel.copyWith(isPinned: !noteModel.isPinned);
      await _smartNoteRepository.updateNote(id, updatedNote);

      final index = notesList.indexWhere((n) => n.id == id);
      if (index != -1) {
        notesList[index] = updatedNote;
      }
      await getNotes("all");
      emit(ToggleNoteActionsPinSuccessState(isPinned: updatedNote.isPinned));
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }

  void toggleFavoriteNote(String id, NoteModel noteModel) async {
    try {
      final updatedNote = noteModel.copyWith(isFavorite: !noteModel.isFavorite);
      await _smartNoteRepository.updateNote(id, updatedNote);

      final index = notesList.indexWhere((n) => n.id == id);
      // return true if found else return false
      if (index != -1) {
        notesList[index] = updatedNote;
      }
      await getNotes("all");
      emit(ToggleNoteFavoriteSuccessState(isFavorite: updatedNote.isFavorite));
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }

  void toggleArchiveNote(String id, NoteModel noteModel) async {
    try {
      final updatedNote = noteModel.copyWith(isArchived: !noteModel.isArchived);
      await _smartNoteRepository.updateNote(id, updatedNote);

      final index = notesList.indexWhere((n) => n.id == id);
      if (index != -1) {
        notesList[index] = updatedNote;
      }
      await getNotes("all");
      emit(ToggleNoteActionsArchiveSuccessState(
          isArchived: updatedNote.isArchived));
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }

  void deleteNote(
    String id,
  ) async {
    try {
      await _smartNoteRepository.deleteNote(id);

      notesList.removeWhere((n) => n.id == id);
      await getNotes("all");
      emit(NoteActionsDeleteSuccessState());
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }
}
