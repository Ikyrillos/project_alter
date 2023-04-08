import 'package:dart_frog/dart_frog.dart';
import 'package:dartz/dartz.dart';
import 'package:postgres_pool/postgres_pool.dart';
import 'package:project_alter/config/db.config.dart';
import 'package:project_alter/data/local/database.dart';
import 'package:project_alter/models/users.dart';

/// Database implementation.
class DatabaseImpl extends DomainDatabase {
  @override
  Future<Either<User, Response>> createUser(
    String username,
    String password,
    String email,
    String passwordHash,
  ) async {
    String msg = '';
    try {
      final result = await pg.runTx(
        (c) => c.query(
          '''INSERT INTO users (username, password_digest, email) VALUES (@username, @password, @email)''',
          substitutionValues: {
            'username': username,
            'password': passwordHash,
            'email': email,
          },
        ),
      );
      final user = await getUserByEmail(email);
      return left(
        user,
      );
    } catch (e) {
      return right(
        Response.json(
          body: {'error': msg},
          statusCode: 401,
        ),
      );
    }
  }

  @override
  Future<User> getUser(String username) async {
    final pgResult = await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE username = @username',
        substitutionValues: {
          'username': username,
        },
      ),
    );
    final user = User(
      id: pgResult[0][0] as int,
      username: pgResult[0][1] as String,
      email: pgResult[0][3] as String,
      password: pgResult[0][2] as String,
    );
    return user;
  }

  @override
  Future<User> getUserByEmail(String email) async {
    final pgResult = await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE email = @email',
        substitutionValues: {
          'email': email,
        },
      ),
    );
    final user = User(
      id: pgResult[0][0] as int,
      username: pgResult[0][1] as String,
      email: pgResult[0][3] as String,
      password: pgResult[0][2] as String,
    );
    return user;
  }

  @override
  Future<User> getUserById(int id) async {
    final pgResult = await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE id = @id',
        substitutionValues: {
          'id': id,
        },
      ),
    );
    final user = User(
      id: pgResult[0][0] as int,
      username: pgResult[0][1] as String,
      email: pgResult[0][3] as String,
      password: pgResult[0][2] as String,
    );
    return user;
  }

  @override
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

  @override
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

  @override
  Future<PostgreSQLResult> authenticate(
    String username,
    String email,
    String password,
  ) async {
    final pgResult = await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE username = @username OR email = @email',
        substitutionValues: {
          'username': username,
          'email': email,
        },
      ),
    );
    return pgResult;
  }
}
