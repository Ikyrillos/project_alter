// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:project_alter/config/db.config.dart';
import 'package:project_alter/handlers/sql_sanitizer.dart';
import 'package:project_alter/models/encryption.dart';

/// UsersManager class that handles all the user related methods
class UsersManager {
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
    // create a user object
    final user = User(
      username: username,
      email: email,
      password: PasswordHashing.hashPassword(
        password,
      ),
    );
    // save the user object to the database
    final passwordHash = PasswordHashing.hashPassword(password);
    // ignore: lines_longer_than_80_chars
    await pg.runTx(
      (c) => c.query(
        '''INSERT INTO users (username, password_digest, email) VALUES (@username, @password, @email)''',
        substitutionValues: {
          'username': username,
          'password': passwordHash,
          'email': email,
        },
      ),
    );
    // return the user object
    return left(user);
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
    final pgResult = await pg.runTx(
      (c) => c.query(
        // ignore: lines_longer_than_80_chars
        'SELECT * FROM users WHERE username = @username AND password_digest = @password AND email = @email',
        substitutionValues: {
          'username': username,
          'password': passHash,
          'email': email,
        },
      ),
    );

    final newUsername = pgResult[0][1] as String;
    final newEmail = pgResult[0][3] as String;
    // return Response(
    //   body: '{"error": ${data}}',
    //   statusCode: StatusCodes.BadRequest,
    // );
    // ));
    final userObj = User(
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
    final isUserExist = await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE username = @username',
        substitutionValues: {
          'username': username,
        },
      ),
    );
    if (isUserExist.isEmpty) {
      return false;
    }
    return true;
  }

  /// check user if already exists by email
  /// return true if user already exists
  Future<bool> isEmailAlreadyExist(String email) async {
    final isEmailExist = await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE email = @email',
        substitutionValues: {
          'email': email,
        },
      ),
    );
    if (isEmailExist.isEmpty) {
      return false;
    }
    return true;
  }
}

/// User class that represents a user object
/// that is stored in the database
class User {
  /// User constructor that takes in a username and password
  User({required this.username, required this.password, required this.email});

  String username;
  String password;
  String email;

  /// get user method that takes in a username and returns a user object
  static Future<String> getUser(String username) async {
    // get the user object from the database PgSQL
    final user = await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE username = @username',
        substitutionValues: {
          'username': username,
        },
      ),
    );
    // return the user object
    await pg.close();
    return user.first[0] as String;
  }

  /// save method that saves the user object to the database
  String toJson() {
    return '{"username": "$username", "password": "$password"}';
  }

  /// save method that saves the user object to the database
  Map<String, String> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
