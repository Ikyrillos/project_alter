import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final json = <String, dynamic>{};
  json['name'] = 'Dart Frog';
  json['version'] = '0.0.1';

  return Response.json(
      body: json,
      statusCode: 200,
      headers: {'Content-Type': 'application/json'});
}
