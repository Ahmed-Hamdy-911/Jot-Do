abstract class BackupStates {}

class BackupInitial extends BackupStates {}

class BackupInProgress extends BackupStates {
  final double progress; // 0.0 -> 1.0
  BackupInProgress(this.progress);
}

class BackupSuccess extends BackupStates {}

class BackupFailure extends BackupStates {
  final String error;
  BackupFailure(this.error);
}

class AutoBackupToggled extends BackupStates {
  final bool enabled;
  AutoBackupToggled(this.enabled);
}

class SyncNotes extends BackupStates {}

class CheckSyncNotes extends BackupStates {}

class CheckSyncNotesFailure extends BackupStates {
  final String? error;
  CheckSyncNotesFailure(this.error);
}

class CheckSyncNotesSuccess extends BackupStates {}

class NotesRestoringBackupState extends BackupStates {
  final String message;
  NotesRestoringBackupState(this.message);
}
