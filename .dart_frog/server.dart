// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/register.dart' as register;
import '../routes/login.dart' as login;
import '../routes/index.dart' as index;


void main() => hotReload(createServer);

Future<HttpServer> createServer() {
  final address = InternetAddress.anyIPv6;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/register', (context) => register.onRequest(context,))..all('/login', (context) => login.onRequest(context,))..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}
