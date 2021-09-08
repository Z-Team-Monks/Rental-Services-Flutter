// Mocks generated by Mockito 5.0.15 from annotations
// in rental/test/features/auth/bloc/auth_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rental/core/models/user.dart' as _i7;
import 'package:rental/features/auth/failures/auth_failure.dart' as _i6;
import 'package:rental/features/auth/models/params/auth_signin_param.dart'
    as _i8;
import 'package:rental/features/auth/repository/repository.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeClient_0 extends _i1.Fake implements _i2.Client {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i4.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(Invocation.getter(#client),
      returnValue: _FakeClient_0()) as _i2.Client);
  @override
  set client(_i2.Client? _client) =>
      super.noSuchMethod(Invocation.setter(#client, _client),
          returnValueForMissingStub: null);
  @override
  _i5.Future<_i3.Either<_i6.AuthFaiulre, _i7.User>> createRemoteUser(
          _i8.AuthSignUpParam? param) =>
      (super.noSuchMethod(Invocation.method(#createRemoteUser, [param]),
              returnValue: Future<_i3.Either<_i6.AuthFaiulre, _i7.User>>.value(
                  _FakeEither_1<_i6.AuthFaiulre, _i7.User>()))
          as _i5.Future<_i3.Either<_i6.AuthFaiulre, _i7.User>>);
  @override
  _i5.Future<_i3.Either<_i6.AuthFaiulre, String>> signInUser(
          _i8.AuthSignInParam? param) =>
      (super.noSuchMethod(Invocation.method(#signInUser, [param]),
              returnValue: Future<_i3.Either<_i6.AuthFaiulre, String>>.value(
                  _FakeEither_1<_i6.AuthFaiulre, String>()))
          as _i5.Future<_i3.Either<_i6.AuthFaiulre, String>>);
  @override
  _i5.Future<_i3.Either<_i6.AuthFaiulre, _i3.Unit>> storeToken(
          {String? key, String? value}) =>
      (super.noSuchMethod(
              Invocation.method(#storeToken, [], {#key: key, #value: value}),
              returnValue: Future<_i3.Either<_i6.AuthFaiulre, _i3.Unit>>.value(
                  _FakeEither_1<_i6.AuthFaiulre, _i3.Unit>()))
          as _i5.Future<_i3.Either<_i6.AuthFaiulre, _i3.Unit>>);
  @override
  _i3.Either<_i6.AuthFaiulre, String?> readToken({String? key}) =>
      (super.noSuchMethod(Invocation.method(#readToken, [], {#key: key}),
              returnValue: _FakeEither_1<_i6.AuthFaiulre, String?>())
          as _i3.Either<_i6.AuthFaiulre, String?>);
  @override
  String toString() => super.toString();
}
