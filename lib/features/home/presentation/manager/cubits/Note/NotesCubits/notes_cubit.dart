import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../../../data/models/note_model.dart';
import '../../../../../data/repository/smart_note_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  final smartNoteRepository = SmartNoteRepository();
  List<NoteModel>? notesList;

  Future<void> getNotes([int index = 0]) async {
    emit(NotesLoadingState());
    try {
      notesList = await smartNoteRepository.getNotes(index);
      // for (var note in notesList!) {
      //   print(
      //       "Note:${note.id}, ${note.title}, ${note.content}, ${note.createdAt}");
      // }
      emit(GetAllNotesSuccessState());
    } on Exception catch (e) {
      log(e.toString());
      emit(GetAllNotesErrorState(e.toString()));
    }
  }

  void togglePinNote(String id, NoteModel noteModel) async {
    emit(NotesLoadingState());
    try {
      noteModel.isPinned = !noteModel.isPinned;
      smartNoteRepository.updateNote(id, noteModel);
      print(noteModel.isPinned);
      emit(ToggleNoteActionsPinSuccessState());
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }

  void toggleFavoriteNote(String id, NoteModel noteModel) async {
    try {
      noteModel.isFavorite = !noteModel.isFavorite;
      smartNoteRepository.updateNote(id, noteModel);
      emit(ToggleNoteFavoriteSuccessState());
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }

  void toggleArchiveNote(String id, NoteModel noteModel) async {
    try {
      noteModel.isArchived = !noteModel.isArchived;
      smartNoteRepository.updateNote(id, noteModel);
      emit(ToggleNoteActionsArchiveSuccessState());
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }

  void deleteNote(String id, NoteModel noteModel) async {
    try {
      await smartNoteRepository.deleteNote(id, noteModel);
      emit(NoteActionsDeleteSuccessState());
    } on Exception catch (e) {
      emit(NoteActionsErrorState(e.toString()));
    }
  }
}
