import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rental/core/network.dart';

class LikePropertyRemoteDataProvider {
  /// It will return list of [Property] Objects fetched from remote server / API
  ///
  /// or throws an exceptioin if an error occured
  ///
  Future<int> likeProperty(
    http.Client client, {
    required String token,
    required String propertyId,
  }) async {
    final http.Response response = await client.post(
      Uri.parse("${AppConstants.baseUrl}/$propertyId/like"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["likeCount"];
      return data;
    } else if (response.statusCode == 400) {
      throw Exception("User has already liked the property");
    } else {
      throw Exception("Error");
    }
  }

  /// Given a token and a new propertyId object it will create a like property in the remote server and return
  ///
  /// the like count. Or throws an exception if an error occured
  ///
  Future<int> unlikeProperty(
    http.Client client, {
    required String propertyId,
    required String token,
  }) async {
    final http.Response response = await client.delete(
      Uri.parse("${AppConstants.baseUrl}/$propertyId/like"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["likeCount"];
      return data;
    } else if (response.statusCode == 400) {
      throw Exception("User hasn't liked this property");
    } else {
      throw Exception("Error");
    }
  }
}
