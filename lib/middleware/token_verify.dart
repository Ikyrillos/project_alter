import 'package:dart_frog/dart_frog.dart';
import 'package:jwt_decode/jwt_decode.dart' as jwtDecode;
import 'package:project_alter/controllers/auth_controller.dart';
import 'package:project_alter/models/httpCodes.dart';
import 'package:project_alter/models/userManager.dart';

/// This middleware is used to verify the token
Middleware tokenVerification() {
  return (handler) {
    return (context) async {
      final isVerified = await AuthController.verify(context);
      const route = 'auth';
      if (!context.request.uri.pathSegments.contains(route)) {
        final jwtToken = context.request.headers['authorization'];
        final token = jwtToken!.replaceAll('Bearer ', '');
        final decodedToken = jwtDecode.Jwt.parseJwt(token);
        final strEmail = decodedToken['email'] as String;
        final email = strEmail.trim();
        final userDB = UsersManager();
        print('email:$email');
        final isEMailValid = await userDB.isEmailAlreadyExist(email);
        if (isEMailValid == false) {
          return Response.json(
            statusCode: StatusCodes.Unauthorized,
            body: {'error': 'Unauthorized, invalid token'},
          );
        }
      }
      if (isVerified) {
        final response = await handler(context);
        return response;
      } else {
        return Response.json(
          statusCode: StatusCodes.Unauthorized,
          body: {'error': 'Unauthorized, invalid token'},
        );
      }
    };
  };
}
