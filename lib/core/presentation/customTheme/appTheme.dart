import 'package:flutter/material.dart';
import './theme_constants.dart';

class CustomTheme {
  // base themes
  static final ThemeData _customLightTheme = ThemeData.light();
  static final ThemeData _customDarkTheme = ThemeData.dark();

  static ThemeData get lightTheme {
    final LightThemeConstants lightThemeConstants = new LightThemeConstants();
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: CustomThemeConstants.fontFamilyPrimary,
        primaryColor: CustomColors.purple,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: lightThemeConstants.textButtonTheme(),
        iconTheme: lightThemeConstants.iconButtonTheme(),
        buttonTheme:
            lightThemeConstants.buttonTheme(_customLightTheme.buttonTheme),
        textTheme: lightThemeConstants.textTheme(_customLightTheme.textTheme));
  }

  static ThemeData get darkTHeme {
    final DarkThemeConstants darkThemeConstants = new DarkThemeConstants();
    return ThemeData(
        fontFamily: CustomThemeConstants.fontFamilyPrimary,
        primaryColor: CustomColors.purple,
        scaffoldBackgroundColor: Colors.white,
        buttonTheme:
            darkThemeConstants.buttonTheme(_customDarkTheme.buttonTheme),
        textTheme: darkThemeConstants.textTheme(_customDarkTheme.textTheme));
  }
}
