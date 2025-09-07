import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../../../../data/models/note_model.dart';
import '../../../../data/repository/smart_note_repository.dart';
import 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteStates> {
  AddNoteCubit() : super(AddNoteInitialState());
  final smartNoteRepository = SmartNoteRepository();

  void addNote(NoteModel noteModel) async {
    emit(AddNoteLoadingState());
    try {
      await smartNoteRepository.addNote(noteModel);
      emit(AddNoteSuccessState());
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(AddNoteErrorState(e.toString()));
    }
  }
}
