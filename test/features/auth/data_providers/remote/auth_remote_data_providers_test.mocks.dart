import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rental/core/network.dart';

import 'auth_remote_data_providers_test.mocks.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  MockClient mockClient = MockClient();

  void setUpMockClientSuccess200() {
    final String token = "thisIsAFakeJWTTokenLongEnough";
    when(
      mockClient.get(Uri.parse("${AppConstants.baseUrl}/auth"),
          headers: anyNamed('headers')),
    ).thenAnswer(
      (_) async => http.Response(token, 200),
    );
  }

  void setUpMockClientFailure404() {
    when(
      mockClient.get(any, headers: anyNamed('headers')),
    ).thenAnswer(
      (_) async => http.Response("Review Not Found", 404),
    );
  }
}
