import 'dart:async';
import '../constants/app_constants.dart';
import '../helper/cache_helper.dart';
import '../helper/secure_storage_helper.dart';

/// Singleton Service لإدارة حالة التطبيق والبيانات المؤقتة
/// يستخدم لتخزين البيانات اللي محتاجها في أكتر من مكان أثناء تشغيل التطبيق
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
  // Stream للإشعار بالتغييرات
  // ═══════════════════════════════════════════════════════════
  final _onChangeController = StreamController<AppSession>.broadcast();
  Stream<AppSession> get changes => _onChangeController.stream;

  // ═══════════════════════════════════════════════════════════
  // بيانات الحالة (Session Data)
  // ═══════════════════════════════════════════════════════════

  // بيانات مؤقتة (تتمسح عند إغلاق التطبيق)
  bool isOnline = false;
  String? currentScreen;
  Map<String, dynamic>? tempData;

  // بيانات محفوظة (من Cache)
  String? _uid;
  String? _userEmail;
  String? _userName;
  bool _isAutoBackupAndSync = false;
  bool _isLoggedIn = false;

  // بيانات Recovery
  String? pendingRecoveryCode;
  bool? isSameDevice;

  // ═══════════════════════════════════════════════════════════
  // Getters
  // ═══════════════════════════════════════════════════════════
  String? get uid => _uid;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  bool get isAutoBackupAndSync => _isAutoBackupAndSync;
  bool get isLoggedIn => _isLoggedIn;

  // ═══════════════════════════════════════════════════════════
  // Initialization من Cache
  // ═══════════════════════════════════════════════════════════
  Future<void> _initializeFromCache() async {
    _uid = await SecureStorageHelper.read(key: AppConstants.uid) ?? null;
    _isAutoBackupAndSync =
        CacheHelper.getData(key: AppConstants.isAutoBackupAndSync) ?? false;
    _isLoggedIn = CacheHelper.getData(key: AppConstants.isLoggedIn) ?? false;

    _notifyChanges();
  }

  // ═══════════════════════════════════════════════════════════
  // Setters مع حفظ في Cache
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
  // بيانات مؤقتة (بدون Cache)
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

  /// مسح البيانات المؤقتة فقط
  Future<void> clearTempData() async {
    currentScreen = null;
    tempData = null;
    pendingRecoveryCode = null;
    isSameDevice = null;
    await SecureStorageHelper.delete(key: AppConstants.uid);
    await CacheHelper.deleteData(key: AppConstants.isLoggedIn);
    _notifyChanges();
  }

  /// تسجيل الخروج (مسح كل شيء)
  Future<void> logout() async {
    // مسح من الذاكرة
    _uid = null;
    _userEmail = null;
    _userName = null;
    _isLoggedIn = false;
    await clearTempData();

    // مسح من Cache

    _notifyChanges();
  }

  /// مسح كل البيانات (حتى الإعدادات)
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

  /// إعادة تحميل البيانات من Cache
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
      email: $_userEmail,
      name: $_userName,
      isLoggedIn: $_isLoggedIn,
      isOnline: $isOnline,
      isAutoBackup: $_isAutoBackupAndSync,
    }
    ''';
  }
}
