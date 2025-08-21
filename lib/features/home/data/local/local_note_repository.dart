import 'package:hive/hive.dart';

import '../../../../core/constants/constant.dart';
import '../models/note_model.dart';
import '../repository/note_repository.dart';

class LocalNoteRepository implements NoteRepository {
  @override
  Future<void> addNote(NoteModel noteModel) async {
    try {
      var box = Hive.box<NoteModel>(AppConstants.notesStorage);
      await box.add(noteModel);
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
      var box = Hive.box<NoteModel>(AppConstants.notesStorage);
      return box.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateNote(String id, NoteModel noteModel) {
    throw UnimplementedError();
  }
}
