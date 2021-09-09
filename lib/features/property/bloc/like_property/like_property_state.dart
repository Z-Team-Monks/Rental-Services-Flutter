import 'package:equatable/equatable.dart';

abstract class LikePropertyState extends Equatable {
  const LikePropertyState();
}

class LikePropertyInitial extends LikePropertyState {
  final bool isLiked = false;

  @override
  List<Object> get props => [isLiked];
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
  final bool isLiked;
  const LikePropertySuccess(this.isLiked);
  @override
  List<Object> get props => [isLiked];
}
