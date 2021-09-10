import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/models/property.dart';
import 'package:rental/core/network.dart';
import 'package:rental/features/admin/failures/admin_failures.dart';

enum APPROVAL { APPROVE, DISAPPROVE }

class AdminRemoteDataProvider {
  Future<Either<AdminFaiulre, List<Property>>> fetchPosts({
    required String authToken,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/admin/feed"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.token}",
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
              Uri.parse("${AppConstants.baseUrl}/admin/approve/$postId"),
              headers: <String, String>{
                "Content-Type": "application/json",
                "Authorization": "Bearer ${AppConstants.token}",
              },
            )
          : await http.delete(
              Uri.parse("${AppConstants.baseUrl}/admin/approve/$postId"),
              headers: <String, String>{
                "Content-Type": "application/json",
                "Authorization": "Bearer ${AppConstants.token}",
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
