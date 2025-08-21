import '../../../../core/helper/cache_helper.dart';

class CacheAuthRepo {
  static void skipAuthentication() {
    final cacheHelper = CacheHelper();
    cacheHelper.saveData(key: 'skipAuthentication', value: true);
  }
}
