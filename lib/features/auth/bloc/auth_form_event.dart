part of 'auth_form_bloc.dart';

abstract class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends AuthFormEvent {
  const UsernameChanged({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class UsernameUnfocused extends AuthFormEvent {}

class EmailChanged extends AuthFormEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends AuthFormEvent {}

class PasswordChanged extends AuthFormEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends AuthFormEvent {}

class LoginFormSubmitted extends AuthFormEvent {}

class SignUpFormSubmitted extends AuthFormEvent {}
