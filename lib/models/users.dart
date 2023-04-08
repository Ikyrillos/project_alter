// ignore_for_file: public_member_api_docs
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
    return '{id: $id ,username: $username, email: $email}';
  }

  /// save method that saves the user object to the database
  Map<String, String> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}
