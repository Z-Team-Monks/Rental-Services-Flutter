import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/core/network.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'review_remote_data_provider_test.mocks.dart';
import 'package:rental/locator.dart' as getIt;

@GenerateMocks([http.Client])
void main() {
  getIt.setUp();
  setupPreferences("token", "token");
  MockClient client = MockClient();
  ReviewRemoteDataProvider dataProvider = ReviewRemoteDataProvider();

  void setUpMockClientSuccess200() {
    final List<Review> reviews = [
      Review(userId: "userId", message: "", rating: 0)
    ];
    when(
      client.get(any, headers: anyNamed('headers')),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode(reviews), 200),
    );
  }

  final review = Review(message: '', rating: 0);
  void setUpMockClientSuccess201() {
    when(
      client.post(
        Uri.parse("${AppConstants.baseUrl}/property/propertyId/review"),
        body: anyNamed("body"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${AppConstants.token}',
        },
        encoding: null,
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode(review), 200),
    );
    // when(dataProvider.createReview(client,
    // review: review, propertyId: "propertyId", token: "token"))
    // .thenAnswer((_) async => http.Response(jsonEncode(review), 200));
  }

  void setUpMockClientFailure404() {
    when(
      client.get(any, headers: anyNamed('headers')),
    ).thenAnswer(
      (_) async => http.Response("Review Not Found", 404),
    );
  }

  group("get review", () {
    test('returns a list of Review if the http call completes successfully',
        () async {
      // arrange
      setUpMockClientSuccess200();

      // act
      final result = await dataProvider.getReviews(client, "id");

      // assert
      expect(result, isA<List<Review>>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      // arrnge
      setUpMockClientFailure404();

      // act
      final call = dataProvider.getReviews;

      // assert
      expect(() => call(client, "id"), throwsA(TypeMatcher<Exception>()));
    });
  });

  group("post review", () {
    test('returns a review if the http call completes successfully', () async {
      // arrange
      setUpMockClientSuccess201();

      print(AppConstants.baseUrl);
      // act
      final result = await dataProvider.createReview(
        client,
        propertyId: "propertyId",
        token: "token",
        review: Review(message: '', rating: 0),
      );

      // assert
      expect(
        result,
        isA<Review>(),
      );
    });
  });
}

Future setupPreferences(String key, String value) async {
  SharedPreferences.setMockInitialValues(
      <String, Object>{'flutter.' + key: value});
  final preferences = await SharedPreferences.getInstance();
  await preferences.setString(key, value);
}
