import 'package:equatable/equatable.dart';
import 'package:rental/core/models/review.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();
}

class ReviewsLoadStarted extends ReviewsEvent {
  const ReviewsLoadStarted();

  @override
  List<Object> get props => [];
}

class ReviewsLoaded extends ReviewsEvent {
  final List<dynamic> reviews;
  const ReviewsLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewsLoadingFailed extends ReviewsEvent {
  @override
  List<Object> get props => [];
}
