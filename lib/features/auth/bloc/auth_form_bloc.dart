import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:rental/features/auth/models/exports.dart';
import 'package:rental/features/auth/models/params/auth_signin_param.dart';
import 'package:equatable/equatable.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  final AuthRepository authRepository;
  AuthFormBloc({required this.authRepository}) : super(AuthFormState());

  @override
  Stream<AuthFormState> mapEventToState(AuthFormEvent event) async* {
    if (event is UsernameChanged) {
      final username = Username.dirty(event.username);
      yield state.copyWith(
        message: null,
        username: username.valid ? username : Username.pure(event.username),
        status: Formz.validate([username]),
      );
    } else if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        message: null,
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        message: null,
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([password]),
      );
    } else if (event is UsernameUnfocused) {
      final username = Username.dirty(state.username.value);
      yield state.copyWith(
        message: null,
        username: username,
        status: Formz.validate([username]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        message: null,
        email: email,
        status: Formz.validate([email]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        message: null,
        password: password,
        status: Formz.validate([password]),
      );
    } else if (event is LoginFormSubmitted) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        message: null,
        status: Formz.validate([email, password]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);

        final AuthSignInParam param =
            AuthSignInParam(email: email.value, password: password.value);

        final failureOrSuccess = await authRepository.signInUser(param);

        if (failureOrSuccess.isLeft()) {
          print("not working");
          yield state.copyWith(
              message: failureOrSuccess.fold(
                  (l) => l.maybeMap(
                      serverAuthError: (serverAuthError) => "Server error",
                      emailAlreadyInUse: (emailAlreadyInUse) =>
                          "This email is already in use",
                      networkError: (networkError) => "Network Error",
                      invalidEmailOrPasssword: (invalidCredentials) =>
                          "Invalid email or password is used",
                      orElse: () => "Unkown error occured"),
                  (r) => null),
              status: FormzStatus.submissionFailure);
        } else {
          print("working");
          await authRepository.storeToken(
              key: "token", value: failureOrSuccess.fold((l) => "", (r) => r));

          yield state.copyWith(
            message: null,
            status: FormzStatus.submissionSuccess,
          );
        }
      } else {
        print("invalid form");
        yield state.copyWith(
          message: null,
          status: FormzStatus.invalid,
        );
      }
    } else if (event is SignUpFormSubmitted) {
      final username = Username.dirty(state.username.value);
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        username: username,
        status: Formz.validate([username, email, password]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);

        final AuthSignUpParam param = AuthSignUpParam(
            username: state.username.value,
            email: state.email.value,
            password: state.password.value);

        final failureOrSuccess = await authRepository.createRemoteUser(param);

        if (failureOrSuccess.isLeft()) {
          yield state.copyWith(
              message: failureOrSuccess.fold(
                  (l) => l.maybeMap(
                        serverAuthError: (serverAuthError) => "serverAuthError",
                        emailAlreadyInUse: (emailAlreadyInUse) =>
                            "This email is already in use",
                        orElse: () => "Unexpected error",
                      ),
                  (r) => null),
              status: FormzStatus.submissionFailure);
        } else {
          yield state.copyWith(
            message: null,
            status: FormzStatus.submissionSuccess,
          );
          //Navigate to home

        }
      } else {
        yield state.copyWith(
          status: FormzStatus.invalid,
        );
      }
    }
  }
}
