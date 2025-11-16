import 'dart:async';
import '../../features/recovery_code/data/services/key_manager.dart';
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
  bool continueWithoutAccount = false;
  bool _isSameUser = false;

  // recovery data
  String? pendingRecoveryCode;
  bool? isSameDevice;

  // should show recovery code or not
  bool shouldShowRecoveryView = true;

  // ═══════════════════════════════════════════════════════════
  // Getters
  // ═══════════════════════════════════════════════════════════
  String? get uid => _uid;
  bool get isAutoBackupAndSync => _isAutoBackupAndSync;
  bool get isLoggedIn => _isLoggedIn;
  bool get isSameUser => _isSameUser;

  // ═══════════════════════════════════════════════════════════
  // Initialization from Cache
  // ═══════════════════════════════════════════════════════════
  Future<void> _initializeFromCache() async {
    _uid = await SecureStorageHelper.read(key: AppConstants.uid) ?? null;
    _isAutoBackupAndSync =
        CacheHelper.getData(key: AppConstants.isAutoBackupAndSync) ?? false;
    _isLoggedIn = CacheHelper.getData(key: AppConstants.isLoggedIn) ?? false;
    continueWithoutAccount =
        CacheHelper.getData(key: AppConstants.continueWithoutAccount) ?? false;

    shouldShowRecoveryView =
        CacheHelper.getData(key: AppConstants.shouldShowRecoveryView) ?? true;

    pendingRecoveryCode =
        await SecureStorageHelper.read(key: AppConstants.pendingRecoveryCode) ??
            null;
    _isSameUser = CacheHelper.getData(key: AppConstants.isSameUser) ?? false;
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

  Future<void> setContinueWithoutAccount(bool value) async {
    continueWithoutAccount = value;
    await CacheHelper.saveData(
      key: AppConstants.continueWithoutAccount,
      value: value,
    );
    _notifyChanges();
  }

  Future<void> setShouldShowRecoveryView(bool value) async {
    shouldShowRecoveryView = value; // ✅ CORRECT VARIABLE
    await CacheHelper.saveData(
      key: AppConstants.shouldShowRecoveryView, // ✅ Better key name
      value: value,
    );
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
    SecureStorageHelper.write(
        key: AppConstants.pendingRecoveryCode, value: code);
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

  Future<void> updateIsSameUser() async {
    if (_uid == null) return;
    _isSameUser = await KeyManager().isSameUser();
    await CacheHelper.saveData(
        key: AppConstants.isSameUser, value: _isSameUser);
    _notifyChanges();
  }

  Future<void> updateShouldShowRecoveryView() async {
    if (_uid == null) return;
    shouldShowRecoveryView = await KeyManager().shouldShowRecoveryView();
    await CacheHelper.saveData(
        key: AppConstants.shouldShowRecoveryView,
        value: shouldShowRecoveryView);
    _notifyChanges();
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
    await CacheHelper.deleteData(key: AppConstants.isSameUser);
    await CacheHelper.deleteData(key: AppConstants.shouldShowRecoveryView);

    _notifyChanges();
  }

  /// logout and clear all data
  Future<void> logout() async {
    // delete all data
    _uid = null;
    _isLoggedIn = false;
    await clearTempData();
    await reload();
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
