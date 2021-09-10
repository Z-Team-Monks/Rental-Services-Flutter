import 'package:equatable/equatable.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';

abstract class AddReviewFormEvent extends Equatable {
  const AddReviewFormEvent();

  @override
  List<Object> get props => [];
}

class PropertyChanged extends AddReviewFormEvent {
  final String propertyId;

  PropertyChanged(this.propertyId);

  @override
  List<Object> get props => [propertyId];
}

class MessageChanged extends AddReviewFormEvent {
  const MessageChanged({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class MessageUnfocused extends AddReviewFormEvent {}

class RatingChanged extends AddReviewFormEvent {
  const RatingChanged({required this.rating});

  final double rating;

  @override
  List<Object> get props => [rating];
}

class FormSubmitted extends AddReviewFormEvent {}

class LoadReview extends AddReviewFormEvent {}

class UpdateReview extends AddReviewFormEvent {}
