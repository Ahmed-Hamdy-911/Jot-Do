abstract class RecoveryCodeState {}

class RecoveryCodeInitial extends RecoveryCodeState {}

class RecoveryCodeLoading extends RecoveryCodeState {}

class MasterKeyAlreadySetup extends RecoveryCodeState {}

class RecoveryCodeCreated extends RecoveryCodeState {
  final String recoveryCode;
  RecoveryCodeCreated({required this.recoveryCode});
}

class NeedToSaveRecoveryCode extends RecoveryCodeState {}

class NeedToEnterRecoveryCode extends RecoveryCodeState {}

class RecoveryCodeSaved extends RecoveryCodeState {}

class RecoveryCodeSkipped extends RecoveryCodeState {}

class CheckingRecoveryCodeSuccess extends RecoveryCodeState {}

class CheckingRecoveryCodeError extends RecoveryCodeState {
  final String error;
  CheckingRecoveryCodeError(this.error);
}

class RecoveryEntrySkipped extends RecoveryCodeState {}

class RecoveryCodeFailure extends RecoveryCodeState {
  final String error;
  RecoveryCodeFailure(this.error);
}

class RecoveryCodeCopied extends RecoveryCodeState {}
