import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_event.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_state.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewRepository reviewRepository;
  ReviewsBloc({required this.reviewRepository}) : super(ReviewsLoading());

  @override
  Stream<ReviewsState> mapEventToState(ReviewsEvent event) async* {
    if (event is ReviewsLoadStarted) {
      yield ReviewsLoading();
    } else if (event is ReviewsLoaded) {
      yield ReviewOperationSuccess(event.reviews);
    } else if (event is ReviewsLoadingFailed) {
      yield ReviewOperationFailure();
    }
  }
}
