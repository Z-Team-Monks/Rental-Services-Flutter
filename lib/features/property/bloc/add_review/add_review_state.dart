import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';

class AddReviewFormState extends Equatable {
  const AddReviewFormState({
    this.message = const Message.pure(),
    this.rating = 1,
    this.userId = "",
    this.status = FormzStatus.pure,
  });

  final Message message;
  final double rating;
  final String userId;
  final FormzStatus status;

  AddReviewFormState copyWith({
    Message? message,
    double? rating,
    FormzStatus? status,
    String? userId,
  }) {
    return AddReviewFormState(
      message: message ?? this.message,
      rating: rating ?? this.rating,
      userId: userId ?? this.userId,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [message, rating, userId, status];
}
