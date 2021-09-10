part of 'profile_bloc.dart';

// profile update states
// - ProfileUpdateSuccesful
// - ProfileUpdateLoading
// - ProfileInputInvalid
// - ProfileLoaded

@immutable
abstract class ProfileState extends Equatable {}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileUpdateSuccesful extends ProfileState {
  final User user;

  ProfileUpdateSuccesful({required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfileUpdateFailure extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileUpdateLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final User user;
  String? changedProfilePath;

  ProfileLoaded({required this.user, this.changedProfilePath});

  @override
  List<Object?> get props => [user, changedProfilePath];
}
