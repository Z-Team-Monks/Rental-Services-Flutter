import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rental/core/models/property.dart';

class PropertyRemoteDataProvider {

  final String baseUrl = "http://10.6.193.148:5000/api";

  /// It will return list of [Property] Objects fetched from remote server / API
  ///
  /// or throws an exceptioin if an error occured
  ///
  Future<List<Property>> getProperties() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/property"),
      headers: <String, String>{"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Property> properties = [];
      for (var i = 0; i < data.size; i++) {
        properties.add(Property.fromJson(data[i]));
      }
      return data;
    } else {
      throw Exception("Unable to fetch properties");
    }
  }

  /// Given a token and a new [Property] object it will create a property in the remote server and return
  ///
  /// the created property. Or throws an exception if an error occured
  ///
  Future<Property> createProperty({
    required Property property,
    required String token,
  }) async {
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

    if (response.statusCode == 201) {
      return Property.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable to create Property");
    }
  }

  /// Given a token and a [Property] object it will update a property in the remote server and return
  ///
  /// the updated property. Or throws an exception if an error occured
  ///
  Future<Property> editProperty({
    required Property property,
    required String token,
  }) async {
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
          "cost[per]": property.bill,

          /// TODO: if there rare additionl properties that could be edited
          /// TODO: they will be included in here
        },
      ),
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      return Property.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable to update Property");
    }
  }
  
}
