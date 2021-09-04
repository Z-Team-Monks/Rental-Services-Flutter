import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';

import 'review_remote_data_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
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

  void setUpMockClientSuccess201() {
    final review = Review(userId: 'userId');
    when(
      client.post(any,
          body: jsonEncode(review),
          headers: anyNamed('headers'),
          encoding: null),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode(review), 201),
    );
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

      // act
      final result = await dataProvider.createReview(client,
          review: Review(userId: "userId"), propertyId: "id", token: "");

      // assert
      expect(
        result,
        isA<Review>(),
      );
    });
  });
}
