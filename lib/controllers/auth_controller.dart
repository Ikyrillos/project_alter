import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:project_alter/config/db.config.dart';
import 'package:project_alter/config/jwt.dart';
import 'package:project_alter/models/httpCodes.dart';

/// This class is used to verify the token
class AuthController {
  /// This method is used to verify the token
  static Future<bool> verify(RequestContext context) async {
    try {
      final path = context.request.uri.path;
      final isAuth = path.contains('/auth/');
      // if (isAuth) return true;
      final token =
          context.request.headers['authorization']!.replaceAll('Bearer ', '');
      final isValid = JWTManager.verifyJwtSignature(token, jwtSecret);
      if (isValid) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
