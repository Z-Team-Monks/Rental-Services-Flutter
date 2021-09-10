import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/models/property.dart';
import 'package:rental/features/admin/failures/admin_failures.dart';

enum APPROVAL { APPROVE, DISAPPROVE }

class AdminRemoteDataProvider {
  final String baseUrl = "http://192.168.0.196:3000/api/v1/admin";

  Future<Either<AdminFaiulre, List<Property>>> fetchPosts({
    required String authToken,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse("$baseUrl/feed"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        List<Property> properties = [];
        for (var i = 0; i < data.length; i++) {
          try {
            properties.add(Property.fromJson(data[i]));
          } catch (e) {
            print(e);
          }
        }

        return right(properties);
      } else {
        return left(AdminFaiulre.serverError());
      }
    } on SocketException catch (e) {
      print("Error");
      return left(AdminFaiulre.networkError());
    }
  }

  Future<Either<AdminFaiulre, Unit>> approveOrDeclinePost(
      {required String authToken,
      required String postId,
      required APPROVAL option}) async {
    try {
      final http.Response response = option == APPROVAL.APPROVE
          ? await http.post(
              Uri.parse("$baseUrl/approve/$postId"),
              headers: <String, String>{
                "Content-Type": "application/json",
                "Authorization": "Bearer $authToken",
              },
            )
          : await http.delete(
              Uri.parse("$baseUrl/approve/$postId"),
              headers: <String, String>{
                "Content-Type": "application/json",
                "Authorization": "Bearer $authToken",
              },
            );
  
      if (response.statusCode == 201) {
        return right(unit);
      } else if (response.statusCode == 400) {
        return left(AdminFaiulre.invalidValue());
      } else {
        return left(AdminFaiulre.serverError());
      }
    } on SocketException catch (e) {
      return left(AdminFaiulre.networkError());
    }
  }
}
