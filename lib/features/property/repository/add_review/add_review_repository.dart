import 'package:rental/core/data_provider/data_access.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/features/property/data_provider/add_review/review_local_data_provider.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:http/http.dart' as http;

class ReviewRepository {
  // final PropertyLocalDataProvider _propertyLocalDataProvider;
  ReviewRemoteDataProvider _reviewRemoteDataProvider;

  ReviewRepository(
    // this._propertyLocalDataProvider,
    this._reviewRemoteDataProvider,
  );

  // PropertyLocalDataProvider get propertyLocalDataProvide =>
  // this._propertyLocalDataProvider;

  ReviewRemoteDataProvider get reviewRemoteDataProvider =>
      this._reviewRemoteDataProvider;

  Future<List<Review>> getReviewsFromRemote(String id) =>
      _reviewRemoteDataProvider.getReviews(http.Client(), id);

  Future<Review> createRemoteReview(
          {required Review review,
          required String propertyId,
          required String token}) =>
      _reviewRemoteDataProvider.createReview(
        http.Client(),
        review: review,
        propertyId: propertyId,
        token: token,
      );

  Future<Review> updateRemoteReview({
    required Review review,
    required String propertyId,
    required String token,
  }) =>
      _reviewRemoteDataProvider.updateReview(
        http.Client(),
        review: review,
        propertyId: propertyId,
        token: token,
      );

  Future<Review> getRemoteReview({
    required String propertyId,
    required String token,
  }) =>
      _reviewRemoteDataProvider.getReview(
        http.Client(),
        propertyId: propertyId,
        token: token,
      );
}
