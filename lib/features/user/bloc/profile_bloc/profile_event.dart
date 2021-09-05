part of 'profile_bloc.dart';

//profile update events
// - ProfileUpdate
// - ProfileLoad
// - ProfileDelete

@immutable
abstract class ProfileEvent {}

class ProfileLoad extends ProfileEvent {}

class ProfileUpdate extends ProfileEvent {
  final User user;

  ProfileUpdate({required this.user});
}

class ProfileDelete extends ProfileEvent {}
