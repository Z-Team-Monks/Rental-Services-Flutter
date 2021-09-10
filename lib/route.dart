import 'package:flutter/material.dart';
import 'package:rental/features/admin/screens/admin_screen.dart';
import 'package:rental/features/auth/screens/auth_screen.dart';
import 'package:rental/features/property/screens/add_property/add_property_screen.dart';
import 'package:rental/features/property/screens/property_detail/property_detail_screen.dart';
import 'package:rental/features/onBoard/screens/splash_screen.dart';
import 'package:rental/features/property/screens/property_feed/feed.dart';
// import 'package:rental/features/property/screens/review_property/add_review_popup.dart';
import 'package:rental/features/property/screens/add_review/add_review_popup.dart';
import 'package:rental/main.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class RouteGenerator {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) {
          return Home(); // ProfilePage();  //
        });
      case SplashScreen.pageRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );
      case AuthPage.pageRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              AuthPage(controller: SolidController()),
        );
      case HomeFeed.pageRoute:
        return MaterialPageRoute(builder: (context) {
          return HomeFeed();
        });
      case "postScreen":
        throw Exception("screen not implemented yet!");
      // case PropertyDetail.pageRoute:
      //   return MaterialPageRoute(builder: (context) {
      //     return PropertyDetail();
      //   });
      // case AddReviewPopup.pageRoute:
      //   return MaterialPageRoute(builder: (context) {
      //     return AddReviewPopup();
      //   });
      case AddProperty.pageRoute:
        return MaterialPageRoute(builder: (context) {
          return AddProperty();
        });
      case AdminPage.pageRoute:
        return MaterialPageRoute(builder: (context) {
          return AdminPage();
        });
      default:
        throw Exception("invalid screen render!");
    }
  }
}
