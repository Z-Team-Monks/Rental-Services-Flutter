import 'package:equatable/equatable.dart';

abstract class LikePropertyState extends Equatable {
  const LikePropertyState();
}

class LikeInitial extends LikePropertyState {
  final bool isLiked = false;

  @override
  List<Object> get props => [];
}

class LikeStatusLoadSuccess extends LikePropertyState {
  final bool isLiked;

  const LikeStatusLoadSuccess(this.isLiked);

  @override
  List<Object> get props => [isLiked];
}

class LikePropertyInprogress extends LikePropertyState {
  @override
  List<Object> get props => [];
}

class LikePropertySuccess extends LikePropertyState {
  final bool isLiked = true;

  @override
  List<Object> get props => [];
}
