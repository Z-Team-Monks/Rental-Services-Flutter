import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/models/user.dart';
import 'package:rental/core/network.dart';
import 'package:rental/features/auth/failures/auth_failure.dart';
import 'package:rental/features/auth/models/params/auth_signin_param.dart';

class AuthRemoteDataProvider {
  final User user = new User(
      name: "Kidus Yoseph",
      email: "se.kidus.yoseph@gmail.com",
      phoneNumber: "0972476097",
      profileImage:
          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80");

  /// Given a [User] it will create or register
  ///
  /// the user in the remote server or API
  ///
  /// or throws an exception if an error occured
  Future<Either<AuthFaiulre, User>> createUser({
    required AuthSignUpParam authSignUpParam,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/users"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "name": authSignUpParam.username,
            "email": authSignUpParam.email,
            "password": authSignUpParam.password,
          },
        ),
      );

      if (response.statusCode == 201) {
        return right(User.fromJson(jsonDecode(response.body)));
      } else {
        return left(AuthFaiulre.serverAuthError());
      }
    } on SocketException catch (e) {
      return left(AuthFaiulre.networkError());
    }
  }

  /// Given a [User] it will attempt to login and
  ///
  /// retrive atoken or throw an exceptioin if an
  ///
  /// error occured
  ///
  Future<Either<AuthFaiulre, String>> attemptLogin({
    required AuthSignInParam userParams,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}/auth"),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "email": userParams.email,
            "password": userParams.password,
          },
        ),
      );

      if (response.statusCode == 200) {
        return right(response.body);
      } else {
        return left(AuthFaiulre.invalidEmailOrPasssword());
      }
    } on SocketException catch (e) {
      return left(AuthFaiulre.networkError());
    }
  }

  Future<Either<AuthFaiulre, bool>> checkIsAdmin(token) async {
    try {
      final http.Response response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/auth/isAdmin"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.token}",
        },
      );
      // print("21738888999999999333333333Workssssssssssssssssss");
      // print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return right(jsonDecode(response.body)["isAdmin"]);
      } else {
        print("serverrrr eeeeeeeeeeerrror");
        return left(AuthFaiulre.invalidEmailOrPasssword());
      }
    } on SocketException catch (e) {
      print("newtwork eeeeeeeeeeerrror $e");
      return left(AuthFaiulre.networkError());
    } catch (e) {
      print(e);
      return left(AuthFaiulre.networkError());
    }
  }

  /// it will attempt to logout the user
  ///
  /// or throw an error if an error occured
  ///
  // Future<Either<AuthFaiulre, Unit>> logout() async {
  //   // TODO: Implement logout
  //   return right();
  // }

  /// Given a token it will retrive the current user
  ///
  /// from remote server or local storage and return a
  ///
  /// [User] object or throw an exception if an error occured
  ///
  Future<Either<AuthFaiulre, User>> currentUser({
    required String token,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/users/me"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return right(User.fromJson(jsonDecode(response.body)));
      } else {
        return left(AuthFaiulre.serverAuthError());
      }
    } on SocketException catch (e) {
      print("Newtwork Error in [currentUser] method: $e");
      return left(AuthFaiulre.networkError());
    } catch (e) {
      print("Unkown Error in [currentUser] method: $e");
      return left(AuthFaiulre.networkError());
    }
  }

  Future<void> uploadProfileImage(String path) async {
    String url = "";
    var dio = Dio();
    try {
      var formData =
          FormData.fromMap({'file': await MultipartFile.fromFile(path)});
      var response = await dio.post(url, data: formData);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<User> updateUser(User user) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return user.copyWith(email: "updated_email@gmil.com");
  }
}
