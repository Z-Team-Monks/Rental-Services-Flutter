import 'package:flutter/material.dart';
import 'package:rental/presentation/screen/property_detail_screen.dart';
import 'package:rental/presentation/screen/splash_screen.dart';

class RouteGenerator {
  static const splashScreen = "SplashScreen";
  static const loginScreen = "LoginScreen";
  static const registerScreen = "RegisterScreen";
  static const feedScreen = "FeedScreen";
  static const postScreen = "PostScreen";
  static const propertyDetailScreen = "PropertyDetailScreen";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        MaterialPageRoute(builder: (BuildContext context) => SplashScreen());
        break;
      case loginScreen:
        throw Exception("screen not implemented yet!");
        break;
      case registerScreen:
        throw Exception("screen not implemented yet!");
        break;
      case feedScreen:
        throw Exception("screen not implemented yet!");
        break;
      case postScreen:
        throw Exception("screen not implemented yet!");
        break;
      case propertyDetailScreen:
        MaterialPageRoute(builder: (BuildContext context) => PropertyDetail());
        break;
      default:
        throw Exception("invalid screen render!");
    }
  }
}
