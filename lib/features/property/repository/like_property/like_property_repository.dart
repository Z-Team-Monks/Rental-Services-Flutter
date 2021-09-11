import 'package:rental/core/data_provider/data_access.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/features/property/data_provider/add_review/review_local_data_provider.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:rental/features/property/data_provider/like_property/like_property_remote_data_provider.dart';

class LikePropertyRepository {
  // final PropertyLocalDataProvider _propertyLocalDataProvider;
  LikePropertyRemoteDataProvider _likePropertyRemoteDataProvider;

  LikePropertyRepository(
    // this._propertyLocalDataProvider,
    this._likePropertyRemoteDataProvider,
  );

  // PropertyLocalDataProvider get propertyLocalDataProvide =>
  // this._propertyLocalDataProvider;

  LikePropertyRemoteDataProvider get reviewRemoteDataProvider =>
      this._likePropertyRemoteDataProvider;

  Future<int> likePropertyRemote(
          {required String propertyId, required String token}) =>
      _likePropertyRemoteDataProvider.likeProperty(
        http.Client(),
        token: token,
        propertyId: propertyId,
      );

  Future<int> unlikePropertyRemote(
          {required String propertyId, required String token}) =>
      _likePropertyRemoteDataProvider.unlikeProperty(
        http.Client(),
        propertyId: propertyId,
        token: token,
      );
}
