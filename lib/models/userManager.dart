// ignore_for_file: public_member_api_docs
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:project_alter/config/db.config.dart';
import 'package:project_alter/controllers/sql_sanitizer.dart';
import 'package:project_alter/data/local/database_impl.dart';
import 'package:project_alter/models/encryption.dart';
import 'package:project_alter/models/users.dart';
/// UsersManager class that handles all the user related methods
class UsersManager {
  DatabaseImpl database = DatabaseImpl();

  /// create user method that takes in a username and password
  /// and returns a user object
  Future<Either<User, Response>> createUser(
    String username,
    String password,
    String email,
  ) async {
    final isMalicious = sanitizeInput(username) ||
        sanitizeInput(password) ||
        sanitizeInput(email);
    if (isMalicious) {
      return right(
        Response.json(
          body: {'error': 'Invalid username or password'},
          statusCode: 401,
        ),
      );
    }
    // save the user object to the database
    final passwordHash = PasswordHashing.hashPassword(password);
    // ignore: lines_longer_than_80_chars
    final userResult =
        database.createUser(username, passwordHash, email, passwordHash);
    return userResult;
  }

  /// authenticate method that takes in a username and password
  /// and returns a user object
  Future<Either<User, Response>> authenticate(
    String username,
    String password,
    String email,
  ) async {
    final isMalicious = sanitizeInput(username);
    if (isMalicious) {
      return right(
        Response.json(
          body: {'error': 'Invalid username or password'},
          statusCode: 401,
        ),
      );
    }
    // get the username and pass hash object from the database
    final passHash = PasswordHashing.hashPassword(password);
    // check if the password hash matches the one in the database
    final pgResult = await database.authenticate(username, email, passHash);
    final newUsername = pgResult[0][1] as String;
    final newEmail = pgResult[0][3] as String;
    // create a user object
    final userObj = User(
      id: pgResult[0][0] as int,
      username: newUsername,
      password: passHash,
      email: newEmail,
    );

    // return the user object
    return left(userObj);
  }

  /// verifyAuthToken method that takes in a request object
  Future<Response> verifyAuthToken(Request req) async {
    // get the auth token from the request
    final authToken = req.headers['authorization']?.split(' ')[1];
    // check if the auth token is valid
    try {
      JWT.verify(
        authToken!,
        SecretKey(jwtSecret),
        issuer: env['ISSUER'],
      );
    } catch (e) {
      // return an error message
      return Response(
        body: '{"error": "Invalid auth token"}',
        statusCode: 401,
      );
    }
    // return an error message
    return Response(
      body: '{"error": "the auth token may be not found"}',
      statusCode: 401,
    );
  }

  /// check user if already exists by username
  Future<bool> isUserAlreadyExist(String username) async {
    final isUserExist = await database.isUserAlreadyExist(username);
    return isUserExist;
  }

  /// check user if already exists by email
  /// return true if user already exists
  Future<bool> isEmailAlreadyExist(String email) async {
    final status = await database.isEmailAlreadyExist(email);
    return status;
  }
}
