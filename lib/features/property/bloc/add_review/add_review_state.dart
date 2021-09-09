import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';

class AddReviewFormState extends Equatable {
  const AddReviewFormState({
    this.message = const Message.pure(),
    this.rating = 1,
    this.status = FormzStatus.pure,
    this.isUpdating = false,
  });

  final Message message;
  final double rating;
  final FormzStatus status;
  final bool isUpdating;

  AddReviewFormState copyWith({
    Message? message,
    double? rating,
    FormzStatus? status,
    bool? isUpdating,
  }) {
    print(message?.value);
    return AddReviewFormState(
      message: message ?? this.message,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object> get props => [message, rating, status];
}
