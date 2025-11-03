// import 'package:flutter/material.dart';
// import '../services/encryption_services.dart';

// typedef ToJson<T> = Map<String, dynamic> Function(T model);
// typedef FromJson<T> = T Function(Map<String, dynamic> json);

// class EncryptionHelper {
//   /// Encrypts the specified string fields of the passed model.
//   /// - [toJson]: converts the model to Map.
//   /// - [enc]: instance of EncryptionService.
//   /// - [fields]: list of field names to encrypt (default ['title','content']).
//   static Future<Map<String, dynamic>> encryptModel<T>(
//     T model,
//     ToJson<T> toJson,
//     EncryptionService enc, {
//     List<String> fields = const ['title', 'content'],
//   }) async {
//     final base = Map<String, dynamic>.from(toJson(model));

//     for (final field in fields) {
//       final value = base[field];
//       if (value is String && value.isNotEmpty) {
//         final result = await enc.encryptText(value);
//         base[field] = result['cipher'];
//         base['${field}_iv'] = result['iv'];
//         base['${field}_mac'] = result['mac'];
//       }
//     }

//     return base;
//   }

//   /// Decrypts the specified string fields of the given map and returns a model instance
//   /// using [fromJson].
//   static T decryptModel<T>(
//     Map<String, dynamic> data,
//     FromJson<T> fromJson,
//     EncryptionService enc, {
//     List<String> fields = const ['title', 'content'],
//   }) {
//     final map = Map<String, dynamic>.from(data);
//     final decryptedMap = Map<String, dynamic>.from(data);

//     for (final field in fields) {
//       final cipher = map[field];
//       final iv = map['${field}_iv'];
//       final mac = map['mac'];
//       final value = decryptedMap[field];
//       if (value == null || value.isEmpty) {
//         // لو فاضي أو null، متحاولش تفك تشفيره
//         debugPrint("⚠️ Skip decrypt for field '$field' (null or empty)");
//         continue;
//       }
//       // only attempt decrypt if both cipher and iv exist and are strings
//       if (cipher is String && iv is String) {
//         try {
//           map[field] = enc.decryptText(cipher, iv, mac);
//         } catch (e, st) {
//           debugPrint('Failed to decrypt field $field: $e\n$st');
//           // keep original cipher if decryption fails, or set to empty string / null
//           // map[field] = null;
//         }
//       } else {
//         // nothing to do: field not encrypted (legacy/plain text) or incomplete metadata
//         map[field] = cipher;
//       }
//     }

//     return fromJson(map);
//   }
// }
