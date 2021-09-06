import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rental/features/auth/failures/auth_failure.dart';
import 'package:rental/features/auth/models/exports.dart';
import 'package:rental/features/auth/models/params/auth_signin_param.dart';
import 'package:rental/features/auth/models/username.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:http/http.dart' as http;

part 'signup_form_event.dart';
part 'signup_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final AuthRepository _authRepository;

  SignUpFormBloc(this._authRepository) : super(SignUpFormState());

  @override
  void onTransition(Transition<SignUpFormEvent, SignUpFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<SignUpFormState> mapEventToState(SignUpFormEvent event) async* {
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
    } else if (event is FormSubmitted) {
      final username = Username.dirty(state.username.value);
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        username: username,
        message: null,
        status: Formz.validate([username, email, password]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);

        final AuthSignUpParam param = AuthSignUpParam(
            username: state.username.value,
            email: state.email.value,
            password: state.password.value);

        final failureOrSuccess = await _authRepository.getRemoteProvider
            .createUser(client: http.Client(), authSignUpParam: param);

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
