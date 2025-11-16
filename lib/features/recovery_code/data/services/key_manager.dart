import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../../../core/helper/device_info_helper.dart';
import '../../../../core/services/app_session.dart';
import '../helper/recovery_helper.dart';
import '../models/key_meta_data_model.dart';
import '../models/upload_wrapped_master_key.dart';

class KeyManager {
  final appSession = AppSession.instance;
  String get _uid {
    final uid = appSession.uid;
    if (uid == null || uid.isEmpty) return 'No uid available';
    return uid;
  }

  // ********************* Services ********************* //
  final _firestore = FirebaseFirestore.instance;
  final _secureStorage = const FlutterSecureStorage();
  final _algo = AesGcm.with256bits();
  final _recoveryHelper = RecoveryHelper();
  final _deviceInfo = DeviceInfoHelper();

  // ********************* Storage Keys ********************* //
  static const _deviceStorageKey = AppConstants.deviceStorageKey;
  static const _pendingRecoveryKey = AppConstants.pendingRecoveryCode;

  // ********************* Firestore References ********************* //
  final _userCollection = AppConstants.userCollection;
  final _keysCollection = AppConstants.keysCollection;

  CollectionReference get _keysCol => _firestore
      .collection(_userCollection)
      .doc(_uid)
      .collection(_keysCollection);
  DocumentReference get _metaDoc =>
      _firestore.collection(_userCollection).doc(_uid);

  // ********************* Device Info ********************* //
  Future<String> get _deviceId async => await _deviceInfo.getDeviceId();
  Future<String> get _deviceName async => await _deviceInfo.getDeviceName();

  // ********************* Init or Get Device Key and delete after use ********************* //
  Future<SecretKey> _initOrGetDeviceKey() async {
    final savedKey = await _secureStorage.read(key: _deviceStorageKey);
    if (savedKey != null) return SecretKey(base64Decode(savedKey));

    final newKey = await _algo.newSecretKey();
    final newKeyBytes = await newKey.extractBytes();
    await _secureStorage.write(
      key: _deviceStorageKey,
      value: base64Encode(newKeyBytes),
    );
    return newKey;
  }

  Future<void> _deleteDeviceKey() async =>
      await _secureStorage.delete(key: _deviceStorageKey);

  // ********************* Wrap helper ********************* //
  Future<void> _wrapAndUpload({
    required List<int> masterKeyBytes,
    required SecretKey wrappingKey,
    required String method, // 'device' | 'recovery'
    required String deviceId,
    required String deviceName,
    List<int>? salt,
  }) async {
    final nonce = _algo.newNonce();
    final secretBox = await _algo.encrypt(masterKeyBytes,
        secretKey: wrappingKey, nonce: nonce);

    final docModel = UploadWrappedMasterKey(
      uid: _uid,
      method: method,
      deviceId: deviceId,
      deviceName: deviceName,
      wrappedMaster: base64Encode(secretBox.cipherText),
      nonce: base64Encode(nonce),
      mac: base64Encode(secretBox.mac.bytes),
    );
    if (salt != null) {
      docModel.salt = base64Encode(salt);
    }
    // log('[WRAP] _wrapAndUpload called. method=$method deviceId=$deviceId saltProvided=${salt != null}');
    // log('[WRAP] Encrypted master: ciphertextLength=${secretBox.cipherText.length}, nonceLength=${nonce.length}, macLength=${secretBox.mac.bytes.length}');
    await _keysCol.add(docModel.toJson());
    // log('[WRAP] _wrapAndUpload done.');
  }

  // ------------------ KeyMetadata management
  Future<KeyMetadataModel?> getKeyMetadata() async {
    final docSnap = await _metaDoc.get();
    if (!docSnap.exists) return null;

    final data = docSnap.data() as Map<String, dynamic>?;
    if (data == null) return null;

    // Check if metadata fields exist
    if (!data.containsKey('master_created')) return null;

    return KeyMetadataModel.fromJson(data);
  }

  Future<void> _saveAndPushKeyMetadata(KeyMetadataModel metadataModel) async {
    await _metaDoc.set(metadataModel.toJson(), SetOptions(merge: true));
  }

