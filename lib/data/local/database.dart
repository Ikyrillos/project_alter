import 'package:dart_frog/dart_frog.dart';
import 'package:dartz/dartz.dart';
import 'package:postgres_pool/postgres_pool.dart';
import 'package:project_alter/models/users.dart';

///  This file is part of the domain library
abstract class DomainDatabase {
  ///  This method is used to create a user
  Future<Either<User,Response>> createUser(
      String username, String password, String email, String passwordHash);

  ///  This method is used to authenticate a user
  Future<bool> isUserAlreadyExist(String username);

  /// This method is used to authenticate a user
  Future<PostgreSQLResult> authenticate(String username,String email, String password);
  ///  This method is used to check if an email is already in use
  Future<bool> isEmailAlreadyExist(String email);

  ///  This method is used to get a user by username
  Future<User> getUser(String username);

  ///  This method is used to get a user by email
  Future<User> getUserByEmail(String email);

  ///  This method is used to get a user by id
  Future<User> getUserById(int id);

  ///  This method is used to update a user
  // Future<bool> updateUser(String username, String password, String email);
}
