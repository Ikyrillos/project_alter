import '../config/db.config.dart';
import 'encryption.dart';

class UsersManager {
  // create user method that takes in a username and password
  // and returns a user object
  Future<User> createUser(String username, String password) async {
    // create a user object
    final user = User(
      username: username,
      password: PasswordHashing.hashPassword(
        password,
      ),
    );
    // save the user object to the database
    await user.save();
    // return the user object
    return user;
  }

  // login method that takes in a username and password
  // and returns a user object
  Future<User> login(String username, String password) async {
    // get the username and pass hash object from the database
    final user = await User.getUser(username);
    final passHash = await PasswordHashing.hashPassword(password);
    // check if the password hash matches the one in the database
    await pg.runTx(
      (c) => c.query(
        'SELECT * FROM users WHERE username = @username AND password_hash = @password',
        substitutionValues: {
          'username': username,
          'password': passHash,
        },
      ),
    );

    final userObj = User(username: username, password: passHash);

    // return the user object
    return userObj;
  }
}

class User {
  User({required this.username, required this.password});

  String username;
  String password;

  // save method that saves the user object to the database
  Future<void> save() async {
    // save the user object to the database PgSQL
    await pg.runTx((c) => c.query(
          'INSERT INTO users (username, password_hash) VALUES (@username, @password)',
          substitutionValues: {
            'username': username,
            'password': password,
          },
        ));
  }

  // get user method that takes in a username and returns a user object
  static Future<String> getUser(String username) async {
    // get the user object from the database PgSQL
    final user = await pg.runTx((c) => c.query(
          'SELECT * FROM users WHERE username = @username',
          substitutionValues: {
            'username': username,
          },
        ));
    // return the user object
    return user.first[0] as String;
  }
}
