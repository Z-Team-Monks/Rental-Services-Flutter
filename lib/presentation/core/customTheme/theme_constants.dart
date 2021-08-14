import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomThemeConstants {
  // Font family
  static const String fontFamilyPrimary = "Poppins";
}

class LightThemeConstants extends CustomThemeConstants {
  // button theme
  ButtonThemeData buttonTheme(ButtonThemeData buttonBaseTheme) {
    return buttonBaseTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      buttonColor: CustomColors.lightPurple,
    );
  }

  TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          CustomColors.primaryColor,
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(
          Color(0xffffffff),
        ), //text (and icon)
      ),
    );
  }

  IconThemeData iconButtonTheme() {
    return IconThemeData(color: CustomColors.primaryColor);
  }

  // text theme
  TextTheme textTheme(TextTheme textBaseTheme) {
    return textBaseTheme.copyWith(
      headline2: TextStyle(
          fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline3: TextStyle(
          fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline4: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline5: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline6: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}

class DarkThemeConstants extends CustomThemeConstants {
  ButtonThemeData buttonTheme(ButtonThemeData buttonBaseTheme) {
    return buttonBaseTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      buttonColor: CustomColors.lightPurple,
    );
  }

  // text theme
  TextTheme textTheme(TextTheme textBaseTheme) {
    return textBaseTheme.copyWith(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0),
    );
  }
}

class CustomColors {
  // light theme colors
  static const Color primaryColor = Color(0xFFFF8099);
  static const Color primaryTextColor = Colors.white;
  static const Color white = Colors.white;
  static const Color purple = Colors.purple;
  static const Color lightPurple = Colors.purpleAccent;

  // dark theme colors
}
