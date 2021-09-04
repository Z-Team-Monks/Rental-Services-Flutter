part of 'signup_form_bloc.dart';

class SignUpFormState extends Equatable {
  final Email email;
  final Password password;
  final Username username;
  final FormzStatus status;

  const SignUpFormState(
      {this.username = const Username.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  SignUpFormState copyWith(
      {Username? username,
      Email? email,
      Password? password,
      FormzStatus? status}) {
    return SignUpFormState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
