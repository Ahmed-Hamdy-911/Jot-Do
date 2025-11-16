import 'package:bloc/bloc.dart';

import '../../../data/repos/recovery_file_repository.dart';
import 'save_recovery_file_state.dart';

class SaveRecoveryFileCubit extends Cubit<SaveRecoveryFileState> {
  SaveRecoveryFileCubit() : super(SaveRecoveryFileInitial());
  final _recoveryFileRepository = RecoveryFileRepository();

  Future<void> saveRecoveryCodeToFile({required String recoveryCode}) async {
    emit(SaveRecoveryFileLoading());
    try {
      if (recoveryCode.isEmpty) {
        emit(SaveRecoveryFileError('Recovery code cannot be empty'));
        return;
      }
      final filePath = await _recoveryFileRepository.saveRecoveryCodeToFile(
          recoveryCode: recoveryCode);
      if (filePath != null) {
        emit(SaveRecoveryFileSuccess(filePath));
      } else {
        emit(SaveRecoveryFilePermissionDenied(  'Storage permission denied'));
      }
    } catch (e) {
      emit(SaveRecoveryFileError(e.toString()));
    }
  }

  void reset() {
    emit(SaveRecoveryFileInitial());
  }
}
