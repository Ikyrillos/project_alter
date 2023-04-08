/// User class that represents a user object
/// that is stored in the database
class User {
  /// User constructor that takes in a username and password
  User({
    required this.username,
    required this.password,
    required this.email,
    required this.id,
  });
  int id;
  String username;
  String password;
  String email;

  /// save method that saves the user object to the database
  String toJson() {
    return '{id: $id ,"username": "$username", "email": "$email"}';
  }

  /// save method that saves the user object to the database
  Map<String, String> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
