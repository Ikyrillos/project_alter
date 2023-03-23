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
}
