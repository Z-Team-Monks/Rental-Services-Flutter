part of 'signin_form_bloc.dart';

class SignInFormState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? message;

  const SignInFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.message});

  SignInFormState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? message}) {
    return SignInFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [email, password, status];
}
