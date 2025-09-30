
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/app_service.dart';
import 'local/local_note_repository.dart';
import '../models/note_model.dart';
import 'note_repository.dart';
import 'remote/remote_note_repository.dart';

class SmartNoteRepository implements NoteRepository {
  AppService appService = AppConstants.appService;
  late bool _isOnline = appService.isOnline;
  late bool _isAutoBackupAndSync = appService.isAutoBackupAndSync;
  final _localNoteRepo = LocalNoteRepository();
  final _remoteNoteRepo = RemoteNoteRepository();
  @override
  Future<void> addNote(NoteModel noteModel) async {
    debugPrint("appService isOnline: ${_isOnline}");
    debugPrint("appService isAutoBackupAndSync: ${_isAutoBackupAndSync}");
    try {
      if (_isOnline && _isAutoBackupAndSync) {
        await _remoteNoteRepo.addNote(noteModel);
        await _localNoteRepo.addNote(noteModel);
      } else {
        await _localNoteRepo.addNote(noteModel.copyWith(isSynced: false));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NoteModel>> getNotes([String filterId = "all"]) async {
    final safeFilter = filterId.isEmpty ? "all" : filterId;

    try {
      List<NoteModel> filteredLocalNotes = [];

      if (appService.isOnline && appService.isAutoBackupAndSync) {
        final remoteNotes = await _remoteNoteRepo.getNotes();
        final allLocalNotes = await _localNoteRepo.getNotes();

        for (var note in remoteNotes) {
          final existingNote = allLocalNotes.firstWhere(
            (localNote) => localNote.id == note.id,
            orElse: () {
              return NoteModel(title: '', content: '', createdAt: '');
            },
          );

          // ignore: unnecessary_null_comparison
          if (existingNote == null) {
            await _localNoteRepo.addNote(note.copyWith(isSynced: true));
          } else {
            if (!_isSameNote(note, existingNote)) {
              await _localNoteRepo.updateNote(
                note.id!,
                note.copyWith(isSynced: true),
              );
            }
          }
        }

        filteredLocalNotes = await _localNoteRepo.getNotes(safeFilter);
      } else {
        filteredLocalNotes = await _localNoteRepo.getNotes(safeFilter);
      }

      // log("Fetched ${filteredLocalNotes.length} notes with filter: $safeFilter");
      return filteredLocalNotes;
    } catch (e) {
      rethrow;
    }
  }

  /// ✅ دالة مقارنة آمنة
  bool _isSameNote(NoteModel a, NoteModel b) {
    return a.title == b.title &&
        a.content == b.content &&
        a.color == b.color &&
        a.isArchived == b.isArchived &&
        a.isPinned == b.isPinned &&
        a.isFavorite == b.isFavorite &&
        a.filterId == b.filterId;
  }

  @override
  Future<void> updateNote(String id, NoteModel noteModel) async {
    try {
      if (await _isOnline && _isAutoBackupAndSync) {
        final note = noteModel.copyWith(isSynced: true);
        await _remoteNoteRepo.updateNote(id, note);
        await _localNoteRepo.updateNote(id, note);
      } else {
        await _localNoteRepo.updateNote(
            id, noteModel.copyWith(isSynced: false));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      if (_isOnline && _isAutoBackupAndSync) {
        await _remoteNoteRepo.deleteNote(id);
        await _localNoteRepo.deleteNote(id);
      } else {
        return _localNoteRepo.deleteNote(id);
      }
      debugPrint("Deleted note with id: $id");
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteAllNotes() async {
    try {
      await Future.wait([
        _localNoteRepo.deleteAllNotes(),
        _remoteNoteRepo.deleteAllNotes(),
      ]);
      debugPrint("✅ All notes deleted");
    } catch (e) {
      debugPrint("❌ Error deleting notes: $e");
      rethrow;
    }
  }
}
