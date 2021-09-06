import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/mockito.dart';
import 'package:rental/core/models/user.dart';

import 'package:rental/features/auth/bloc/signup/signup_form_bloc.dart';
import 'package:rental/features/auth/models/exports.dart';

import '../genfile.mocks.dart';

void main() {
  SignUpFormBloc bloc;

  MockAuthRemoteDataProvider mockAuthRemoteDataProvider =
      MockAuthRemoteDataProvider();

  MockAuthRepository mocksAuthRepository = MockAuthRepository();

  bloc = SignUpFormBloc(mocksAuthRepository);

  test("Initial bloc state should be empty [SignUpFormState()]", () {
    expect(bloc.state, SignUpFormState());
  });

  group("SignUpFormBloc tests", () {
    blocTest(
      'emits [] when nothing is added',
      build: () => SignUpFormBloc(mocksAuthRepository),
      expect: () => [],
    );

    blocTest(
        "emits [SignUpFormState (valid)] when username field changes to valid input",
        build: () => SignUpFormBloc(mocksAuthRepository),
        act: (SignUpFormBloc bloc) {
          bloc.add(UsernameChanged(username: "nabek"));
        },
        expect: () {
          final username = Username.dirty("nabek");
          return [
            SignUpFormState(
              username: username,
              status: Formz.validate([username]),
            )
          ];
        });

    blocTest(
        "emits [SignUpFormState (invalid)] when username field changes to invalid input",
        build: () => SignUpFormBloc(mocksAuthRepository),
        act: (SignUpFormBloc bloc) {
          bloc.add(UsernameChanged(username: "32342"));
        },
        expect: () {
          final username = Username.dirty("32342");
          return [
            SignUpFormState(
              username: Username.pure("32342"),
              status: Formz.validate([username]),
            )
          ];
        });

    blocTest(
        "emits [SignUpFormState (valid)] when email field changes to valid input",
        build: () => SignUpFormBloc(mocksAuthRepository),
        act: (SignUpFormBloc bloc) {
          bloc.add(EmailChanged(email: "email@gmail.com"));
        },
        expect: () {
          final email = Email.dirty("email@gmail.com");
          return [
            SignUpFormState(
              email: email,
              status: Formz.validate([email]),
            )
          ];
        });

    blocTest(
        "emits [SignUpFormState (invalid)] when email field changes to invalid input",
        build: () => SignUpFormBloc(mocksAuthRepository),
        act: (SignUpFormBloc bloc) {
          bloc.add(EmailChanged(email: "email"));
        },
        expect: () {
          final email = Email.dirty("email");
          return [
            SignUpFormState(
              email: Email.pure("email"),
              status: Formz.validate([email]),
            )
          ];
        });

    blocTest(
        "emits [SignUpFormState (valid)] when password field changes to valid input",
        build: () => SignUpFormBloc(mocksAuthRepository),
        act: (SignUpFormBloc bloc) {
          bloc.add(PasswordChanged(password: "1fygfgy5"));
        },
        expect: () {
          final password = Password.dirty("1fygfgy5");
          return [
            SignUpFormState(
              password: password,
              status: Formz.validate([password]),
            )
          ];
        });

    blocTest(
        "emits [SignUpFormState (invalid)] when password field changes to invalid input",
        build: () => SignUpFormBloc(mocksAuthRepository),
        act: (SignUpFormBloc bloc) {
          bloc.add(PasswordChanged(password: "1fygf"));
        },
        expect: () {
          return [
            SignUpFormState(
              password: Password.pure("1fygf"),
              status: FormzStatus.invalid,
            )
          ];
        });

    blocTest(
        "emits [SignUpFormState (valid), SignUpFormState (In Progress), SignUpFormState (success)] when form is submitted with valid inputs",
        build: () {
      when(mocksAuthRepository.getRemoteProvider)
          .thenAnswer((_) => mockAuthRemoteDataProvider);
      when(mockAuthRemoteDataProvider.createUser(
              client: anyNamed("client"),
              authSignUpParam: anyNamed("authSignUpParam")))
          .thenAnswer((_) async => right(User(name: "name", email: "email")));
      return SignUpFormBloc(mocksAuthRepository);
    }, act: (SignUpFormBloc bloc) {
      bloc.add(UsernameChanged(username: "nabek"));
      bloc.add(EmailChanged(email: "email@gmail.com"));
      bloc.add(PasswordChanged(password: "strong123password"));

      bloc.add(FormSubmitted());
    }, expect: () {
      final username = Username.dirty("nabek");
      final email = Email.dirty("email@gmail.com");
      final password = Password.dirty("strong123password");

      return [
        SignUpFormState(
          username: username,
          status: Formz.validate([username]),
        ),
        SignUpFormState(
          email: email,
          username: username,
          status: Formz.validate([email]),
        ),
        SignUpFormState(
          username: username,
          email: email,
          password: password,
          status: Formz.validate([password]),
        ),
        SignUpFormState(
          username: username,
          email: email,
          password: password,
          status: FormzStatus.submissionInProgress,
        ),
        SignUpFormState(
          message: null,
          username: username,
          email: email,
          password: password,
          status: FormzStatus.submissionSuccess,
        ),
      ];
    });
  });
}
