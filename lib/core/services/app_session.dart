import 'dart:async';
import '../constants/app_constants.dart';
import '../helper/cache_helper.dart';
import '../helper/secure_storage_helper.dart';

class AppSession {
  // ═══════════════════════════════════════════════════════════
  // Singleton Pattern
  // ═══════════════════════════════════════════════════════════
  static final AppSession _instance = AppSession._internal();
  factory AppSession() => _instance;
  static AppSession get instance => _instance;

  AppSession._internal() {
    _initializeFromCache();
  }

  // ═══════════════════════════════════════════════════════════
  // Stream to notify changes
  // ═══════════════════════════════════════════════════════════
  final _onChangeController = StreamController<AppSession>.broadcast();
  Stream<AppSession> get changes => _onChangeController.stream;

  // ═══════════════════════════════════════════════════════════
  //(Session Data)
  // ═══════════════════════════════════════════════════════════

  // cache data (data that will be saved in cache and  will be available even if the app is closed)
  bool isOnline = false;
  String? currentScreen;
  Map<String, dynamic>? tempData;

  // data saved in secure storage and cache 
  String? _uid;
  bool _isAutoBackupAndSync = false;
  bool _isLoggedIn = false;

  // recovery data
  String? pendingRecoveryCode;
  bool? isSameDevice;

  // ═══════════════════════════════════════════════════════════
  // Getters
  // ═══════════════════════════════════════════════════════════
  String? get uid => _uid;
  bool get isAutoBackupAndSync => _isAutoBackupAndSync;
  bool get isLoggedIn => _isLoggedIn;

  // ═══════════════════════════════════════════════════════════
  // Initialization from Cache
  // ═══════════════════════════════════════════════════════════
  Future<void> _initializeFromCache() async {
    _uid = await SecureStorageHelper.read(key: AppConstants.uid) ?? null;
    _isAutoBackupAndSync =
        CacheHelper.getData(key: AppConstants.isAutoBackupAndSync) ?? false;
    _isLoggedIn = CacheHelper.getData(key: AppConstants.isLoggedIn) ?? false;

    _notifyChanges();
  }

  // ═══════════════════════════════════════════════════════════
  // Setters (With Cache)
  // ═══════════════════════════════════════════════════════════

  Future<void> setUid(String newUid, {bool saveToCache = true}) async {
    _uid = newUid;
    if (saveToCache) {
      await SecureStorageHelper.write(key: AppConstants.uid, value: newUid);
    }
    _notifyChanges();
  }

  Future<void> setAutoBackupAndSync(bool value) async {
    _isAutoBackupAndSync = value;
    await CacheHelper.saveData(
      key: AppConstants.isAutoBackupAndSync,
      value: value,
    );
    _notifyChanges();
  }

  Future<void> setLoginStatus(bool status) async {
    _isLoggedIn = status;
    await CacheHelper.saveData(key: AppConstants.isLoggedIn, value: status);
    _notifyChanges();
  }

  // ═══════════════════════════════════════════════════════════
  // Setters (No Cache)
  // ═══════════════════════════════════════════════════════════

  void setOnlineStatus(bool status) {
    isOnline = status;
    _notifyChanges();
  }

  void setPendingRecoveryCode(String? code) {
    pendingRecoveryCode = code;
    _notifyChanges();
  }

  void setIsSameDevice(bool? value) {
    isSameDevice = value;
    _notifyChanges();
  }

  void setCurrentScreen(String? screen) {
    currentScreen = screen;
    _notifyChanges();
  }

  void setTempData(String key, dynamic value) {
    tempData ??= {};
    tempData![key] = value;
    _notifyChanges();
  }

  dynamic getTempData(String key) {
    return tempData?[key];
  }

  // ═══════════════════════════════════════════════════════════
  // Clear & Logout
  // ═══════════════════════════════════════════════════════════

  /// delete the temp data only
  Future<void> clearTempData() async {
    currentScreen = null;
    tempData = null;
    pendingRecoveryCode = null;
    isSameDevice = null;
    await SecureStorageHelper.delete(key: AppConstants.uid);
    await CacheHelper.deleteData(key: AppConstants.isLoggedIn);
    _notifyChanges();
  }

  /// logout and clear all data
  Future<void> logout() async {
   // delete all data
    _uid = null;
    _isLoggedIn = false;
    await clearTempData();

    _notifyChanges();
  }

  /// clear all data (Except Settings)
  Future<void> clearAll() async {
    await clearTempData();
    _uid = null;
    _isAutoBackupAndSync = false;
    _isLoggedIn = false;
    _notifyChanges();
  }

  // ═══════════════════════════════════════════════════════════
  // Helper Methods
  // ═══════════════════════════════════════════════════════════

  void _notifyChanges() {
    if (!_onChangeController.isClosed) {
      _onChangeController.add(this);
    }
  }

  /// reload from cache
  Future<void> reload() async {
    await _initializeFromCache();
  }

  void dispose() {
    _onChangeController.close();
  }

  // ═══════════════════════════════════════════════════════════
  // Debug
  // ═══════════════════════════════════════════════════════════

  @override
  String toString() {
    return '''
    AppSession {
      uid: $_uid,
      isLoggedIn: $_isLoggedIn,
      isOnline: $isOnline,
      isAutoBackup: $_isAutoBackupAndSync,
    }
    ''';
  }
}
