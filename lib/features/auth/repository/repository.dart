import 'package:dartz/dartz.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/auth/data_provider/local_provider.dart';
import 'package:rental/features/auth/data_provider/remote_provider.dart';
import 'package:rental/features/auth/failures/auth_failure.dart';
import 'package:http/http.dart' as http;
import 'package:rental/features/auth/models/params/auth_signin_param.dart';

class AuthRepository {
  late AuthRemoteDataProvider _authRemoteDataProvider;
  late AuthLocalDataProvider _authLocalDataProvider;
  late http.Client client;

  AuthRepository(this._authLocalDataProvider, this._authRemoteDataProvider)
      : client = http.Client();

  Future<Either<AuthFaiulre, User>> createRemoteUser(
      AuthSignUpParam param) async {
    final failureOrSuccess =
        await _authRemoteDataProvider.createUser(authSignUpParam: param);

    return failureOrSuccess;
  }

  Future<Either<AuthFaiulre, String>> signInUser(AuthSignInParam param) async {
    final failureOrSuccess =
        await _authRemoteDataProvider.attemptLogin(userParams: param);
    return failureOrSuccess;
  }

  Future<Either<AuthFaiulre, Unit>> storeToken(
      {required String key, required String value}) async {
    final res = await _authLocalDataProvider.storeOnSharedPref(key, value);
    print("saved token");
    return res;
  }

  Either<AuthFaiulre, String?> readToken({required String key}) {
    final res = _authLocalDataProvider.readFromSharedPref(key);
    if (res.isLeft()) {
      return left(AuthFaiulre.invalidValue());
    } else {
      final token = res.getOrElse(() => null);
      if (token == null || token.isEmpty) {
        return left(AuthFaiulre.invalidValue());
      }
      return res;
    }
  }
}