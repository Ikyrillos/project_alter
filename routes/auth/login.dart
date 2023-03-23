// ignore_for_file: parameter_assignments

import 'package:dart_frog/dart_frog.dart';
import 'package:project_alter/config/jwt.dart';
import 'package:project_alter/handlers/auth_input_handler.dart';
import 'package:project_alter/models/httpCodes.dart';
import 'package:project_alter/models/users.dart';

Future<Response?> onRequest(RequestContext context) async {
  final usersManager = UsersManager();
  final request = context.request;
  Response? response;
  // change method to POST
  if (request.method.value != 'POST') {
    return Response.json(
      body: {'error': 'Method not allowed'},
      statusCode: 405,
    );
  }

  final formData = await request.formData();
  final username = formData.fields['username'];
  final password = formData.fields['password'];
  final email = formData.fields['email'];
  if (!isInputValid(username, password, email)) {
    return Response.json(
      body: {'error': 'Username and password required'},
      statusCode: 400,
    );
  }

  return authenticateHandler(
    usersManager,
    username!,
    password!,
    email!,
    response,
  );
}

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
