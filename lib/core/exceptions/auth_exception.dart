abstract class AuthException {}

class IncorrectEmailOrPasswordException extends AuthException
    implements Exception {
  final String cause = "Incorrect Email Or Password";
}

class EmailAlreadyExistsException extends AuthException implements Exception {
  final String cause = "Email already in use";
}

class InvalidEmailAddressException extends AuthException implements Exception {
  final String cause = "Incorrect Email Or Password";
}

class PasswordLenthTooShort extends AuthException implements Exception {
  final String cause = "Password length must be greater than or equal to 6";
}
