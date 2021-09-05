import 'package:flutter/material.dart';
import 'package:rental/core/presentation/customTheme/appTheme.dart';
import 'package:rental/features/property/screens/property_feed/feed.dart';
import 'package:rental/locator.dart';
import 'package:rental/route.dart';

void main() {
  setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeFeed.pageRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'House Rent',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTHeme,
      themeMode: ThemeMode.light,
    );
  }
}
