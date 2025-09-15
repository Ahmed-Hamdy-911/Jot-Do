import '../../../../core/constants/app_constants.dart';
import '../../../../core/helper/cache_helper.dart';

class CacheAuthRepo {
  static void skipAuthentication() {
    CacheHelper.saveData(key: AppConstants.skipAuthentication, value: true);
  }
}
