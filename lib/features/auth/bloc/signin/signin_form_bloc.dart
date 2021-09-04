import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rental/features/auth/failures/auth_failure.dart';
import 'package:rental/features/auth/models/exports.dart';
import 'package:rental/features/auth/models/params/auth_signin_param.dart';
import 'package:rental/features/auth/repository/repository.dart';

part 'signin_form_event.dart';
part 'signin_form_state.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final AuthRepository _authRepository;

  SignInFormBloc(this._authRepository) : super(SignInFormState());

  @override
  void onTransition(Transition<SignInFormEvent, SignInFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, password]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (event is FormSubmitted) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        status: Formz.validate([email, password]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);

        final AuthSignInParam param = AuthSignInParam(
            email: state.email.value, password: state.password.value);

        final failureOrSuccess = await _authRepository.getRemoteProvider
            .attemptLogin(userParams: param);

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
