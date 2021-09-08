import 'package:equatable/equatable.dart';

abstract class LikePropertyEvent extends Equatable {}

class LoadLikeStatus extends LikePropertyEvent {
  @override
  List<Object?> get props => [];
}

class LikedProperty extends LikePropertyEvent {
  @override
  List<Object?> get props => [];
}

class UnlikedProperty extends LikePropertyEvent {
  @override
  List<Object?> get props => [];
}
