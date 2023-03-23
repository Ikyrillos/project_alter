// ignore_for_file: parameter_assignments
import 'package:dart_frog/dart_frog.dart';
import 'package:project_alter/controllers/auth_handler.dart';
import 'package:project_alter/controllers/auth_input_handler.dart';
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
