import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:rental/features/auth/bloc/signin/signin_form_bloc.dart';
import 'package:rental/features/auth/data_provider/remote_provider.dart';
import 'package:rental/features/auth/failures/auth_failure.dart';
import 'package:rental/features/auth/models/exports.dart';
import 'package:rental/features/auth/models/params/auth_signin_param.dart';
import 'package:rental/features/auth/repository/repository.dart';

import '../genfile.mocks.dart';

void main() {
  SignInFormBloc bloc;
  MockAuthRemoteDataProvider mockAuthRemoteDataProvider =
      MockAuthRemoteDataProvider();

  MockAuthRepository mocksAuthRepository = MockAuthRepository();

  bloc = SignInFormBloc(mocksAuthRepository);

  test("Initial bloc state should be empty [SignInFormState()]", () {
    expect(bloc.state, SignInFormState());
  });

  group("SignInFormBloc tests", () {
    blocTest(
      'emits [] when nothing is added',
      build: () => SignInFormBloc(mocksAuthRepository),
      expect: () => [],
    );

    blocTest(
        "emits [SignInFormState (valid)] when email field changes to valid input",
        build: () => SignInFormBloc(mocksAuthRepository),
        act: (SignInFormBloc bloc) {
          bloc.add(EmailChanged(email: "email@gmail.com"));
        },
        expect: () {
          final email = Email.dirty("email@gmail.com");
          return [
            SignInFormState(
              email: email,
              status: Formz.validate([email]),
            )
          ];
        });

    blocTest(
        "emits [SignInFormState (invalid)] when email field changes to invalid input",
        build: () => SignInFormBloc(mocksAuthRepository),
        act: (SignInFormBloc bloc) {
          bloc.add(EmailChanged(email: "email"));
        },
        expect: () {
          final email = Email.dirty("email");
          return [
            SignInFormState(
              email: Email.pure("email"),
              status: Formz.validate([email]),
            )
          ];
        });

    blocTest(
        "emits [SignInFormState (valid)] when password field changes to valid input",
        build: () => SignInFormBloc(mocksAuthRepository),
        act: (SignInFormBloc bloc) {
          bloc.add(PasswordChanged(password: "1fygfgy5"));
        },
        expect: () {
          final password = Password.dirty("1fygfgy5");
          return [
            SignInFormState(
              password: password,
              status: Formz.validate([password]),
            )
          ];
        });

    blocTest(
        "emits [SignInFormState (invalid)] when password field changes to invalid input",
        build: () => SignInFormBloc(mocksAuthRepository),
        act: (SignInFormBloc bloc) {
          bloc.add(PasswordChanged(password: "1fygf"));
        },
        expect: () {
          return [
            SignInFormState(
              password: Password.pure("1fygf"),
              status: FormzStatus.invalid,
            )
          ];
        });

    blocTest(
        "emits [SignInFormState (valid), SignInFormState (In Progress), SignInFormState (success)] when form is submitted with valid inputs",
        build: () {
      final String token = "thisIsAFakeJWTTokenLongEnough";
      when(mocksAuthRepository.getRemoteProvider)
          .thenAnswer((_) => mockAuthRemoteDataProvider);
      when(
        mockAuthRemoteDataProvider.attemptLogin(
          client: anyNamed("client"),
          userParams: anyNamed('userParams'),
        ),
      ).thenAnswer((_) async => right(token));

      return SignInFormBloc(mocksAuthRepository);
    }, act: (SignInFormBloc bloc) {
      bloc.add(EmailChanged(email: "email@gmail.com"));
      bloc.add(PasswordChanged(password: "strong123password"));

      bloc.add(FormSubmitted());
    }, expect: () {
      final email = Email.dirty("email@gmail.com");
      final password = Password.dirty("strong123password");

      return [
        SignInFormState(
          email: email,
          status: Formz.validate([email]),
        ),
        SignInFormState(
          email: email,
          password: password,
          status: Formz.validate([password]),
        ),
        SignInFormState(
          email: email,
          password: password,
          status: FormzStatus.submissionInProgress,
        ),
        SignInFormState(
          message: null,
          email: email,
          password: password,
          status: FormzStatus.submissionSuccess,
        ),
      ];
    });
  });
}
