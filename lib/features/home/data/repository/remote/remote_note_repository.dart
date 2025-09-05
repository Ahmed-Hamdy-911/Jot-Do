import '../note_repository.dart';
import '../../models/note_model.dart';

class RemoteNoteRepository implements NoteRepository {
  @override
  Future<void> addNote(NoteModel noteModel) {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllNotes() {
    // TODO: implement deleteAllNotes
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNote(String id) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote(String id, NoteModel noteModel) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
  // Implement remote note repository methods
}
