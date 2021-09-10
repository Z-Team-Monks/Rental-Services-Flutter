import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/models/review.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/property/bloc/add_review/add_review_bloc.dart';
import 'package:rental/features/property/bloc/add_review/add_review_event.dart';
import 'package:rental/features/property/bloc/add_review/add_review_state.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/repository/user_repository.dart';
import 'package:rental/locator.dart';

import 'profile_bloc_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late ProfileBloc bloc;
  MockUserRepository mockUserRepository = MockUserRepository();
  var user = User(name: "", email: "");

  void setUp() {
    bloc = ProfileBloc(userRepository: mockUserRepository);
  }

  test('initial state should be loading', () {
    setUp();
    expect(bloc.state, equals(ProfileLoading()));
  });

  group('ProfileBloc', () {
    blocTest(
      'emits ProfileLoading event when a trying to load user',
      build: () {
        setUp();
        return bloc;
      },
      act: (ProfileBloc bloc) => bloc.add(ProfileLoad()),
      expect: () {
        return [
          ProfileLoading(),
        ];
      },
    );

    blocTest(
      'emits profile loaded when changing profile',
      build: () {
        setUp();
        return bloc;
      },
      act: (ProfileBloc bloc) => bloc.add(ProfilePictureChange(user: user)),
      expect: () {
        return [
          ProfileLoaded(user: user),
        ];
      },
    );

    blocTest(
      'emits profile update events loaded when updating profile',
      build: () {
        setUp();
        when(
          mockUserRepository.updateUser(
            user: user,
          ),
        ).thenAnswer((_) => Future.value(user));
        return bloc;
      },
      act: (ProfileBloc bloc) => bloc.add(ProfileUpdate(user: user)),
      expect: () {
        return [
          ProfileUpdateLoading(),
          ProfileUpdateSuccesful(user: user),
          ProfileLoaded(user: user),
        ];
      },
    );
  });
}
