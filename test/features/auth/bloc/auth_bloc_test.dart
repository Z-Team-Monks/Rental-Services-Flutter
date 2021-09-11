import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/auth/bloc/auth_form_bloc.dart';
import 'package:rental/features/auth/repository/repository.dart';
import 'package:rental/features/auth/models/exports.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  AuthFormBloc bloc;

  // MockAuthRemoteDataProvider mockAuthRemoteDataProvider =
  //     MockAuthRemoteDataProvider();

  MockAuthRepository mocksAuthRepository = MockAuthRepository();

  bloc = AuthFormBloc(authRepository: mocksAuthRepository);

  test("Initial bloc state should be empty [AuthFormState()]", () {
    expect(bloc.state, AuthFormState());
  });

  group("AuthFormBloc tests", () {
    blocTest(
      'emits [] when nothing is added',
      build: () => AuthFormBloc(authRepository: mocksAuthRepository),
      expect: () => [],
    );

    blocTest(
        "emits [AuthFormState (valid)] when username field changes to valid input",
        build: () => AuthFormBloc(authRepository: mocksAuthRepository),
        act: (AuthFormBloc bloc) {
          bloc.add(UsernameChanged(username: "nabek"));
        },
        expect: () {
          final username = Username.dirty("nabek");
          return [
            AuthFormState(
              username: username,
              status: Formz.validate([username]),
            )
          ];
        });

    blocTest(
        "emits [AuthFormState (invalid)] when username field changes to invalid input",
        build: () => AuthFormBloc(authRepository: mocksAuthRepository),
        act: (AuthFormBloc bloc) {
          bloc.add(UsernameChanged(username: "32342"));
        },
        expect: () {
          final username = Username.dirty("32342");
          return [
            AuthFormState(
              username: Username.pure("32342"),
              status: Formz.validate([username]),
            )
          ];
        });

    blocTest(
        "emits [AuthFormState (valid)] when email field changes to valid input",
        build: () => AuthFormBloc(authRepository: mocksAuthRepository),
        act: (AuthFormBloc bloc) {
          bloc.add(EmailChanged(email: "email@gmail.com"));
        },
        expect: () {
          final email = Email.dirty("email@gmail.com");
          return [
            AuthFormState(
              email: email,
              status: Formz.validate([email]),
            )
          ];
        });

    blocTest(
        "emits [AuthFormState (invalid)] when email field changes to invalid input",
        build: () => AuthFormBloc(authRepository: mocksAuthRepository),
        act: (AuthFormBloc bloc) {
          bloc.add(EmailChanged(email: "email"));
        },
        expect: () {
          final email = Email.dirty("email");
          return [
            AuthFormState(
              email: Email.pure("email"),
              status: Formz.validate([email]),
            )
          ];
        });

    blocTest(
        "emits [AuthFormState (valid)] when password field changes to valid input",
        build: () => AuthFormBloc(authRepository: mocksAuthRepository),
        act: (AuthFormBloc bloc) {
          bloc.add(PasswordChanged(password: "1fygfgy5"));
        },
        expect: () {
          final password = Password.dirty("1fygfgy5");
          return [
            AuthFormState(
              password: password,
              status: Formz.validate([password]),
            )
          ];
        });

    blocTest(
        "emits [AuthFormState (invalid)] when password field changes to invalid input",
        build: () => AuthFormBloc(authRepository: mocksAuthRepository),
        act: (AuthFormBloc bloc) {
          bloc.add(PasswordChanged(password: "1fygf"));
        },
        expect: () {
          return [
            AuthFormState(
              password: Password.pure("1fygf"),
              status: FormzStatus.invalid,
            )
          ];
        });

    blocTest(
        "emits [AuthFormState (valid), AuthFormState (In Progress), AuthFormState (success)] when form is submitted with valid inputs",
        build: () {
      when(mocksAuthRepository.signInUser(any))
          .thenAnswer((_) async => Future.value(right("userToken")));

      when(mocksAuthRepository.getCurrentUser()).thenAnswer(
          (_) async => Future.value(right(User(name: "name", email: "email"))));

      when(mocksAuthRepository.storeToken(
              value: anyNamed("value"), key: anyNamed("key")))
          .thenAnswer((_) async => Future.value(right(unit)));

      return AuthFormBloc(authRepository: mocksAuthRepository);
    }, act: (AuthFormBloc bloc) {
      bloc.add(EmailChanged(email: "email@gmail.com"));
      bloc.add(PasswordChanged(password: "strong123password"));

      bloc.add(LoginFormSubmitted());
    }, expect: () {
      final email = Email.dirty("email@gmail.com");
      final password = Password.dirty("strong123password");

      return [
        AuthFormState(
          email: email,
          status: Formz.validate([email]),
        ),
        AuthFormState(
          email: email,
          password: password,
          status: Formz.validate([password]),
        ),
        AuthFormState(
          email: email,
          password: password,
          status: FormzStatus.submissionInProgress,
        ),
        AuthFormState(
          message: "",
          email: email,
          password: password,
          status: FormzStatus.submissionSuccess,
        ),
      ];
    });

    blocTest(
        "emits [AuthFormState (valid), AuthFormState (In Progress), AuthFormState (success)] when signup form is submitted with valid inputs",
        build: () {
      when(mocksAuthRepository.createRemoteUser(any)).thenAnswer(
          (_) async => Future.value(right(User(name: "name", email: "email"))));

      when(mocksAuthRepository.signInUser(any))
          .thenAnswer((_) async => Future.value(right("userToken")));

      when(mocksAuthRepository.storeToken(
              value: anyNamed("value"), key: anyNamed("key")))
          .thenAnswer((_) async => Future.value(right(unit)));

      when(mocksAuthRepository.storeToken(
              value: anyNamed("value"), key: anyNamed("key")))
          .thenAnswer((_) async => Future.value(right(unit)));

      return AuthFormBloc(authRepository: mocksAuthRepository);
    }, act: (AuthFormBloc bloc) {
      bloc.add(UsernameChanged(username: "nabek"));
      bloc.add(EmailChanged(email: "email@gmail.com"));
      bloc.add(PasswordChanged(password: "strong123password"));

      bloc.add(SignUpFormSubmitted());
    }, expect: () {
      final username = Username.dirty("nabek");
      final email = Email.dirty("email@gmail.com");
      final password = Password.dirty("strong123password");

      return [
        AuthFormState(
          username: username,
          status: Formz.validate([username]),
        ),
        AuthFormState(
          username: username,
          email: email,
          status: Formz.validate([email]),
        ),
        AuthFormState(
          username: username,
          email: email,
          password: password,
          status: Formz.validate([password]),
        ),
        AuthFormState(
          username: username,
          email: email,
          password: password,
          status: FormzStatus.submissionInProgress,
        ),
        AuthFormState(
          message: "",
          username: username,
          email: email,
          password: password,
          status: FormzStatus.submissionSuccess,
        ),
      ];
    });
  });
}
