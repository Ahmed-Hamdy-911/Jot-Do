import 'local/local_note_repository.dart';
import '../models/note_model.dart';

class SmartNoteRepository implements LocalNoteRepository {
  final localNoteRepo = LocalNoteRepository();
  bool isSynced = false;
  bool get isOnline => false;
  @override
  Future<void> addNote(NoteModel noteModel) async {
    try {
      if (isOnline) {
      } else {
        await localNoteRepo.addNote(noteModel);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAllNotes() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNote(String id, [NoteModel? noteModel]) async {
    try {
      if (isOnline) {
      } else {
        return localNoteRepo.deleteNote(id, noteModel);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NoteModel>> getNotes([int index = 0]) async {
    try {
      if (isOnline) {
        return [];
      } else {
        return localNoteRepo.getNotes(index);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateNote(String id, NoteModel noteModel) async {
    try {
      if (isOnline) {
      } else {
        await localNoteRepo.updateNote(id, noteModel);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<NoteModel> getAllArchivedNotes(List<NoteModel> notes) {
    throw UnimplementedError();
  }

  @override
  List<NoteModel> getAllFavoriteNotes(List<NoteModel> notes) {
    throw UnimplementedError();
  }

  @override
  List<NoteModel> getAllNotesAtLessWeek(List<NoteModel> notes) {
    throw UnimplementedError();
  }

  @override
  List<NoteModel> getAllNotesWithoutArchived(List<NoteModel> notes) {
    throw UnimplementedError();
  }

  @override
  List<NoteModel> getAllPinnedNotes(List<NoteModel> notes) {
    throw UnimplementedError();
  }
}
