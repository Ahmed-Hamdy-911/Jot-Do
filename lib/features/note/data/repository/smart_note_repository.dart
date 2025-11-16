import 'package:flutter/material.dart';
import '../../../../core/services/app_session.dart';
import 'local/local_note_repository.dart';
import '../models/note_model.dart';
import 'note_repository.dart';
import 'remote/remote_note_repository.dart';

class SmartNoteRepository implements NoteRepository {
  // ✅ الطريقة الأفضل: الوصول المباشر
  final _appSession = AppSession.instance;
  final _localNoteRepo = LocalNoteRepository();
  final _remoteNoteRepo = RemoteNoteRepository();

  // ═══════════════════════════════════════════════════════════
  // Helper Getters للقراءة السريعة
  // ═══════════════════════════════════════════════════════════
  bool get _isOnline => _appSession.isOnline;
  bool get _isAutoBackupAndSync => _appSession.isAutoBackupAndSync;
  bool get _shouldSyncRemote => _isOnline && _isAutoBackupAndSync;

  // ═══════════════════════════════════════════════════════════
  // Add Note
  // ═══════════════════════════════════════════════════════════
  @override
  Future<void> addNote(NoteModel noteModel) async {
    // debugPrint("📊 isOnline: $_isOnline | isAutoSync: $_isAutoBackupAndSync");
    
    try {
      if (_shouldSyncRemote) {
        // Online + Auto Sync: حفظ في الاتنين
        await Future.wait([
          _remoteNoteRepo.addNote(noteModel),
          _localNoteRepo.addNote(noteModel.copyWith(isSynced: true)),
        ]);
      } else {
        // Offline: حفظ محلي فقط
        await _localNoteRepo.addNote(noteModel.copyWith(isSynced: false));
      }
    } catch (e) {
      debugPrint("❌ Error adding note: $e");
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Get Notes
  // ═══════════════════════════════════════════════════════════
  @override
  Future<List<NoteModel>> getNotes([String filterId = "all"]) async {
    final safeFilter = filterId.isEmpty ? "all" : filterId;

    try {
      if (_shouldSyncRemote) {
        // Online: مزامنة من Remote ثم إرجاع Local
        await _syncRemoteToLocal();
      }
      
      // إرجاع البيانات المحلية
      return await _localNoteRepo.getNotes(safeFilter);
    } catch (e) {
      debugPrint("❌ Error getting notes: $e");
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Update Note
  // ═══════════════════════════════════════════════════════════
  @override
  Future<void> updateNote(String id, NoteModel noteModel) async {
    try {
      if (_shouldSyncRemote) {
        // Online: تحديث في الاتنين
        final syncedNote = noteModel.copyWith(isSynced: true);
        await Future.wait([
          _remoteNoteRepo.updateNote(id, syncedNote),
          _localNoteRepo.updateNote(id, syncedNote),
        ]);
      } else {
        // Offline: تحديث محلي فقط
        await _localNoteRepo.updateNote(
          id, 
          noteModel.copyWith(isSynced: false),
        );
      }
    } catch (e) {
      debugPrint("❌ Error updating note: $e");
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Delete Note
  // ═══════════════════════════════════════════════════════════
  @override
  Future<void> deleteNote(String id) async {
    try {
      if (_shouldSyncRemote) {
        // Online: حذف من الاتنين
        await Future.wait([
          _remoteNoteRepo.deleteNote(id),
          _localNoteRepo.deleteNote(id),
        ]);
      } else {
        // Offline: حذف محلي فقط
        await _localNoteRepo.deleteNote(id);
      }
      debugPrint("✅ Deleted note with id: $id");
    } catch (e) {
      debugPrint("❌ Error deleting note: $e");
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Delete All Notes
  // ═══════════════════════════════════════════════════════════
  @override
  Future<void> deleteAllNotes() async {
    try {
      await Future.wait([
        _localNoteRepo.deleteAllNotes(),
        if (_shouldSyncRemote) _remoteNoteRepo.deleteAllNotes(),
      ]);
      debugPrint("✅ All notes deleted");
    } catch (e) {
      debugPrint("❌ Error deleting all notes: $e");
      rethrow;
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Private Helper: Sync Remote to Local
  // ═══════════════════════════════════════════════════════════
  Future<void> _syncRemoteToLocal() async {
    try {
      final remoteNotes = await _remoteNoteRepo.getNotes();
      final localNotes = await _localNoteRepo.getNotes();

      for (var remoteNote in remoteNotes) {
        final localNote = localNotes.firstWhere(
          (note) => note.id == remoteNote.id,
          orElse: () => NoteModel.empty(),
        );

        if (localNote.id == null) {
          // Note مش موجودة محلياً: أضفها
          await _localNoteRepo.addNote(remoteNote.copyWith(isSynced: true));
        } else if (!_isSameNote(remoteNote, localNote)) {
          // Note متغيرة: حدثها
          await _localNoteRepo.updateNote(
            remoteNote.id!,
            remoteNote.copyWith(isSynced: true),
          );
        }
      }
    } catch (e) {
      debugPrint("⚠️ Sync warning: $e");
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Private Helper: Compare Notes
  // ═══════════════════════════════════════════════════════════
  bool _isSameNote(NoteModel a, NoteModel b) {
    return a.title == b.title &&
        a.content == b.content &&
        a.color == b.color &&
        a.isArchived == b.isArchived &&
        a.isPinned == b.isPinned &&
        a.isFavorite == b.isFavorite &&
        a.filterId == b.filterId;
  }
}