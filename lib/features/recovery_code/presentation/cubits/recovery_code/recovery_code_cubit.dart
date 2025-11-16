import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../../../core/services/app_session.dart';
import '../../../data/services/key_manager.dart';
import 'recovery_code_state.dart';

class RecoveryCodeCubit extends Cubit<RecoveryCodeState> {
  RecoveryCodeCubit() : super(RecoveryCodeInitial());

  final keyManager = KeyManager();
  bool isCopied = false;

  /// Main startup flow - checks and handles all key scenarios
  Future<void> performStartupFlow() async {
    emit(RecoveryCodeLoading());
    try {
      // Check if any wrapped keys exist
      final hasWrappedKeys = await keyManager.hasWrappedKeys();

      if (!hasWrappedKeys) {
        // No keys - create new master key
        await _createMasterKey();
        return;
      }

      // Keys exist - check if same device
      final isSameDevice = await keyManager.isSameDevice;

      if (isSameDevice) {
        // Same device - check if recovery needs to be shown
        final shouldShow = await keyManager.shouldShowRecoveryView();

        if (shouldShow) {
          // User created key but hasn't saved recovery code
          final pendingCode = await keyManager.getPendingRecoveryCode();
          if (pendingCode != null) {
            emit(RecoveryCodeCreated(recoveryCode: pendingCode));
          } else {
            emit(NeedToSaveRecoveryCode());
          }
        } else {
          // Everything set up - mark recovery view as not needed
          await AppSession.instance.setShouldShowRecoveryView(false);
          emit(RecoveryCodeSaved());
        }
      } else {
        // Different device - need recovery code
        final checkSuccess = await keyManager.performStartupChecks();
        log('checkSuccess=$checkSuccess');
        if (checkSuccess) {
          emit(NeedToEnterRecoveryCode());
        } else {
          await AppSession.instance.setShouldShowRecoveryView(false);
          emit(RecoveryCodeSaved());
        }
      }
    } catch (e) {
      emit(RecoveryCodeFailure(e.toString()));
    }
  }

  /// Creates a new master key and recovery code
  Future<void> _createMasterKey() async {
    try {
      final recoveryCode = await keyManager.createMasterAndUploadKey(
        createRecovery: true,
      );

      if (recoveryCode != null) {
        emit(RecoveryCodeCreated(recoveryCode: recoveryCode));
      } else {
        emit(RecoveryCodeFailure('Failed to create recovery code'));
      }
    } catch (e) {
      emit(RecoveryCodeFailure(e.toString()));
    }
  }

  /// User confirms they saved the recovery code
  Future<void> acknowledgeSaved() async {
    emit(RecoveryCodeLoading());
    try {
      await keyManager.markRecoverySeen();
      // Mark that recovery view should not show anymore
      AppSession.instance.setPendingRecoveryCode(null);
      await AppSession.instance.setShouldShowRecoveryView(false);
      emit(RecoveryCodeSaved());
    } catch (e) {
      emit(RecoveryCodeFailure(e.toString()));
    }
  }

  /// User skips saving recovery code (risky!)
  Future<void> skipSavingRecovery({required String code}) async {
    try {
      AppSession.instance.reload();
      await AppSession.instance.setShouldShowRecoveryView(true);
      AppSession.instance.setPendingRecoveryCode(code);
      emit(RecoveryCodeSkipped());
    } catch (e) {
      emit(RecoveryCodeFailure(e.toString()));
    }
  }

  /// User enters recovery code to access master key on new device
  Future<void> enterRecoveryCode({required String code}) async {
    emit(RecoveryCodeLoading());
    try {
      final masterKey = await keyManager.unwrapWithRecovery(
        recoveryCode: code,
      );

      if (masterKey == null) {
        emit(CheckingRecoveryCodeError('Invalid recovery code'));
        return;
      }

      // Onboard this device
      await keyManager.onboardDeviceAfterRecovery(masterKey: masterKey);

      // Mark that recovery view should not show anymore
      await AppSession.instance.setShouldShowRecoveryView(false);

      emit(CheckingRecoveryCodeSuccess());
    } catch (e) {
      emit(CheckingRecoveryCodeError(e.toString()));
    }
  }

  /// User skips entering recovery code (can't access encrypted data)
  Future<void> skipRecoveryEntry() async {
    emit(RecoveryEntrySkipped());
  }

  /// Get the pending recovery code to display
  Future<String?> getPendingRecoveryCode() async {
    try {
      return await keyManager.getPendingRecoveryCode();
    } catch (e) {
      return null;
    }
  }
}
