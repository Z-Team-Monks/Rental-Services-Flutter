import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rental/core/exceptions/auth_exception.dart';
import 'package:rental/core/models/user.dart';

class UserRemoteDataProvider {

  final String baseUrl = "http://10.6.193.148:5000/api";

  /// Given a [User] it will create or register
  ///
  /// the user in the remote server or API
  ///
  /// or throws an exception if an error occured
  Future<User> createUser({
    required User user,
  }) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/users"),
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
      Uri.parse("$baseUrl/auth"),
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
    final http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "name": user.name,
          "email": user.email,
          "password": user.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      // return User.fromJson(jsonDecode(response.body));
    }
    {
      // throw Exception("Failed to register User!");
    }
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
      Uri.parse("$baseUrl/users/me"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 409) {
      throw EmailAlreadyExistsException();
    } else {
      throw Exception("Failed to Get User!");
    }
  }

  Future<void> uploadProfileImage() async {
    // TODO: upload profile image
  }
}
