import 'package:dart_frog/dart_frog.dart';
import 'package:project_alter/middleware/token_verify.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(tokenVerification());
}
