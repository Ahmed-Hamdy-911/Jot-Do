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
  Future<List<NoteModel>> getNotes([int index = 0]) async {
    try {
      List<NoteModel> localNotes = [];

      if (_isOnline && _isAutoBackupAndSync) {
        var remoteNotes = await _remoteNoteRepo.getNotes();

        localNotes = await _localNoteRepo.getNotes(index);

        for (var note in remoteNotes) {
          if (!localNotes.any((localNote) => localNote.id == note.id)) {
            await _localNoteRepo.addNote(note.copyWith(isSynced: true));
          }
        }
      } else {
        localNotes = await _localNoteRepo.getNotes(index);
      }
      return localNotes;
    } catch (e) {
      rethrow;
    }
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
      if (_isOnline && _isAutoBackupAndSync) {
        await _localNoteRepo.deleteAllNotes();
        await _remoteNoteRepo.deleteAllNotes();
      } else {
        await _localNoteRepo.deleteAllNotes();
      }
    } catch (e) {
      rethrow;
    }
  }
}
