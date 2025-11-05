import 'package:permission_handler/permission_handler.dart';

import 'permission_model.dart';

class PermissionService {
  static Future<bool> requestPermission(AppPermission appPermission) async {
    // ignore: unused_element
    Future<void> debugPermission(Permission permission) async {
      final before = await permission.status;
      print('DEBUG: before status = $before');
      final result = await permission.request();
      print('DEBUG: request result = $result');
      final after = await permission.status;
      print('DEBUG: after status = $after');
    }

    Permission permission;
    switch (appPermission) {
      case AppPermission.camera:
        permission = Permission.camera;
        break;
      case AppPermission.videos:
        permission = Permission.videos;
        break;
      case AppPermission.microphone:
        permission = Permission.microphone;
        break;
      case AppPermission.storage:
        permission = Permission.storage;
        break;
      case AppPermission.location:
        permission = Permission.location;
        break;
    }

    var status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    status = await permission.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return false;
  }
}
