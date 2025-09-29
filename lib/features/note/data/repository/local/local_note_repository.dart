import 'package:hive/hive.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../models/note_model.dart';
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
  Future<List<NoteModel>> getNotes([String filterId = "all"]) async {
    final box = Hive.box<NoteModel>(AppConstants.notesStorage);
    final notes = box.values.toList();

    if (filterId == "all") {
      return _sortNotes(notes.where((n) => !n.isArchived).toList());
    }
    if (filterId == "new") {
      return _sortNotes(notes.where((n) {
        final created = DateTime.tryParse(n.createdAt);
        return created != null &&
            DateTime.now().difference(created).inDays < 7 &&
            !n.isArchived;
      }).toList());
    }
    if (filterId == "favorite") {
      return _sortNotes(
          notes.where((n) => n.isFavorite && !n.isArchived).toList());
    }
    if (filterId == "pinned") {
      return _sortNotes(
          notes.where((n) => n.isPinned && !n.isArchived).toList());
    }
    if (filterId == "archived") {
      return _sortNotes(notes.where((n) => n.isArchived).toList());
    }

    // custom filter
    return _sortNotes(notes.where((n) {
      // filterIds قد تكون null أو سلسلة فارغة، نتحقق أنها تحتوي على الـ id المطلوب
      return (n.filterIds?.split(',').contains(filterId) ?? false) &&
          !n.isArchived;
    }).toList());
  }

  List<NoteModel> _sortNotes(List<NoteModel> notes) {
    notes.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      final dateA = DateTime.tryParse(a.createdAt) ?? DateTime(1970);
      final dateB = DateTime.tryParse(b.createdAt) ?? DateTime(1970);
      return dateB.compareTo(dateA);
    });
    return notes;
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
