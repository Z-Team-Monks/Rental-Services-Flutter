import 'package:equatable/equatable.dart';
import 'package:rental/core/models/review.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();
}

class ReviewsLoad extends ReviewsEvent {
  const ReviewsLoad();

  @override
  List<Object> get props => [];
}
