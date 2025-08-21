import '../local/local_note_repository.dart';
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
  Future<void> deleteNote(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      if (isOnline) {
        return [];
      } else {
        return localNoteRepo.getNotes();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateNote(String id, NoteModel noteModel) {
    throw UnimplementedError();
  }
}
