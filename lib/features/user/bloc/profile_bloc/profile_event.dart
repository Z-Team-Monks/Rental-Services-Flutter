part of 'profile_bloc.dart';

//profile update events
// - ProfileUpdate
// - ProfileLoad
// - ProfileDelete

@immutable
abstract class ProfileEvent {}

class ProfilePictureChange extends ProfileEvent {
  String? changedProfilePath;
  final User user;
  ProfilePictureChange({required this.user, this.changedProfilePath});
}

class ProfileLoad extends ProfileEvent {}

class ProfileUpdate extends ProfileEvent {
  final User user;
  String? changedProfilePath;

  ProfileUpdate({required this.user, this.changedProfilePath});
}

class ProfileDelete extends ProfileEvent {}
