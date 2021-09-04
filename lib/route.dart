import 'package:flutter/material.dart';
import 'package:rental/features/property/screens/add_property/add_property_screen.dart';
import 'package:rental/features/property/screens/property_detail/property_detail_screen.dart';
import 'package:rental/features/onBoard/screens/splash_screen.dart';
import 'package:rental/features/property/screens/property_feed/feed.dart';
// import 'package:rental/features/property/screens/review_property/add_review_popup.dart';
import 'package:rental/features/user/screens/profile/profile_page.dart';
import 'package:rental/features/user/screens/profile/update_profile_screen.dart';
import 'package:rental/features/property/screens/add_review/add_review_popup.dart';

class RouteGenerator {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) {
          return AddProperty(); //ProfilePage(); //AddReviewPopup();
        });
      case SplashScreen.pageRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );
      case "loginScreen":
        throw Exception("screen not implemented yet!");
      case "registerScreen":
        throw Exception("screen not implemented yet!");
      case HomeFeed.pageRoute:
        return MaterialPageRoute(builder: (context) {
          return HomeFeed();
        });
      case "postScreen":
        throw Exception("screen not implemented yet!");
      case PropertyDetail.pageRoute:
        return MaterialPageRoute(builder: (context) {
          return PropertyDetail();
        });
      case AddReviewPopup.pageRoute:
        return MaterialPageRoute(builder: (context) {
          return AddReviewPopup();
        });
      case AddProperty.pageRoute:
        return MaterialPageRoute(builder: (context) {
          return AddProperty();
        });
      default:
        throw Exception("invalid screen render!");
    }
  }
}
