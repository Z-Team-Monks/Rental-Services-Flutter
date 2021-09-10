import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/core/models/review.dart';

class PropertyRemoteDataProvider {
  // final String baseUrl = "http://192.168.43.27:5000/api";
  // final String baseUrl = "http://192.168.43.27:5001/api/v1";
  final String baseUrl = "http://192.168.0.164:5000/api/v1";

  final tokens =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMDViNDQyOGQzZmFjNzY4Y2RmMWNiOCIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2Mjg3ODE2MzV9._VCHTjWSSC4ImckvDr4bsG2CJrA-PbCoCnIutOMuBB4";

  /// It will return list of [Property] Objects fetched from remote server / API
  ///
  /// or throws an exceptioin if an error occured
  ///
  Future<List<Property>> getProperties() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/property"),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    print("----------------------property---------------------");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      List<Property> properties = [];
      for (var i = 0; i < data.length; i++) {
        properties.add(Property.fromJson(data[i]));
      }
      print("----------------------property Success---------------------");
      return properties;
    } else {
      print("----------------------property Failure---------------------");

      throw Exception("Unable to fetch properties [getProperties]");
    }
  }

  /// Given a token and a new [Property] object it will create a property in the remote server and return
  ///
  /// the created property. Or throws an exception if an error occured
  ///
  Future<void> createProperty({
    required List<XFile> images,
    required Property property,
    required String token,
  }) async {
    token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMzliYjM3NGNkMWMxNGRiOGQ0M2JmOCIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2MzExNzM1NDV9.DoR9lgtTcYlEYMxnnEV4-n56eargHLp3Ipkxkbrlou0";
    try {
      print("fetching start..");
      // String filename = images[0].path.split('/').last;
      var imagesEntry = [];
      for (var image in images) {
        print(image.path + " " + image.path.split("/").last);
        imagesEntry.add(
          MapEntry(
            "images",
            await MultipartFile.fromFile(
              image.path,
              filename: image.path.split("/").last,
            ),
          ),
        );
      }
      FormData formData = FormData.fromMap({
        "title": property.title,
        "description": property.description,
        "category": property.category,
        "cost[bill]": property.bill,
        "cost[per]": property.per,
      });

      for (var image in images) {
        formData.files.addAll([
          MapEntry(
            "files",
            await MultipartFile.fromFile(
              image.path,
              filename: image.path.split("/").last,
            ),
          ),
        ]);
      }

      var response = await Dio().post(
        '$baseUrl/property',
        data: formData,
        options: Options(
          headers: {
            "accept": "/",
            "Authorization": "Bearer $tokens",
            "Content-Type": "multipart/form-data"
          },
        ),
      );
      if (response.statusCode == 201) {
        print("done");
        // return response;
      } else {
        // return "phone number already exist";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Given a token and a [Property] object it will update a property in the remote server and return
  ///
  /// the updated property. Or throws an exception if an error occured
  ///
  Future<Property> editProperty({
    required Property property,
    // required String token,
  }) async {
    // await Future.delayed(Duration(seconds: 3));
    // return property;

    final http.Response response = await http.put(
      Uri.parse("$baseUrl/property/61389e84a6a60a468bce7d11"),
      // Uri.parse(
      //     "http://192.168.43.46:5001/api/v1/property/61389e84a6a60a468bce7d11"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokens',
      },
      body: jsonEncode(
        {
          "title": property.title,
          "description": property.description,
          "category": property.category,
          "cost": {
            "bill": property.bill,
            "per": property.per,
          },
        },
      ),
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      // print("updated" + (jsonDecode(response.body)));
      // print(Property.fromJson(jsonDecode(response.body)));
      return Property.fromJson(jsonDecode(response.body));
    } else {
      print("Can't update " + response.body);
      throw Exception("Unable to update Property");
    }
  }

  Future<Property> getProperty(String id) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/property/$id"),
      headers: <String, String>{"Content-Type": "application/json"},
    );
    print("-------------get property remote-----------");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("get property remote success---------------");
      // print(data["reviewes"]);
      // var d =
      // (data["reviewes"] as List).map((i) => Review.fromJson(i)).toList();
      // List<dynamic> parsedListJson = data["reviewes"];
      // List<Item> d = List<Item>.from(parsedListJson.map((i) => Item.fromJson(i)));
      // print("${d[0].user?.profileImage} -- reviews list from json");
      var s = Property.fromJson(data);
      // print("${s.reviewes?[0].user?.profileImage} -- reviews list from json");
      return s;
    } else {
      print(response.statusCode);
      print(
          "---------------get property remote exception occurred-------------");

      throw Exception("Unable to fetch property With ID --- $id");
    }
  }

  /// It will return list of [Property] Objects by searching from the remote server / API
  ///
  /// or throws an exceptioin if an error occured
  ///
  Future<List<Property>> searchProperty(String keyword) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/property/search?limit=5&keyword=$keyword"),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    print("----------------------property fillter---------------------");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      List<Property> properties = [];
      for (var i = 0; i < data.length; i++) {
        properties.add(Property.fromJson(data[i]));
      }
      print(data);
      print("----------------------property search---------------------");
      return properties;
    } else {
      print("----------------------property Failure---------------------");
      throw Exception("Unable to fetch properties [SearchProperty]");
    }
  }

  /// It will return list of [Property] Objects by searching from the remote server / API
  ///
  /// or throws an exceptioin if an error occured
  ///
  Future<List<Property>> fetchByCategory(String category) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/property?category=$category"),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    print(
        "----------------------property fillter by category---------------------");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      List<Property> properties = [];
      for (var i = 0; i < data.length; i++) {
        properties.add(Property.fromJson(data[i]));
      }
      return properties;
    } else {
      print("----------------------property Failure---------------------");
      throw Exception("Unable to fetch properties [SearchProperty]");
    }
  }

  Future<Property> loadProperty({required String id}) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/property/$id"),
      // Uri.parse(
      //     "http://192.168.43.46:5001/api/v1/property/61389e84a6a60a468bce7d11"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      print(response.body);
      return Property.fromJson(jsonDecode(response.body));
    } else {
      print("Error Message " + response.body);
      throw Exception("Unable to load Property");
    }
  }
}
