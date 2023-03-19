// Create a json web token
// Pass the payload to be sent in the form of a map
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../constants/pg.dart';

final jwt = JWT(
  // Payload
  {
    'id': '1234567890',
    'server': {
      'id': '3e4fc296',
      'loc': 'euw-2',
    }
  },

  issuer: 'localhost/8080',
);

// Sign it (default with HS256 algorithm)
final token = jwt.sign(SecretKey(jwtSecret));
