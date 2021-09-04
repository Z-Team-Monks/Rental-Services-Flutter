part of 'signup_form_bloc.dart';

abstract class SignUpFormEvent extends Equatable {
  const SignUpFormEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends SignUpFormEvent {
  const UsernameChanged({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class UsernameUnfocused extends SignUpFormEvent {}

class EmailChanged extends SignUpFormEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends SignUpFormEvent {}

class PasswordChanged extends SignUpFormEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends SignUpFormEvent {}

class FormSubmitted extends SignUpFormEvent {}
