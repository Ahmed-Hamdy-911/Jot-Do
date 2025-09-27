import 'package:hive/hive.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../home/data/models/note_model.dart';
import '../note_repository.dart';

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
  Future<void> deleteAllNotes() async {
    try {
      var box = Hive.box<NoteModel>(AppConstants.notesStorage);
      await box.clear();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNote(String id, [NoteModel? noteModel]) async {
    try {
      var box = Hive.box<NoteModel>(AppConstants.notesStorage);
      final index = box.values.toList().indexWhere((note) => note.id == id);
      if (index != -1) {
        await box.deleteAt(index);
      }
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
    return notes.where((element) {
      final createdDate = DateTime.tryParse(element.createdAt);
      if (createdDate == null) return false;

      return DateTime.now().difference(createdDate).inDays < 7 &&
          !element.isArchived;
    }).toList()
      ..sort(
        (a, b) {
          final dateA = DateTime.tryParse(a.createdAt) ?? DateTime(1970);
          final dateB = DateTime.tryParse(b.createdAt) ?? DateTime(1970);

          if (a.isPinned && !b.isPinned) return -1;
          if (!a.isPinned && b.isPinned) return 1;
          return dateB.compareTo(dateA);
        },
      );
  }

  List<NoteModel> getAllFavoriteNotes(List<NoteModel> notes) {
    return notes
        .where((element) => element.isFavorite && !element.isArchived)
        .toList()
      ..sort(
        (a, b) {
          if (a.isPinned && !b.isPinned) return -1;
          if (!a.isPinned && b.isPinned) return 1;
          return b.createdAt.compareTo(a.createdAt);
        },
      );
  }

  List<NoteModel> getAllPinnedNotes(List<NoteModel> notes) {
    return notes
        .where((element) => element.isPinned && !element.isArchived)
        .toList()
      ..sort(
        (a, b) {
          if (a.isPinned && !b.isPinned) return -1;
          if (!a.isPinned && b.isPinned) return 1;
          return b.createdAt.compareTo(a.createdAt);
        },
      );
  }

  List<NoteModel> getAllArchivedNotes(List<NoteModel> notes) {
    return notes.where((element) => element.isArchived).toList()
      ..sort(
        (a, b) {
          if (a.isPinned && !b.isPinned) return -1;
          if (!a.isPinned && b.isPinned) return 1;
          return b.createdAt.compareTo(a.createdAt);
        },
      );
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
      var box = Hive.box<NoteModel>(AppConstants.notesStorage);
      final index = box.values.toList().indexWhere((note) => note.id == id);
      if (index != -1) {
        await box.putAt(index, noteModel);
      }
    } catch (e) {
      rethrow;
    }
  }
}
