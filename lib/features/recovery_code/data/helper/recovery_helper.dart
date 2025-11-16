import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

class RecoveryHelper {
  final Pbkdf2 _pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 200000,
    bits: 256,
  );

  String generateRecoveryCode(
      [int length = 24, int groupSize = 6, String separator = '_']) {
    final random = Random.secure();
    final data = List<int>.generate(length, (_) => random.nextInt(256));
    final code = base64UrlEncode(data).replaceAll('=', '');
    final group = <String>[];
    for (var i = 0; i < code.length; i += groupSize) {
      group.add(code.substring(
          i, i + groupSize > code.length ? code.length : i + groupSize));
    }
    return group.join(separator);
  }

  List<int> generateSalt([int length = 16]) {
    final random = Random.secure();
    return List<int>.generate(length, (_) => random.nextInt(256));
  }

  Future<SecretKey> deriveRecoveryKey(
      {required String recoveryCode,
      required List<int> salt,
      String separator = '_'}) async {
    final normalizedCode = recoveryCode.replaceAll('_', '');
    final secretKey = await _pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(normalizedCode)),
      nonce: salt,
    );
    return secretKey;
  }
}
