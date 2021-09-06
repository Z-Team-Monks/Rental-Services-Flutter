// part of 'profile_bloc.dart';

// // profile update states
// // - ProfileUpdateSuccesful
// // - ProfileUpdateLoading
// // - ProfileInputInvalid
// // - ProfileLoaded

// @immutable
// abstract class ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileUpdateSuccesful extends ProfileState {
//   final User user;

//   ProfileUpdateSuccesful({required this.user});
// }

// class ProfileUpdateFailure extends ProfileState {}

// class ProfileUpdateLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  String? changedProfilePath;

  ProfileLoaded({required this.user, this.changedProfilePath});
}
