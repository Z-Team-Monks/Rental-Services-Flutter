import 'package:dartz/dartz.dart';
import 'package:rental/core/data_provider/data_access.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/admin/data_provider/local_data_provider.dart';
import 'package:rental/features/admin/data_provider/remote_data_provider.dart';
import 'package:rental/features/admin/failures/admin_failures.dart';
import 'package:http/http.dart' as http;

class AdminRepository {
  late AdminRemoteDataProvider _adminRemoteDataProvider;
  late AdminLocalDataProvider _adminLocalDataProvider;
  late http.Client client;

  AdminRepository(this._adminLocalDataProvider, this._adminRemoteDataProvider)
      : client = http.Client();

  String? checkAuthToken() {
    final authToken = readToken(key: "token").getOrElse(() => null);
    return authToken;
  }

  Future<Either<AdminFaiulre, List<Property>>> fetchProperties() async {
    final authToken = checkAuthToken();
    if (authToken == null) {
      return left(AdminFaiulre.unAuthorized());
    }

    // final propertiesResult =
    //     await _adminRemoteDataProvider.fetchPosts(authToken: authToken);

    //if netwotk error fetch from cache
    // if (propertiesResult.isLeft()) {
    //   final error = propertiesResult.getOrElse(() => []);
    //   if (error is NetworkFailedError) {
    //     return await fetchCachedProperties();
    //   }
    // }

    final res = await fetchCachedProperties(authToken);
    if (res == null) {
      return left(AdminFaiulre.invalidValue());
    } else if (res.isRight()) {
      List<Property> properties = res.getOrElse(() => []);
      if (properties.length > 0) {
        await _adminLocalDataProvider.clearCachedProperties();
        await _adminLocalDataProvider.cacheProperties(properties: properties);
      }
    }

    return res;
  }

  Future<Either<AdminFaiulre, Unit>> approveProperty(String id) async {
    final authToken = checkAuthToken();
    if (authToken == null) {
      return left(AdminFaiulre.unAuthorized());
    }
    final res = await _adminRemoteDataProvider.approveOrDeclinePost(
        postId: id, option: APPROVAL.APPROVE);

    return res;
  }

  Future<Either<AdminFaiulre, Unit>> disApproveProperty(String id) async {
    final authToken = checkAuthToken();
    if (authToken == null) {
      return left(AdminFaiulre.unAuthorized());
    }
    final res = await _adminRemoteDataProvider.approveOrDeclinePost(
        postId: id, option: APPROVAL.DISAPPROVE);

    return res;
  }

  Either<AdminFaiulre, String?> readToken({required String key}) {
    final res = _adminLocalDataProvider.readFromSharedPref(key);
    if (res.isLeft()) {
      return left(AdminFaiulre.unAuthorized());
    } else {
      final token = res.getOrElse(() => null);
      if (token == null || token.isEmpty) {
        return left(AdminFaiulre.unAuthorized());
      }
      return res;
    }
  }

  Future<Either<AdminFaiulre, List<Property>>?> fetchCachedProperties(
      String token) async {
    final res = await performRemoteOrLocalFetchOperation<
        Either<AdminFaiulre, List<Property>>>(apiCall: () async {
      print(
          "===============+++=====API Call=====================================");

      return await _adminRemoteDataProvider.fetchPosts();
    }, dbCall: () async {
      print(
          "===============+++=====DB Call=====================================");
      return await _adminLocalDataProvider.getProperties();
    });

    return res;
  }
}
