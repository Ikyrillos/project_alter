
/// isInputValid method that takes in a username and password
bool isInputValid(String? username, String? password, String? email) {
  final isNotExist = (username == null || username.isEmpty) ||
      (password == null || password.isEmpty) ||
      (email == null || email.isEmpty);

  return !isNotExist;
}
