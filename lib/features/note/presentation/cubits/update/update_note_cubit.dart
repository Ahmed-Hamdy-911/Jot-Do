import 'package:bloc/bloc.dart';

import '../../../../home/data/models/note_model.dart';
import '../../../data/repository/smart_note_repository.dart';
import 'update_note_state.dart';

class UpdateNoteCubit extends Cubit<UpdateNoteStates> {
  UpdateNoteCubit() : super(UpdateNoteInitialState());
  final SmartNoteRepository _smartNoteRepository =
      SmartNoteRepository();
  Future<void> updateNote(NoteModel noteModel) async {
    emit(UpdateNoteLoadingState());
    try {
      _smartNoteRepository.updateNote(noteModel.id!, noteModel);
      emit(UpdateNoteSuccessState());
    } on Exception catch (e) {
      emit(UpdateNoteErrorState(e.toString()));
    }
  }
}
