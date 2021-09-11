import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/models/property.dart';
import 'package:rental/core/network.dart';
import 'package:rental/features/admin/failures/admin_failures.dart';

enum APPROVAL { APPROVE, DISAPPROVE }

class AdminRemoteDataProvider {
  Future<Either<AdminFaiulre, List<Property>>> fetchPosts() async {
    try {
      final http.Response response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/admin/feed"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.token}",
        },
      );

      print("Admin fetch property request sent!");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Admin fetch property request Success! Data: $data");
        List<Property> properties = [];
        for (var i = 0; i < data.length; i++) {
          try {
            properties.add(Property.fromJson(data[i]));
          } catch (e, t) {
            print(
              e,
            );
            print(
              t,
            );
          }
        }

        return right(properties);
      } else {
        print(
            "Admin fetch property request Failed! Status code: ${response.statusCode}");
        print("Admin fetch property Error!: ${response.body.toString()}");
        return left(AdminFaiulre.serverError());
      }
    } on SocketException catch (e) {
      print("Admin fetchPosts Network Error");
      return left(AdminFaiulre.networkError());
    } catch (e) {
      print("Admin fetchPosts Unkown Error: $e");
      return left(AdminFaiulre.networkError());
    }
  }

  Future<Either<AdminFaiulre, Unit>> approveOrDeclinePost(
      {required String postId, required APPROVAL option}) async {
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

      print("Admin approve/deny request sent!");
      if (response.statusCode == 201) {
        print("Admin approve/deny request Success!");
        return right(unit);
      } else {
        print(
            "Admin approve/deny request Error! statusCode: ${response.statusCode}");
        print("Admin approve/deny request Error!: ${response.body.toString()}");
        return left(AdminFaiulre.serverError());
      }
    } on SocketException catch (e) {
      return left(AdminFaiulre.networkError());
    } catch (e) {
      print("Admin approve/disapprove Unkown Error: $e");
      return left(AdminFaiulre.networkError());
    }
  }
}
