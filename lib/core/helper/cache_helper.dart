import 'package:hive/hive.dart';

import '../constants/constant.dart';

class CacheHelper {
  static dynamic saveData({required String key, required dynamic value}) {
    var box = Hive.box(AppConstants.settingsStorage);
    return box.put(key, value);
  }

  static dynamic getData({required String key}) {
    var box = Hive.box(AppConstants.settingsStorage);
    return box.get(key);
  }
}
