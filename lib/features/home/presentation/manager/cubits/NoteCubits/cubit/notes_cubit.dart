import 'package:bloc/bloc.dart';

import '../../../../../data/models/note_model.dart';
import '../../../../../data/repository/smart_note_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  final smartNoteRepository = SmartNoteRepository();
  List<NoteModel>? notesList;
  Future<void> getNotes() async {
    emit(NotesLoadingState());
    try {
      notesList = await smartNoteRepository.getNotes();
      emit(GetAllNotesSuccessState());
    } on Exception catch (e) {
      emit(GetAllNotesErrorState(e.toString()));
    }
  }
}