  // ********************* Create master key ********************* //
  Future<String?> createMasterAndUploadKey({bool createRecovery = true}) async {
    if (await hasWrappedKeys()) {
      // log('[SKIP] Master key already created. Aborting createMasterAndUploadKey.');
      return null;
    }
    // create the master key
    final masterKey = await _algo.newSecretKey();
    final masterKeyBytes = await masterKey.extractBytes();

    // get device info
    final deviceId = await _deviceId;
    final deviceName = await _deviceName;

    // get or generate device key
    final deviceKey = await _initOrGetDeviceKey();

    await _wrapAndUpload(
        masterKeyBytes: masterKeyBytes,
        wrappingKey: deviceKey,
        method: 'device',
        deviceId: deviceId,
        deviceName: deviceName);

    // save meta data and push
    final metadata = KeyMetadataModel(
      masterCreated: true,
      masterCreatorDeviceId: deviceId,
      recoveryShown: false,
      masterCreatedAt: DateTime.now().toIso8601String(),
    );
    await _saveAndPushKeyMetadata(metadata);

    // create recovery code
    if (createRecovery) {
      final recoveryCode =
          await _createRecoveryCodeAndUpload(masterKey: masterKey);
      appSession.setPendingRecoveryCode(recoveryCode);
      // log('[CREATE] Created recovery code: ${appSession.pendingRecoveryCode}');
      await _secureStorage.write(key: _pendingRecoveryKey, value: recoveryCode);
      return recoveryCode;
    }
    return null;
  }

  //********************* Create recovery code ********************* //
  Future<String> _createRecoveryCodeAndUpload(
      {required SecretKey masterKey}) async {
    // create recovery code
    final recoveryCode = _recoveryHelper.generateRecoveryCode();
    // create salt
    final salt = _recoveryHelper.generateSalt();
    // generate recovery key
    final recoveryKey = await _recoveryHelper.deriveRecoveryKey(
        recoveryCode: recoveryCode, salt: salt);

    // extract master key bytes
    final masterKeyBytes = await masterKey.extractBytes();

    // get device info
    final deviceId = await _deviceId;
    final deviceName = await _deviceName;

    await _wrapAndUpload(
        masterKeyBytes: masterKeyBytes,
        wrappingKey: recoveryKey,
        method: 'recovery',
        deviceId: deviceId,
        deviceName: deviceName,
        salt: salt);

    return recoveryCode;
  }

  // ******************** Get pending recovery code from local secure storage (to display)
  Future<String?> getPendingRecoveryCode() async =>
      await _secureStorage.read(key: _pendingRecoveryKey);

  // ******************** mark recovery seen (user confirmed they saved it)
  Future<void> markRecoverySeen({String? acknowledgedByDeviceId}) async {
    // get the device id or use what come from the parameter
    final deviceId = acknowledgedByDeviceId ?? await _deviceId;
    // get current meta data
    final currentMeta = await getKeyMetadata();
    if (currentMeta != null) {
      // update the meta that the user show the recovery code by this device id and at ...
      final updateMeta = currentMeta.copyWith(
          recoveryShownByDeviceId: deviceId,
          recoveryShown: true,
          recoveryShownAt: DateTime.now().toIso8601String());
      // save and push the updated meta
      _saveAndPushKeyMetadata(updateMeta);
      // remove the recovery key from this key
      appSession.setPendingRecoveryCode(null);
      _secureStorage.delete(key: _pendingRecoveryKey);
    } else {
      return;
    }
  }

  Future<bool> get _hasWrappedKeys async => await hasWrappedKeys();

  // ******************** check if we should show recovery view on THIS device
  Future<bool> shouldShowRecoveryView() async {
    // get device id
    final deviceId = await _deviceId;
    // get meta data if exist
    final metaData = await getKeyMetadata();
    final hasWrappedKeys = await _hasWrappedKeys;
    if (metaData == null || !hasWrappedKeys)
      return true; // this is mean that there is no master key created
    // get the pending code
    final pending = await getPendingRecoveryCode();
    // check if is the same device and the show recovery code is false and the pending is still still store
    final needsDisplay = metaData.needsRecoveryDisplay(deviceId);
    final hasPending = pending != null && pending.isNotEmpty;
    final shouldShow = needsDisplay && hasPending;
    appSession.setShouldShowRecoveryView(shouldShow);
    return shouldShow;
  }

