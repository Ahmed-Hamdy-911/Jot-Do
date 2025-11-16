import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/services/format_service.dart';
import '../../../../core/services/permissions/permission_model.dart';
import '../../../../core/services/permissions/permission_service.dart';

class RecoveryFileRepository {
  static const String appName = 'Jot&Do';

// Save recovery code to file
  Future<String?> saveRecoveryCodeToFile({required String recoveryCode}) async {
    try {
      final hasPermission = await _requestStoragePermissions();
      if (!hasPermission) {
        throw 'Storage permission denied';
      }

      final downloadDirectory = await _getDownloadDirectory();
      if (downloadDirectory == null) {
        throw 'Could not access storage directory';
      }

      final fileName = _generateFileName();
      final filePath = '${downloadDirectory.path}/$fileName.txt';
      final file = File(filePath);
      final fileContent = _generateFileContent(recoveryCode: recoveryCode);
      await file.writeAsString(fileContent);
      print('✅ Recovery code saved to: $filePath');
      return filePath;
    } on Exception catch (e) {
      throw '❌ Error saving recovery code: $e';
    }
  }

  /// Generate filename with timestamp
  /// Format: Jot&Do_recovery-code-YYYYMMDD_HHMMSS.txt
  String _generateFileName() {
    final now = DateTime.now();
    final timestamp =
        FormatService.formatDateTime(now, format: 'yyyyMMdd_HHmmss');
    return '${appName}_recovery-code-$timestamp';
  }

  // Generate a file name for the recovery code
  String _generateFileContent({required String recoveryCode}) {
    return '''Recovery Code: $recoveryCode

App: $appName
Generated: ${FormatService.formatDateTime(DateTime.now())}

⚠️ IMPORTANT: Keep this code safe. You'll need it to restore your encrypted notes.

Do not share this code with anyone.''';
  }

  /// Check if file exists at given path
  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Request storage permissions
  Future<bool> _requestStoragePermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await _getAndroidVersion();
      if (androidInfo >= 33) {
        return true;
      } else {
        final storagePermission = AppPermission.storage;
        final status =
            await PermissionService.requestPermission(storagePermission);
        return status;
      }
    }
    return true;
  }

  /// Get the version of the Android OS
  Future<int> _getAndroidVersion() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  // Get the download directory
  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await _getAndroidDownloadDirectory();
    } else if (Platform.isIOS) {
      return await _getIosDownloadDirectory();
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }

  // Get the download directory for android
  Future<Directory?> _getAndroidDownloadDirectory() async {
    final directory =
        await Directory('/storage/emulated/0/Download').create(recursive: true);
    if (await directory.exists()) {
      return directory;
    }
    final externalDir = await getExternalStorageDirectory();
    return externalDir;
  }

  // Get the download directory for ios
  Future<Directory?> _getIosDownloadDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }
}
