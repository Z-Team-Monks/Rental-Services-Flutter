import 'package:equatable/equatable.dart';
import 'package:rental/core/models/review.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Review> get props => [];
}

class ReviewsLoading extends ReviewsState {}

class ReviewOperationSuccess extends ReviewsState {
  final List<dynamic> reviews;

  ReviewOperationSuccess([this.reviews = const []]);

  @override
  List<Review> get props => reviews as List<Review>;
}

class ReviewOperationFailure extends ReviewsState {}

class ReviewEmpty extends ReviewsState {}
