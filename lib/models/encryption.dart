import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// This class is used to hash and verify passwords
class PasswordHashing {
  /// this method hashes a password
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// this method verifies a password
  static bool verifyPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }

  /// this method generates a salt
  static String generateSalt() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  // static String hashPasswordWithSalt(String password, String salt) {
  //   final bytes = utf8.encode(password + salt);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }
}
