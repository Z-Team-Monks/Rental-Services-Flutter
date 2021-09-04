import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/user/repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.userRepository})
      : super(ProfileUpdateSuccesful(
            user: new User(
                name: "Kidus",
                email: "se.kidus.yoseph@gmail.com",
                phoneNumber: "0972476097",
                profileImage:
                    "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80")));

  final UserRepository userRepository;
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoad) {
      yield ProfileLoading();
      print("user loading");
      final user = await userRepository.getCurrentUser("");
      print("user foround");
      yield ProfileLoaded(user: user);
    }

    if (event is ProfileUpdate) {
      yield ProfileUpdateLoading();
      try {
        final user = await userRepository.updateUser(user: event.user);
        print("updated user ${user.email}");
        yield ProfileUpdateSuccesful(user: user);
        yield ProfileLoaded(user: user);
      } catch (e) {
        yield ProfileUpdateFailure();
      }
    }
  }
}
