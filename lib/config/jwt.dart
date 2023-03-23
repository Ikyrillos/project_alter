// ignore_for_file: avoid_dynamic_calls
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:project_alter/config/db.config.dart';

/// jwtSecret is a string from .env file
class JWTManager {
  /// Singleton
  factory JWTManager() => _instance;
  JWTManager._internal();
  static final JWTManager _instance = JWTManager._internal();

  /// method to get JWT
  static String getJWT(String username, String email) {
    final jwt = JWT(
      // Payload
      {
        'username': username,
        'email': email,
        'server': {
          'id': '3e4fc296',
          'loc': 'euw-2',
        }
      },

      issuer: 'localhost/8080',
    );
    return jwt.sign(SecretKey(jwtSecret), expiresIn: const Duration(days: 1));
  }

  /// method to verify JWT signature
  static bool verifyJwtSignature(String jwt, String secret) {
    final parts = jwt.split('.');
    if (parts.length != 3) {
      return false;
    }
    final header = parts[0];
    final payload = parts[1];
    final signature = parts[2];
    final unsignedToken = '$header.$payload';
    final hmac = Hmac(sha256, utf8.encode(secret));
    final digest = hmac.convert(utf8.encode(unsignedToken));
    final calculatedSignature = base64Url.encode(digest.bytes);
    final result = signature == calculatedSignature.replaceAll('=', '');
    return result;
  }
}
