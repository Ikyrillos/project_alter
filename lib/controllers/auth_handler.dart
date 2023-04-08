// ignore_for_file: parameter_assignments

import 'package:dart_frog/dart_frog.dart';
import 'package:project_alter/config/jwt.dart';
import 'package:project_alter/models/httpCodes.dart';
import 'package:project_alter/models/userManager.dart';
/// authenticateHandler
Future<Response?> authenticateHandler(
  UsersManager usersManager,
  String username,
  String password,
  String email,
  Response? response,
) async {
  try {
    await usersManager.authenticate(username, password, email).then(
      (value) async {
        value.fold(
          (l) {
            final token = JWTManager.getJWT(username, email);
            response = Response.json(
              body: {
                'message': StatusCodes.getMessage(StatusCodes.OK),
                'token': token,
                'user': l.toJson()
              },
            );
          },
          (r) {
            response = Response.json(
              body: {'error': '${r.headers}'},
              statusCode: 401,
            );
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