  // un wrap method to the master key
  Future<SecretKey> _unwrapKey({
    required String nonce,
    required String mac,
    required String wrappedMaster,
    required SecretKey secretKey,
  }) async {
    final nonceBox = base64Decode(nonce);
    final macBox = Mac(base64Decode(mac));
    final cipher = base64Decode(wrappedMaster);
    final secretBox = SecretBox(cipher, nonce: nonceBox, mac: macBox);
    final masterBytes = await _algo.decrypt(secretBox, secretKey: secretKey);
    final masterKey = SecretKey(masterBytes);
    return masterKey;
  }

  // ******************** unwrap with deviceKey (fast path)
  Future<SecretKey?> unwrapWithDeviceKey({String? deviceId}) async {
    // get the stored device key
    final savedDeviceKey = await _secureStorage.read(key: _deviceStorageKey);
    if (savedDeviceKey == null) return null;
    // get the device key
    final deviceKey = SecretKey(base64Decode(savedDeviceKey));
    // get the device id
    deviceId ??= await _deviceId;
    // get the query from the data when the method is device and the device id is the same as the current device
    final query = await _keysCol
        .where('method', isEqualTo: 'device')
        .where('device_id', isEqualTo: deviceId)
        .get();
    // check if the docs is not empty
    if (query.docs.isEmpty) return null;
    // get the first document
    final document = query.docs.first.data() as Map<String, dynamic>;
    final unwrappedModel = UploadWrappedMasterKey.fromJson(document);
    try {
      final masterKey = await _unwrapKey(
          nonce: unwrappedModel.nonce,
          mac: unwrappedModel.mac,
          wrappedMaster: unwrappedModel.wrappedMaster,
          secretKey: deviceKey);
      return masterKey;
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> clearLocalMetadata() async {
    await _secureStorage.delete(key: _pendingRecoveryKey);
    appSession.setPendingRecoveryCode(null);
    await _secureStorage.delete(key: _deviceStorageKey);
    CacheHelper.deleteData(key: AppConstants.shouldShowRecoveryView);
    // log('[DEV] Cleared local secure storage metadata.');
  }

  /// DEV ONLY - clears keys collection, metadata doc and local secure storage keys
  Future<void> clearAllKeysAndMetadata() async {
    // 1) delete keys docs in users/{_uid}/keys
    await clearLocalMetadata();
    try {
      final q = await _keysCol.get();
      for (final doc in q.docs) {
        await _keysCol.doc(doc.id).delete();
        // log('[CLEANUP] Deleted key doc id=${doc.id}');
      }
      // 3) clear local secure storage entries we use
      // Delete metadata from user doc
      await _metaDoc.set({
        'master_created': FieldValue.delete(),
        'master_creator_device_id': FieldValue.delete(),
        'recovery_shown': FieldValue.delete(),
        'recovery_shown_by_device_id': FieldValue.delete(),
        'master_created_at': FieldValue.delete(),
        'recovery_shown_at': FieldValue.delete(),
      }, SetOptions(merge: true));
      await _secureStorage.delete(key: _deviceStorageKey);
      await _secureStorage.delete(key: _pendingRecoveryKey);
      appSession.setPendingRecoveryCode(null);
      // log('[CLEANUP] Cleared local secure storage keys: $_deviceStorageKey, $_pendingRecoveryKey');
    } catch (e) {}
  }

  // ******************** unwrap with recovery code (search recovery docs)
  Future<SecretKey?> unwrapWithRecovery({required String recoveryCode}) async {
    // get the query from the data when the method is recovery
    final query = await _keysCol.where('method', isEqualTo: 'recovery').get();
    for (final doc in query.docs) {
      final document = doc.data() as Map<String, dynamic>;
      final unwrappedModel = UploadWrappedMasterKey.fromJson(document);
      if (unwrappedModel.salt == null) continue;
      final salt = base64Decode(unwrappedModel.salt!);
      final recoveryKey = await _recoveryHelper.deriveRecoveryKey(
          recoveryCode: recoveryCode, salt: salt);
      try {
        final masterKey = await _unwrapKey(
            nonce: unwrappedModel.nonce,
            mac: unwrappedModel.mac,
            wrappedMaster: unwrappedModel.wrappedMaster,
            secretKey: recoveryKey);
        return masterKey;
      } catch (e) {
        // continue to next
        continue;
      }
    }
    return null;
  }

  // ********************
  // return device id publicly
  Future<String> getDeviceIdPublic() async => await _deviceInfo.getDeviceId();

// check if any wrapper docs exist in users/{_uid}/keys
  Future<bool> hasWrappedKeys() async {
    final q = await _keysCol.limit(1).get();
    return q.docs.isNotEmpty;
  }

  Future<UploadWrappedMasterKey> _getDeviceWrapperForCurrentDevice() async {
    final deviceId = await _deviceId;
    final query = await _keysCol
        .where('method', isEqualTo: 'device')
        .where('device_id', isEqualTo: deviceId)
        .get();
    if (query.docs.isEmpty) return UploadWrappedMasterKey.empty();
    final document = query.docs.first.data() as Map<String, dynamic>;
    // log('[getDeviceWrapperForCurrentDevice] document=$document');
    return UploadWrappedMasterKey.fromJson(document);
  }

  Future<bool> performStartupChecks() async {
    final meta = await getKeyMetadata();
    if (meta == null) return false;
    final deviceId = await _deviceId;
    final deviceName = await _deviceName;
    final hasWrappedKeys = await _hasWrappedKeys;
    if (!hasWrappedKeys) return false;
    final deviceWrapper = await _getDeviceWrapperForCurrentDevice();
    bool shouldShow;
    if (meta.masterCreatorDeviceId == deviceId) {
      shouldShow = !meta.recoveryShown;
    } else {
      shouldShow = deviceWrapper.deviceId.isEmpty ||
          deviceWrapper.deviceName != deviceName;
    }
    await appSession.setShouldShowRecoveryView(shouldShow);
    return shouldShow;
  }

  Future<bool> isSameUser() async {
    final deviceId = await _deviceInfo.getDeviceId();
    // log('[isSameUser] deviceId=$deviceId');
    final meta = await getKeyMetadata();
    // log('[isSameUser] meta=$meta');
    final hasWrappedKeys = await _hasWrappedKeys;
    // log('[isSameUser] hasWrappedKeys=$hasWrappedKeys');
    if (meta == null) return false;
    if (hasWrappedKeys == false) return false;
    // log("deviceIdFromMeta=${meta.masterCreatorDeviceId}");
    final isSame = meta.masterCreatorDeviceId == deviceId;
    return isSame;
  }

  // get the device id from firestore and check if it the same as the local device id
  Future<bool> get isSameDevice async => await _isDeviceIdSame();
  Future<bool> _isDeviceIdSame() async {
    final deviceId = await _deviceInfo.getDeviceId();
    final meta = await getKeyMetadata();
    if (meta == null) return false;
    final isSame = meta.masterCreatorDeviceId == deviceId;
    appSession.setIsSameDevice(isSame);
    return isSame;
  }

  // ******************** onboard device after recovery: create deviceKey_B locally and upload device wrapper for B
  Future<SecretKey> onboardDeviceAfterRecovery({
    required SecretKey masterKey,
  }) async {
    final deviceName = await _deviceName;
    final deviceId = await _deviceId;
    final deviceKey = await _algo.newSecretKey();
    final bytes = await deviceKey.extractBytes();

    await _secureStorage.write(
      key: _deviceStorageKey,
      value: base64Encode(bytes),
    );

    final masterBytes = await masterKey.extractBytes();

    await _wrapAndUpload(
      masterKeyBytes: masterBytes,
      wrappingKey: deviceKey,
      method: 'device',
      deviceId: deviceId,
      deviceName: deviceName,
    );

    // log('[ONBOARD] Device onboarded successfully. deviceId=$deviceId');

    return deviceKey;
  }

  /// DEV ONLY: delete recovery wrappers that have no salt (legacy broken docs)
  Future<int> deleteRecoveryWrappersWithoutSalt() async {
    final q = await _keysCol.where('method', isEqualTo: 'recovery').get();
    int deleted = 0;
    for (final doc in q.docs) {
      final d = doc.data() as Map<String, dynamic>;
      if (d['salt'] == null ||
          (d['salt'] is String && (d['salt'] as String).isEmpty)) {
        await _keysCol.doc(doc.id).delete();
        // log('[CLEANUP] Deleted legacy recovery doc id=${doc.id}');
        deleted++;
      }
    }
    // log('[CLEANUP] Deleted $deleted legacy recovery docs without salt.');
    return deleted;
  }
}
