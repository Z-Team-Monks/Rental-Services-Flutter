import 'package:rental/core/models/property.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import 'package:rental/locator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'add_review_event.dart';
import 'add_review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddReviewFormBloc extends Bloc<AddReviewFormEvent, AddReviewFormState> {
  final ReviewRemoteDataProvider reviewRepository;
  final userId;
  final propertyId;
  final token;
  AddReviewFormBloc({required this.reviewRepository})
      // : userId = 'getIt.get<SharedPreferences>().getString("userId") ?? ""',
      : userId = "userId",
        propertyId = "propertyId",
        // 'getIt.get<SharedPreferences>().getString("propertyId") ?? ""',
        // token = 'getIt.get<SharedPreferences>().getString("token") ?? ""',
        token = "token",
        super(const AddReviewFormState());

  @override
  Stream<AddReviewFormState> mapEventToState(AddReviewFormEvent event) async* {
    if (event is MessageChanged) {
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
      final userId = state.userId;
      yield state.copyWith(
        message: message,
        rating: rating,
        status: Formz.validate([message]),
        userId: userId,
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        // final review = Review(
        // userId: state.userId,
        // message: state.message.value,
        // rating: state.rating,
        // );

        final review = Review(userId: 'userId', message: "message");
        try {
          await reviewRepository.createReview(
            http.Client(),
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
