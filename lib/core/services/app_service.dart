import '../constants/app_constants.dart';
import '../helper/cache_helper.dart';

class AppService {
  bool isOnline = false;
  bool isAutoBackupAndSync =
      CacheHelper.getData(key: AppConstants.isAutoBackupAndSync) ?? false;

  void Function()? deleteAll;
  void Function()? archiveAll;
}
