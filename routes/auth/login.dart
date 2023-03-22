import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../../config/db.config.dart';
import '../../config/jwt.dart';
import '../../models/httpCodes.dart';
import '../../models/users.dart';

Future<Response?> onRequest(RequestContext context) async {
  final usersManager = UsersManager();
  final request = context.request;
  Response? response;
  // change method to POST
  if (request.method.value != 'POST') {
    return Response.json(
        body: {'error': 'Method not allowed'}, statusCode: 405);
  }

  final formData = await request.formData();
  final username = formData.fields['username'];
  final password = formData.fields['password'];

  if (username == null || password == null) {
    return Response.json(
        body: {'error': 'Username and password required'}, statusCode: 400);
  }

  try {
    await usersManager.login(username, password).then(
      (value) {
        final token =
            jwt.sign(SecretKey(jwtSecret), expiresIn: const Duration(days: 1));
        response = Response.json(
          body: {
            'message': StatusCodes.getMessage(StatusCodes.OK),
            'token': token,
          },
        );
      },
    ).onError((error, stackTrace) {
      response = Response.json(
        body: {'error': 'Invalid username or password'},
        statusCode: 401,
      );
    });
  } catch (e) {
    response = Response.json(body: {'error': e.toString()}, statusCode: 500);
  }
  return response;
}
