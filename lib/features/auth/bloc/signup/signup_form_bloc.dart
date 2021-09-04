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
        username: username.valid ? username : Username.pure(event.username),
        status: Formz.validate([username, state.email, state.password]),
      );
    } else if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([state.username, email, state.password]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.username, state.email, password]),
      );
    } else if (event is UsernameUnfocused) {
      final username = Username.dirty(state.username.value);
      yield state.copyWith(
        username: username,
        status: Formz.validate([username, state.email, state.password]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([state.username, email, state.password]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.username, state.email, password]),
      );
    } else if (event is FormSubmitted) {
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

        final failureOrSuccess = await _authRepository.getRemoteProvider
            .createUser(authSignUpParam: param);

        if (failureOrSuccess.isLeft()) {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        } else {
          yield state.copyWith(
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
