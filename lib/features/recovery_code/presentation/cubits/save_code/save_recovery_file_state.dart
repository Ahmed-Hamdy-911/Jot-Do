abstract class SaveRecoveryFileState {}

class SaveRecoveryFileInitial extends SaveRecoveryFileState {}

class SaveRecoveryFileLoading extends SaveRecoveryFileState {}

class SaveRecoveryFileSuccess extends SaveRecoveryFileState {
  final String filePath;
  SaveRecoveryFileSuccess(this.filePath);
}

class SaveRecoveryFileError extends SaveRecoveryFileState {
  final String message;
  SaveRecoveryFileError(this.message);
}

class SaveRecoveryFilePermissionDenied extends SaveRecoveryFileState {
  final String message;
  SaveRecoveryFilePermissionDenied(this.message);
}
