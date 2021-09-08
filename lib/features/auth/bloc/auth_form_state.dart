part of 'auth_form_bloc.dart';

class AuthFormState extends Equatable {
  final Email email;
  final Password password;
  final Username username;
  final FormzStatus status;
  final String? message;

  const AuthFormState(
      {this.username = const Username.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.message});

  AuthFormState copyWith(
      {Username? username,
      Email? email,
      Password? password,
      FormzStatus? status,
      String? message}) {
    return AuthFormState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [username, email, password, status];
}
