import 'package:rental/core/data_provider/data_access.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/features/property/data_provider/add_review/review_local_data_provider.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';

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

  void set reviewRemoteDataProvider(ReviewRemoteDataProvider dp) {
    _reviewRemoteDataProvider = dp;
  }
}
