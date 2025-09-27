import '../../../home/data/models/note_model.dart';

abstract class NoteRepository {
  Future<void> addNote(NoteModel noteModel);
  Future<void> deleteNote(String id);
  Future<void> updateNote(String id, NoteModel noteModel);
  Future<List<NoteModel>> getNotes();
  Future<void> deleteAllNotes();
}
