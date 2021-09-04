import 'package:equatable/equatable.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';

abstract class AddReviewFormEvent extends Equatable {
  const AddReviewFormEvent();

  @override
  List<Object> get props => [];
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
