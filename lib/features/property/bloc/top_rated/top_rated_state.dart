part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();
  @override
  List<Object?> get props => [];
}

class TopRatedOperationFailure extends TopRatedState {}

class TopRatedOperationLoading extends TopRatedState {}

class TopRatedOperationSuccess extends TopRatedState {
  final List<Property> topRated;
  const TopRatedOperationSuccess([this.topRated = const []]);

  @override
  List<Property> get props => topRated;
}

class TopRatedInitial extends TopRatedState {}
