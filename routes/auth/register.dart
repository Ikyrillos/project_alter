import 'dart:developer';
import 'package:dart_frog/dart_frog.dart';
import 'package:project_alter/config/db.config.dart';
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
        body: {'error': 'Method not allowed'}, statusCode: 405);
  }

  final formData = await request.formData();
  final username = formData.fields['username'];
  final password = formData.fields['password'];
  final email = formData.fields['email'];
  if (!isInputValid(username, password, email)) {
    return Response.json(
      body: {'error': 'Username, password and email are required'},
      statusCode: 400,
    );
  }

  if (await usersManager.isUserAlreadyExist(username!) ||
      await usersManager.isEmailAlreadyExist(email!)) {
    final message = await usersManager.isUserAlreadyExist(username)
        ? 'Username already exist'
        : 'Email already exist';
    return Response.json(body: {'error': message}, statusCode: 400);
  }

  try {
    await usersManager.createUser(username, password!, email!).then((value) {
      final token = JWTManager.getJWT(username, email);
      log('value: $jwtSecret');
      response = Response.json(
        body: {
          'message': StatusCodes.getMessage(StatusCodes.Created),
          'token': token
        },
        statusCode: StatusCodes.Created,
      );
    });
  } catch (e) {
    response = Response.json(body: {'error': e.toString()}, statusCode: 500);
  }
  return response;
}
