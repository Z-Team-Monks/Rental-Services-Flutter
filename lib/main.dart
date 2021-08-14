import 'package:flutter/material.dart';
import 'package:rental/presentation/core/customTheme/appTheme.dart';
import 'package:rental/presentation/core/route.dart';
import 'package:rental/presentation/screen/property_detail_screen.dart';
import 'package:rental/presentation/screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'House Rent',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTHeme,
      themeMode: ThemeMode.light,
      home: PropertyDetail(),
    );
  }
}
