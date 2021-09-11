import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/exceptions/auth_exception.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/core/network.dart';

class UserRemoteDataProvider {
  // final String baseUrl = "http://10.6.193.148:5000/api";
  // final tokens =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMDViNDQyOGQzZmFjNzY4Y2RmMWNiOCIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2Mjg3ODE2MzV9._VCHTjWSSC4ImckvDr4bsG2CJrA-PbCoCnIutOMuBB4";

  /// Given a [User] it will create or register
  ///
  /// the user in the remote server or API
  ///
  /// or throws an exception if an error occured
  Future<User> createUser({
    required User user,
  }) async {
    final http.Response response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/users"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "name": user.name,
          "email": user.email,
          "password": user.password,
        },
      ),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to register User!");
    }
  }

  ///Returns true if succeded in deleting the user otherwise false
  Future<bool> deleteUser() async {
    final http.Response response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/users/deleteme"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${AppConstants.token}',
      },
    );
    if (response.statusCode == 201) {
      return true;
    }
    {
      return false;
    }
  }

  /// Given a [User] it will attempt to login and
  ///
  /// retrive atoken or throw an exceptioin if an
  ///
  /// error occured
  ///
  Future<String> attemptLogin({
    required User user,
  }) async {
    final http.Response response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/auth"),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "email": user.email,
          "password": user.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return (response.body);
    } else if (response.statusCode == 403) {
      throw InvalidEmailAddressException();
    } else if (response.statusCode == 400) {
      throw Exception("Failed to login");
    } else {
      throw Exception("Error occured!");
    }
  }

  /// it will attempt to logout the user
  ///
  /// or throw an error if an error occured
  ///
  Future<void> logout(User user) async {
    // final http.Response response = await http.post(
    //   Uri.parse(baseUrl),
    //   headers: <String, String>{
    //     "Content-Type": "application/json",
    //   },
    //   body: jsonEncode(
    //     {
    //       "name": user.name,
    //       "email": user.email,
    //       "password": user.password,
    //     },
    //   ),
    // );

    // if (response.statusCode == 200) {
    //   // return User.fromJson(jsonDecode(response.body));
    // }
    // {
    //   // throw Exception("Failed to register User!");
    // }
  }

  /// Given a token it will retrive the current user
  ///
  /// from remote server or local storage and return a
  ///
  /// [User] object or throw an exception if an error occured
  ///
  Future<User> currentUser({
    required String token,
  }) async {
    final http.Response response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/users/me"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${AppConstants.token}',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 409) {
      throw EmailAlreadyExistsException();
    } else {
      print(response.body);
      throw Exception("Failed to Get User!");
    }
  }

  Future<void> uploadProfileImage(String path) async {
    try {
      print("fetching start..");
      String filename = path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          path,
          filename: filename,
        ),
      });

      var response = await Dio().put(
        '${AppConstants.baseUrl}/users/profile',
        data: formData,
        options: Options(
          headers: {
            "accept": "/",
            // For latter use commented
            "Authorization": "Bearer ${AppConstants.token}",
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

  Future<User> updateUser(User user) async {
    final http.Response response = await http.put(
      Uri.parse("${AppConstants.baseUrl}/users"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${AppConstants.token}',
      },
      body: jsonEncode(
        {
          "name": user.name,
          "email": user.email,
          "phoneNumber": user.phoneNumber,
          "v": user.v,
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      print("Error in updating: " + response.body);
      throw Exception("Failed to Update User!");
    }
  }

  Future<dynamic> uploadProfile(String path) async {
    try {
      var authToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMDViNDQyOGQzZmFjNzY4Y2RmMWNiOCIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2MzEyMTA0MDB9.3MY-s-YXRiV8JpJ0h5aU95zFz8d9bojJ3PrFe2Pa6s8"; //user im use to upload image

      print("fetching start..");
      print("----------------$path------------------");
      var dio = Dio(); // with default Options

// Set default configs
      dio.options.baseUrl = '${AppConstants.baseUrl}/users/profile';

      String filename = path.split('/').last;
      FormData formData = FormData.fromMap({
        "profile": await MultipartFile.fromFile(
          path,
          filename: filename,
        ),
      });

      var response = await dio.post(
        'http://10.6.207.85:5001/api/v1/users/profile',
        data: formData,
        options: Options(
          headers: {
            "accept": "/",
            // For latter use commented
            "Authorization": "Bearer ${AppConstants.token}",
            "Content-Type": "multipart/form-data"
          },
        ),
      );
      if (response.statusCode == 201) {
        print("done");
        return response;
      } else {
        return "phone number already exist";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
