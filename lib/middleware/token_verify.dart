import 'package:dart_frog/dart_frog.dart';
import 'package:project_alter/controllers/auth_controller.dart';
import 'package:project_alter/models/httpCodes.dart';

Middleware tokenVerification() {
  return (handler) {
    return (context) async {
      final isVerified = await AuthController.verify(context);
      if (isVerified) {
        final response = await handler(context);
        return response;
      } else {
        return Response.json(
          statusCode: StatusCodes.Unauthorized,
          body: {'error': 'Unauthorized'},
        );
      }
    };
  };
}
