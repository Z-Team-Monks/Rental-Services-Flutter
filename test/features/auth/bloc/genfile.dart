import 'package:mockito/annotations.dart';
import 'package:rental/features/auth/data_provider/remote_provider.dart';
import 'package:rental/features/auth/repository/repository.dart';

import 'genfile.mocks.dart';

@GenerateMocks([AuthRepository, AuthRemoteDataProvider])
void main() {
  MockAuthRemoteDataProvider mockAuthRemoteDataProvider;

  MockAuthRepository mocksAuthRepository;
}
