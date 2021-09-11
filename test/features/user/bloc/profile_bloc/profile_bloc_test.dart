import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/models/review.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/repository/user_repository.dart';

import 'profile_bloc_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late ProfileBloc bloc;
  MockUserRepository mockUserRepository = MockUserRepository();

  void setUp() {
    bloc = ProfileBloc(userRepository: mockUserRepository);
  }

  test('initial state should be loading', () {
    setUp();
    expect(bloc.state, equals(ProfileLoading()));
  });

  group('ProfileBloc', () {
    final user = User(email: "email", name: "kidus");
    blocTest(
      'emits [ProfileLoaded (valid)] when adding profileload event',
      build: () {
        setUp();
        when(
          mockUserRepository.getCurrentUser(""),
        ).thenAnswer((_) => Future.value(user));
        return bloc;
      },
      act: (ProfileBloc bloc) => bloc.add(ProfileLoad()),
      expect: () {
        return [
          ProfileLoading(),
          ProfileLoaded(user: user),
        ];
      },
    );
  });
}
