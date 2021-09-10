import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/user/repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.userRepository}) : super(ProfileLoading());

  final UserRepository userRepository;
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoad) {
      print("user loading");
      yield ProfileLoading();
      // print("user loading");
      try {
        final user = await userRepository.getCurrentUser("");
        yield ProfileLoaded(user: user);
        print("user loaded" + user.toString());
      } catch (e) {
        print(e.toString());
        print("Can't load user");
      }
    }

    if (event is ProfilePictureChange) {
      // print("profile changed");
      yield ProfileLoaded(
          user: event.user, changedProfilePath: event.changedProfilePath);
    }

    if (event is ProfileUpdate) {
      yield ProfileUpdateLoading();
      try {
        final user = await userRepository.updateUser(
            user: event.user, newProfilePath: event.changedProfilePath);
        // final updatedUser = await userRepository.getCurrentUser("");
        // print("updated user ${user.email}");
        yield ProfileUpdateSuccesful(user: user);
        yield ProfileLoaded(user: user);
      } catch (e) {
        yield ProfileUpdateFailure();
      }
    }
  }
}
