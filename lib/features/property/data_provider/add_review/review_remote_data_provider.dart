import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rental/core/models/property.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/core/network.dart';

class ReviewRemoteDataProvider {
  /// It will return list of [Review] Objects fetched from remote server / API
  ///
  /// or throws an exceptioin if an error occured
  ///
  Future<List<Review>> getReviews(http.Client client, id) async {
    final http.Response response = await client.get(
      Uri.parse("${AppConstants.baseUrl}/property/$id/review"),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Review> reviews = [];
      for (var i = 0; i < data.length; i++) {
        reviews.add(Review.fromJson(data[i]));
      }
      return reviews;
    } else {
      throw Exception("Unable to fetch properties");
    }
  }

  /// Given a token and a new [Review] object it will create a property in the remote server and return
  ///
  /// the created property. Or throws an exception if an error occured
  ///
  Future<Review> createReview(
    http.Client client, {
    required Review review,
    required String propertyId,
    required String token,
  }) async {
    final http.Response response = await client.post(
      Uri.parse("${AppConstants.baseUrl}/property/$propertyId/review"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${AppConstants.token}',
      },
      body: jsonEncode(review),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception("Unable to create Property");
    }
  }

  Future<Review> updateReview(
    http.Client client, {
    required Review review,
    required String propertyId,
    required String token,
  }) async {
    final http.Response response = await client.put(
      Uri.parse("${AppConstants.baseUrl}/property/$propertyId/review"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${AppConstants.token}',
      },
      body: jsonEncode(review),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Review not found");
    } else {
      throw Exception("Unable to update property");
    }
  }

  Future<Review> getReview(
    http.Client client, {
    required String propertyId,
    required String token,
  }) async {
    final http.Response response = await client.get(
      Uri.parse("${AppConstants.baseUrl}/property/$propertyId/review"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${AppConstants.token}',
      },
    );
    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      print(response.statusCode);
      throw Exception("Review not found");
    } else {
      print(response.statusCode);
      throw Exception("Network Error");
    }
  }
}
