
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert';
// import 'package:cryptography/cryptography.dart';

// class EncryptionService {
//   // final String _rawKey =
//   //     'ABCDEFabcdef1234567890!@#\$%^&*()'; // 32 chars => AES-256

//   // EncryptionService() {
//   //   final key = encrypt.Key.fromUtf8(_rawKey);
//   //   _encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
//   // }

//   final _secureStorage = const FlutterSecureStorage();
//   final algorithm = AesGcm.with256bits();
//   static const _keyStorageKey = 'secret_key';

//   Future<SecretKey> _getOrCreateKey() async {
//     final savedKey = await _secureStorage.read(key: _keyStorageKey);
//     if (savedKey != null) {
//       final keyBytes = base64Decode(savedKey);
//       return SecretKey(keyBytes);
//     } else {
//       final newKey = await algorithm.newSecretKey();
//       final newKeyBytes = await newKey.extractBytes();
//       final key = base64Encode(newKeyBytes);

//       await _secureStorage.write(
//         key: _keyStorageKey,
//         value: key,
//       );
//       return newKey;
//     }
//   }

//   Future<Map<String, String>> encryptText(String plainText) async {
//     final secretKey = await _getOrCreateKey();

//     final iv = algorithm.newNonce(); // GCM recommended 12 bytes
//     final encrypted = await algorithm.encrypt(
//       utf8.encode(plainText),
//       secretKey: secretKey,
//       nonce: iv,
//     );
//     final cipher = base64Encode(encrypted.cipherText);
//     final ivBase64 = base64Encode(encrypted.nonce);
//     return {
//       'cipher': cipher,
//       'iv': ivBase64,
//       "mac": base64Encode(
//           encrypted.mac.bytes), // GCM recommended 16 bytes for authentication
//     };
//   }

//   Future<String> decryptText(
//       String cipherBase64, String ivBase64, String macBase64) async {
//     final secretKey = await _getOrCreateKey();
//     final cipherText = base64Decode(cipherBase64);
//     final iv = base64Decode(ivBase64);
//     final mac = Mac(base64Decode(macBase64));
//     final decrypted = SecretBox(
//       cipherText,
//       nonce: iv,
//       mac: mac,
//     );
//     final plainText = await algorithm.decrypt(decrypted, secretKey: secretKey);
//     return utf8.decode(plainText);
//   }
// }
