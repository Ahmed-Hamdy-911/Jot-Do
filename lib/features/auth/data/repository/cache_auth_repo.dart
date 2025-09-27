import '../../../../core/constants/app_constants.dart';
import '../../../../core/helper/cache_helper.dart';

class CacheAuthRepo {
  static void continueWithoutAccount() {
    CacheHelper.saveData(key: AppConstants.continueWithoutAccount, value: true);
  }

  static void reLogin() {
    CacheHelper.saveData(
        key: AppConstants.continueWithoutAccount, value: false);
  }
}
