import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rental/presentation/core/customTheme/appTheme.dart';

import 'add_review_button.dart';

void main() => runApp(const MyApp());

/// {@template my_app}
/// Entry point for the application.
/// {@endtemplate}
class MyApp extends StatelessWidget {
  /// {@macro my_app}
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      home: const Home(),
    );
  }
}

/// {@template home}
/// Home widget of the application.
/// {@endtemplate}
class Home extends StatelessWidget {
  /// {@macro home}
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: AddTodoButton(),
          )
        ],
      ),
    );
  }
}
