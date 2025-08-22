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
      switch (index) {
        case 0:
          // check if the note is not archived
          notes = getAllNotesWithoutArchived(notes);
          break;
        case 1:
          // check if the note is new with less than 7 days
          notes = getAllNotesAtLessWeek(notes);
          break;
        case 2: // check if the note is favorite
          notes = getAllFavoriteNotes(notes);

          break;
        case 3:
          // check if the note is archived
          notes = getAllArchivedNotes(notes);
          break;
        case 4:
          // check if the note is pinned
          notes = getAllPinnedNotes(notes);
          break;
        default:
          notes = getAllNotesWithoutArchived(notes);
      }
      return notes;
    } catch (e) {
      rethrow;
    }
  }

  List<NoteModel> getAllNotesAtLessWeek(List<NoteModel> notes) {
    notes.removeWhere((element) => element.isArchived);
    notes.removeWhere((element) =>
        DateTime.now().difference(DateTime.parse(element.createdAt)).inDays >
        7);
    notes.sort(
      (a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.createdAt.compareTo(a.createdAt);
      },
    );
    return notes;
  }

  List<NoteModel> getAllFavoriteNotes(List<NoteModel> notes) {
    notes.removeWhere((element) => element.isArchived);
    notes.removeWhere((element) => !element.isFavorite);
    notes.sort(
      (a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.createdAt.compareTo(a.createdAt);
      },
    );
    return notes;
  }

  List<NoteModel> getAllPinnedNotes(List<NoteModel> notes) {
    notes.removeWhere((element) => !element.isPinned);
    notes.removeWhere((element) => element.isArchived);
    notes.sort(
      (a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.createdAt.compareTo(a.createdAt);
      },
    );
    return notes;
  }

  List<NoteModel> getAllArchivedNotes(List<NoteModel> notes) {
    notes.removeWhere((element) => !element.isArchived);
    notes.sort(
      (a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.createdAt.compareTo(a.createdAt);
      },
    );
    return notes;
  }

  List<NoteModel> getAllNotesWithoutArchived(List<NoteModel> notes) {
    notes.removeWhere((element) => element.isArchived);
    notes.sort(
      (a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.createdAt.compareTo(a.createdAt);
      },
    );
    return notes;
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
