import '../../../../core/helper/cache_helper.dart';

class CacheAuthRepo {
  static void skipAuthentication() {
    CacheHelper.saveData(key: 'skipAuthentication', value: true);
  }
}
