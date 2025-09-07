import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../../data/models/note_model.dart';
import '../../../../data/repository/smart_note_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  final _smartNoteRepository = SmartNoteRepository();
  List<NoteModel> notesList = [];

  Future<void> getNotes([int index = 0]) async {
    emit(NotesLoadingState());
    try {
      notesList = await _smartNoteRepository.getNotes(index);
      emit(GetAllNotesSuccessState());
    } on Exception catch (e) {
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

      emit(ToggleNoteActionsPinSuccessState());
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

      emit(ToggleNoteFavoriteSuccessState());
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

      emit(ToggleNoteActionsArchiveSuccessState());
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }

  void deleteNote(String id, NoteModel noteModel) async {
    try {
      await _smartNoteRepository.deleteNote(id, noteModel);

      notesList.removeWhere((n) => n.id == id);

      emit(NoteActionsDeleteSuccessState());
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }
}
