import 'local/local_note_repository.dart';

class SyncNoteRepo {
  final bool isOnline;
  final bool isSynced;
  final LocalNoteRepository localNoteRepo;
  final LocalNoteRepository remoteNoteRepo;

  SyncNoteRepo(
      this.isOnline, this.isSynced, this.localNoteRepo, this.remoteNoteRepo);
  Future<void> syncNotes() async {
    try {
      if (!isOnline) return;
      if (!isSynced) return;
      final localNotes = await localNoteRepo.getNotes();
      var unsyncedNotes =
          localNotes.where((note) => note.isSynced == false).toList();
      for (var note in unsyncedNotes) {
        var syncedNote = note.copyWith(isSynced: true);
        await remoteNoteRepo.addNote(syncedNote);
        await localNoteRepo.updateNote(note.id!, syncedNote);
      }
      // by id
      final remoteNotes = await remoteNoteRepo.getNotes();
      for (var note in remoteNotes) {
        if (!localNotes.any((localNote) => localNote.id == note.id)) {
          await localNoteRepo.addNote(note.copyWith(isSynced: true));
        }
      }

      // by lastUpdatedAt
      for (var note in remoteNotes) {
        if (!localNotes.any((localNote) => localNote.lastUpdatedAt == null) &&
            remoteNotes.any((remoteNote) => remoteNote.lastUpdatedAt != null)) {
          await localNoteRepo.updateNote(note.id!, note);
        }
      }

    } catch (e) {
      rethrow;
    }
  }
}
