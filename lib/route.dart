import 'package:flutter/material.dart';
import 'package:rental/features/property/screens/add_property/add_property_screen.dart';
import 'package:rental/features/property/screens/property_detail/property_detail_screen.dart';
import 'package:rental/features/onBoard/screens/splash_screen.dart';
import 'package:rental/features/property/screens/property_feed/feed.dart';
import 'package:rental/features/property/screens/review_property/add_review_popup.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.pageRoute:
        MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );
        break;
      case "loginScreen":
        throw Exception("screen not implemented yet!");
        break;
      case "registerScreen":
        throw Exception("screen not implemented yet!");
        break;
      case HomeFeed.pageRoute:
        MaterialPageRoute(builder: (context) {
          return HomeFeed();
        });
        break;
      case "postScreen":
        throw Exception("screen not implemented yet!");
        break;
      case PropertyDetail.pageRoute:
        MaterialPageRoute(builder: (context) {
          return PropertyDetail();
        });
        break;
      case AddReviewPopup.pageRoute:
        MaterialPageRoute(builder: (context) {
          return AddReviewPopup();
        });
        break;
      case AddProperty.pageRoute:
        MaterialPageRoute(builder: (context) {
          return AddProperty();
        });
        break;
      default:
        throw Exception("invalid screen render!");
    }
  }
}
