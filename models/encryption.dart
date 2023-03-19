import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class PasswordHashing {
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verifyPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }

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
