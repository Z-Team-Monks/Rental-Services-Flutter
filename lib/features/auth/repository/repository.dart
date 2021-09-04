import 'package:rental/features/auth/data_provider/local_provider.dart';
import 'package:rental/features/auth/data_provider/remote_provider.dart';

class AuthRepository {
  final AuthRemoteDataProvider _authRemoteDataProvider;
  final AuthLocalDataProvider _authLocalDataProvider;

  AuthRepository(
    this._authRemoteDataProvider,
    this._authLocalDataProvider,
  );

  // call the dataproviders using the data access strategey
  AuthLocalDataProvider get getLocalProvider => _authLocalDataProvider;
  AuthRemoteDataProvider get getRemoteProvider => _authRemoteDataProvider;
}
