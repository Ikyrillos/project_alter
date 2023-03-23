// ignore_for_file: avoid_dynamic_calls
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
      issuer: env['jwtSecret'],
    );
    return jwt.sign(SecretKey(jwtSecret), expiresIn: const Duration(days: 1));
  }

  /// method to verify JWT signature
  static bool verifyJwtSignature(String jwt, String secret) {
    final verify = JWT.tryVerify(jwt, SecretKey(jwtSecret));
    // ignore: avoid_bool_literals_in_conditional_expressions
    final result = verify != null ? true : false;
    return result;
  }
}
