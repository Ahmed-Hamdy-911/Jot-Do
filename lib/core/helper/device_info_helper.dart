import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceInfoHelper {
  final _secureStorage = const FlutterSecureStorage();
  final _deviceIdKey = 'device_id';
  final _uuid = const Uuid();

  Future<String> getDeviceId() async {
    String? storedId = await _secureStorage.read(key: _deviceIdKey);
    if (storedId != null) return storedId;
    final deviceInfo = DeviceInfoPlugin();
    String deviceId;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? _uuid.v4();
    } else {
      deviceId = _uuid.v4();
    }
    try {
      await _secureStorage.write(key: _deviceIdKey, value: deviceId);
      return deviceId;
    } catch (e) {
      return deviceId;
    }
  }

  Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceName;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.manufacturer + ' ' + androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    } else if (Platform.isLinux) {
      deviceName = 'Linux';
    } else if (Platform.isMacOS) {
      deviceName = 'MacOS';
    } else if (Platform.isWindows) {
      deviceName = 'Windows';
    } else {
      deviceName = 'Unknown';
    }
    return deviceName;
  }
}
