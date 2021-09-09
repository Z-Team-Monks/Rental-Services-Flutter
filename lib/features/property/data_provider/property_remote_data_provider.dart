import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rental/core/models/property.dart';

class PropertyRemoteDataProvider {
  // final String baseUrl = "http://192.168.43.27:5000/api";
  final String baseUrl = "http://192.168.0.164:5001/api/v1";
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

    print("------------q----------property---------------------");
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

      throw Exception("Unable to fetch properties");
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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMDViNDQyOGQzZmFjNzY4Y2RmMWNiOCIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2Mjg3ODE2MzV9._VCHTjWSSC4ImckvDr4bsG2CJrA-PbCoCnIutOMuBB4";

    var options = BaseOptions(
      baseUrl: 'http://192.168.0.164:5001/api/v1',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: "multipart/form-data",
    );

    Dio dio = Dio(options);
    dio.options.headers["authorization"] = "Bearer $token";

    final http.Response response = await http.post(
      Uri.parse("$baseUrl/property"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          "images": property.images,
          "title": property.title,
          "description": property.description,
          "category": property.category,
          "cost[bill]": property.bill,
          "cost[per]": property.bill
        },
      ),
    );

    try {
      // var properties = await dio.get("/property");
      // print(properties);
      // return;

      String filename = images[0].path.split('/').last;
      // print(filename + " " + images[0].path);
      // // return;
      // FormData formData = FormData.fromMap({
      //   "profile": await MultipartFile.fromFile(
      //     images[0].path,
      //     filename: filename,
      //   ),
      // });
      var formData = FormData();
      formData.files.addAll([
        MapEntry(
          'profile',
          MultipartFile.fromFileSync(images[0].path, filename: filename),
        ),
      ]);

      var response = await Dio().put(
        'http://192.168.0.164:5001/api/v1/users/profile',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            // For latter use commented
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data"
          },
        ),
      );
      print("here");

      // FormData formData = FormData.fromMap({
      //   "images": await MultipartFile.fromFile(
      //     images[0].path,
      //     filename: filename,
      //   ),
      //   "title": property.title,
      //   "description": property.description,
      //   "category": property.category,
      //   "cost[bill]": property.bill,
      //   "cost[per]": property.per,
      // });

      // var response = await Dio().post(
      //   'http://192.168.0.164:5001/api/v1/property',
      //   data: formData,
      //   options: Options(
      //     headers: {
      //       "accept": "/",
      //       // For latter use commented
      //       "Authorization": "Bearer $token",
      //       "Content-Type": "multipart/form-data"
      //     },
      //   ),
      // );
      // print("here");

      // final response = await dio.post('/property', data: formData);
      print(response);
    } catch (e) {
      print(e.toString());
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return Property.fromJson(data);
    } else {
      throw Exception("Unable to fetch proerty With ID --- $id");
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
