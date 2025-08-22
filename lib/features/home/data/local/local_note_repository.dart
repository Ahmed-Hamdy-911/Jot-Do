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
  Future<void> deleteNote(String id, [NoteModel? noteModel]) async {
    try {
      noteModel?.delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NoteModel>> getNotes([int index = 0]) async {
    try {
      var box = Hive.box<NoteModel>(AppConstants.notesStorage);
      var notes = box.values.toList();
      // check if the note is not archived
      notes.removeWhere((element) => element.isArchived);
      notes.sort(
        (a, b) {
          if (a.isPinned && !b.isPinned) return -1;
          if (!a.isPinned && b.isPinned) return 1;
          return b.createdAt.compareTo(a.createdAt);
        },
      );
      return notes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateNote(String id, NoteModel noteModel) async {
    try {
      await noteModel.save();
    } catch (e) {
      rethrow;
    }
  }
}
