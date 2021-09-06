import 'package:rental/features/auth/data_provider/local_provider.dart';
import 'package:rental/features/auth/data_provider/remote_provider.dart';

class AuthRepository {
  late AuthRemoteDataProvider _authRemoteDataProvider;
  late AuthLocalDataProvider _authLocalDataProvider;

  AuthRepository(AuthLocalDataProvider authLocalDataProvider,
      AuthRemoteDataProvider authRemoteDataProvider)
      : _authLocalDataProvider = AuthLocalDataProvider(),
        _authRemoteDataProvider = AuthRemoteDataProvider();

  // call the dataproviders using the data access strategey
  AuthLocalDataProvider get getLocalProvider => _authLocalDataProvider;
  AuthRemoteDataProvider get getRemoteProvider => _authRemoteDataProvider;

  void set(AuthRemoteDataProvider authRemoteDataProvider) {
    this._authRemoteDataProvider = authRemoteDataProvider;
  }
}
