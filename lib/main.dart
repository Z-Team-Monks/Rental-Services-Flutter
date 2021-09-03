import 'package:flutter/material.dart';
import 'package:rental/core/presentation/customTheme/appTheme.dart';
import 'package:rental/features/property/screens/add_property/add_property_screen.dart';
import 'package:rental/features/property/screens/review_property/add_review_popup.dart';
import 'package:rental/route.dart';
import 'package:rental/features/property/screens/property_detail/property_detail_screen.dart';
import 'package:rental/features/onBoard/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.pageRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'House Rent',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTHeme,
      themeMode: ThemeMode.light,
    );
  }
}
