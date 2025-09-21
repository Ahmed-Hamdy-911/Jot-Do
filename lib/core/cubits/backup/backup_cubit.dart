import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_constants.dart';
import '../../helper/cache_helper.dart';
import '../../services/app_service.dart';
import 'backup_state.dart';

class BackupCubit extends Cubit<BackupStates> {
  final AppService appService = AppConstants.appService;
  BackupCubit() : super(BackupInitial());

  void toggleAutoBackup(bool value) {
    bool isAutoBackupAndSync = value;
    CacheHelper.saveData(key: AppConstants.isAutoBackupAndSync, value: value);
    var isLoggedIn = CacheHelper.getData(key: AppConstants.isLoggedIn) ?? false;

    var isBackupAndSync = isAutoBackupAndSync && isLoggedIn;
    appService.isAutoBackupAndSync = isBackupAndSync;
    CacheHelper.saveData(
        key: AppConstants.isAutoBackupAndSync, value: isAutoBackupAndSync);
    // log("isBackupAndSync: $isBackupAndSync");
    emit(AutoBackupToggled(value));
  }
}
