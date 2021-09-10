import 'package:rental/core/models/property.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/core/network.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import 'package:rental/locator.dart';
import 'package:http/http.dart' as http;
import 'add_review_event.dart';
import 'add_review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddReviewFormBloc extends Bloc<AddReviewFormEvent, AddReviewFormState> {
  final ReviewRepository reviewRepository;
  var propertyId;

  final token;
  AddReviewFormBloc({required this.reviewRepository})
      : token = AppConstants.token,
        super(const AddReviewFormState());

  @override
  Stream<AddReviewFormState> mapEventToState(AddReviewFormEvent event) async* {
    if (event is PropertyChanged) {
      this.propertyId = event.propertyId;
      yield state.copyWith(
        message: const Message.pure(),
        rating: 1,
        status: FormzStatus.pure,
        isUpdating: false,
      );
    } else if (event is LoadReview) {
      print("-------- review fetching ------------");
      try {
        final review = await reviewRepository.getRemoteReview(
          propertyId: propertyId,
          token: token,
        );
        print("-------- review fetched ------------");
        // print(review);
        // print()
        // final message = Message.dirty(review.message);
        print(review.message);
        final message = Message.dirty(review.message);
        yield state.copyWith(
          message: message.valid ? message : Message.pure(review.message),
          rating: review.rating,
          isUpdating: true,
        );
      } catch (e) {
        print("-------- review fetching failed ------------");
        print(e.toString());
        yield state;
      }
    } else if (event is MessageChanged) {
      print(state.message.value);
      final message = Message.dirty(event.message);
      yield state.copyWith(
        message: message.valid ? message : Message.pure(event.message),
        status: Formz.validate([message]),
      );
    } else if (event is MessageUnfocused) {
      final message = Message.dirty(state.message.value);
      yield state.copyWith(
        message: message,
        status: Formz.validate([message]),
      );
    } else if (event is RatingChanged) {
      yield state.copyWith(rating: event.rating);
    } else if (event is FormSubmitted) {
      final message = Message.dirty(state.message.value);
      final rating = state.rating;
      yield state.copyWith(
        message: message,
        rating: rating,
        status: Formz.validate([message]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        final review = Review(
          message: state.message.value,
          rating: state.rating,
        );

        if (state.isUpdating) {
          try {
            await reviewRepository.updateRemoteReview(
              review: review,
              propertyId: propertyId,
              token: token,
            );
            yield state.copyWith(status: FormzStatus.submissionSuccess);
          } catch (e) {
            print(e.toString());
            yield state.copyWith(status: FormzStatus.submissionFailure);
          }
        } else {
          try {
            await reviewRepository.createRemoteReview(
              review: review,
              propertyId: propertyId,
              token: token,
            );
            yield state.copyWith(status: FormzStatus.submissionSuccess);
          } catch (e) {
            print(e.toString());
            yield state.copyWith(status: FormzStatus.submissionFailure);
          }
        }
      }
    }
  }
}
