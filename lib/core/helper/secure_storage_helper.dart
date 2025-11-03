import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final _secureStorage = const FlutterSecureStorage();
  static Future<void> write(
          {required String key, required String? value}) async =>
      await _secureStorage.write(key: key, value: value);

  static Future<String?> read({required String key}) async =>
      await _secureStorage.read(key: key);

  static Future<void> delete({required String key}) async =>
      await _secureStorage.delete(key: key);

  static Future<void> clear() async => await _secureStorage.deleteAll();
}
