import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rental/core/network.dart';
import 'package:rental/features/auth/failures/auth_failure.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:rental/features/auth/models/exports.dart';
import 'package:rental/features/auth/models/params/auth_signin_param.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

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
        message: "",
        username: username.valid ? username : Username.pure(event.username),
        status: Formz.validate([username]),
      );
    } else if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        message: "",
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        message: "",
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([password]),
      );
    } else if (event is UsernameUnfocused) {
      final username = Username.dirty(state.username.value);
      yield state.copyWith(
        message: "",
        username: username,
        status: Formz.validate([username]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        message: "",
        email: email,
        status: Formz.validate([email]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        message: "",
        password: password,
        status: Formz.validate([password]),
      );
    } else if (event is LoginFormSubmitted) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        message: "",
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
          print("working logged in");
          final token = failureOrSuccess.getOrElse(() => "");
          AppConstants.token = token;
          final failureOrSuccessCurrentUser =
              await authRepository.getCurrentUser();

          if (failureOrSuccessCurrentUser.isLeft()) {
            print("not working on getting current user");
            yield state.copyWith(
                message: failureOrSuccess.fold(
                    (l) => l.maybeMap(
                        serverAuthError: (serverAuthError) =>
                            "Server error unable to get user",
                        networkError: (networkError) =>
                            "Network Error getting user",
                        invalidValue: (invalidValue) =>
                            "Invalid token provided",
                        orElse: () =>
                            "Unkown error occured while getting current user"),
                    (r) => null),
                status: FormzStatus.submissionFailure);
          } else {
            final resUser = await storeCredentialsToPref(authRepository,
                key: "user",
                value: failureOrSuccessCurrentUser.fold(
                    (l) => "", (r) => jsonEncode(r)));

            await storeCredentialsToPref(authRepository,
                key: "isAdmin",
                value: failureOrSuccessCurrentUser.fold(
                    (l) => "", (r) => r.isAdmin.toString()));

            final resToken = await storeCredentialsToPref(authRepository,
                key: "token", value: token);
            AppConstants.token = token;

            if (resUser.isLeft() || resToken.isLeft()) {
              yield state.copyWith(
                  message: resUser.isLeft()
                      ? resUser.fold(
                          (l) => l.maybeMap(
                              writeToLocalError: (writeToLocalError) =>
                                  "Error saving user to local storage",
                              orElse: () =>
                                  "Unkown error occured while saving token user"),
                          (r) => null)
                      : resToken.fold(
                          (l) => l.maybeMap(
                              writeToLocalError: (writeToLocalError) =>
                                  "Error saving token to local storage",
                              orElse: () =>
                                  "Unkown error occured while saving token"),
                          (r) => null),
                  status: FormzStatus.submissionFailure);
            } else {
              yield state.copyWith(
                message: "",
                status: FormzStatus.submissionSuccess,
              );
            }
          }
        }
      } else {
        print("invalid form");
        yield state.copyWith(
          message: "",
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

        final failureOrSuccessUser =
            await authRepository.createRemoteUser(param);

        if (failureOrSuccessUser.isLeft()) {
          yield state.copyWith(
              message: failureOrSuccessUser.fold(
                  (l) => l.maybeMap(
                        serverAuthError: (serverAuthError) => "serverAuthError",
                        emailAlreadyInUse: (emailAlreadyInUse) =>
                            "This email is already in use",
                        networkError: (networkError) => "Network Error",
                        orElse: () => "Unexpected error",
                      ),
                  (r) => null),
              status: FormzStatus.submissionFailure);
        } else {
          final AuthSignInParam param =
              AuthSignInParam(email: email.value, password: password.value);

          final failureOrSuccess = await authRepository.signInUser(param);

          if (failureOrSuccess.isLeft()) {
            yield state.copyWith(
                message: failureOrSuccess.fold(
                    (l) => l.maybeMap(
                        serverAuthError: (serverAuthError) => "Server error",
                        networkError: (networkError) => "Network Error",
                        invalidEmailOrPasssword: (invalidCredentials) =>
                            "Invalid email or password is used",
                        orElse: () => "Unkown error occured"),
                    (r) => null),
                status: FormzStatus.submissionFailure);
          } else {
            final resUser = await storeCredentialsToPref(authRepository,
                key: "user",
                value:
                    failureOrSuccessUser.fold((l) => "", (r) => jsonEncode(r)));

            await storeCredentialsToPref(authRepository,
                key: "isAdmin",
                value: failureOrSuccessUser.fold(
                    (l) => "", (r) => r.isAdmin.toString()));

            final resToken = await storeCredentialsToPref(authRepository,
                key: "token",
                value: failureOrSuccess.fold((l) => "", (r) => r));
            AppConstants.token = failureOrSuccess.fold((l) => "", (r) => r);

            if (resUser.isLeft() || resToken.isLeft()) {
              yield state.copyWith(
                  message: resUser.isLeft()
                      ? resUser.fold(
                          (l) => l.maybeMap(
                              writeToLocalError: (writeToLocalError) =>
                                  "Error saving user to local storage",
                              orElse: () =>
                                  "Unkown error occured while saving token user"),
                          (r) => null)
                      : resToken.fold(
                          (l) => l.maybeMap(
                              writeToLocalError: (writeToLocalError) =>
                                  "Error saving token to local storage",
                              orElse: () =>
                                  "Unkown error occured while saving token"),
                          (r) => null),
                  status: FormzStatus.submissionFailure);
            } else {
              yield state.copyWith(
                message: "",
                status: FormzStatus.submissionSuccess,
              );
            }
          }
        }
      } else {
        yield state.copyWith(
          status: FormzStatus.invalid,
        );
      }
    }
  }
}

Future<Either<AuthFaiulre, Unit>> storeCredentialsToPref(
    AuthRepository repository,
    {required String key,
    required String value}) async {
  final result = await repository.storeToken(key: key, value: value);

  if (result.isLeft()) return left(AuthFaiulre.writeToLocalError());
  return right(unit);
}
