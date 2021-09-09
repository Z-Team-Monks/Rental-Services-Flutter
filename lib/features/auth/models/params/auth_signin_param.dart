class AuthParam {
  final String email;
  final String password;

  AuthParam({required this.email, required this.password});
}

class AuthSignInParam extends AuthParam {
  AuthSignInParam({required email, required password})
      : super(email: email, password: password);
}

class AuthSignUpParam extends AuthParam {
  final String username;

  AuthSignUpParam({required this.username, required email, required password})
      : super(email: email, password: password);
}
