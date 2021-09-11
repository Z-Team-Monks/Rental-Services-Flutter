import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rental/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Rental Services Test', () {
    var loginText = find.byKey(Key("login_button"));
    var loginBottomSheet = find.byType(SolidBottomSheet);
    var sharedPrefs;
    testWidgets("login admin / regular user - smoke test", (tester) async {
      sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool("isViewed", true);
      await app.main();

      await tester.pumpAndSettle();
      await tester.tap(loginBottomSheet);
      await tester.pumpAndSettle();
      final emailTextField = find.byType(TextFormField).first;
      // print(emailTextField);
      await tester.enterText(emailTextField, "admin@gmail.com");
      final passwordTextField = find.byType(TextFormField).last;
      await tester.pumpAndSettle();
      // print(passwordTextField);
      await tester.enterText(passwordTextField, "123456");
      // await driver.tap(passwordTextField);
      // await driver.enterText("123456");

      await Future.delayed(Duration(seconds: 5));
      final login = find.byType(TextButton).last;
      await tester.tap(login);
      await tester.pumpAndSettle();
      // expect(actual, matcher)
      // await
      // expect(find.byKey(ValueKey('email_field')), findsOneWidget);
      // print("found the login screen");
      await Future.delayed(Duration(seconds: 2));
      expect(find.text("Login"), findsNothing);
    });

    testWidgets("login normal user - smoke test", (tester) async {
      // sharedPrefs = await SharedPreferences.getInstance();
      // sharedPrefs.setBool("isViewed", true);
      // await app.main();

      // await tester.pumpAndSettle();
      // await tester.tap(loginBottomSheet);
      // await tester.pumpAndSettle();
      // final emailTextField = find.byType(TextFormField).first;
      // // print(emailTextField);
      // await tester.enterText(emailTextField, "admin@gmail.com");
      // final passwordTextField = find.byType(TextFormField).last;
      // await tester.pumpAndSettle();
      // // print(passwordTextField);
      // await tester.enterText(passwordTextField, "123456");
      // // await driver.tap(passwordTextField);
      // // await driver.enterText("123456");

      // await Future.delayed(Duration(seconds: 5));
      // final login = find.byType(TextButton).last;
      // await tester.tap(login);
      // await tester.pumpAndSettle();
      // // expect(actual, matcher)
      // // await
      // // expect(find.byKey(ValueKey('email_field')), findsOneWidget);
      // // print("found the login screen");
      // await Future.delayed(Duration(seconds: 2));
      // expect(find.text("Login"), findsNothing);
    });

    // testWidgets("register a user", (tester) async {
    //   sharedPrefs = await SharedPreferences.getInstance();
    //   sharedPrefs.setBool("isViewed", true);
    //   await app.main();
    //   await tester.pumpAndSettle();
    //   await tester.tap(loginBottomSheet);
    //   await tester.pumpAndSettle();
    //   await tester.drag(find.text('Login').first, Offset(-400, 0));
    //   // await tester.fling(loginBottomSheet, Offset(-100, 0), 2);
    //   await Future.delayed(Duration(seconds: 1));
    //   await tester.pumpAndSettle();
    //   var fields = find.byType(TextFormField);
    //   await tester.enterText(fields.at(0), "Surafel Kassahun");
    //   await tester.pumpAndSettle();
    //   await tester.enterText(fields.at(1), "surafel1789@gmail.com");
    //   await tester.pumpAndSettle();
    //   await tester.enterText(fields.at(2), "123456");
    //   // await tester.showKeyboard(fields.at(2));
    //   await tester.pumpAndSettle();
    //   // await tester.tap(loginBottomSheet);

    //   await tester.tap(find.byTooltip('Done'));
    //   // await tester.dr
    //   await tester.ensureVisible(find.byType(TextButton).first);
    //   // final register = find.text("Register").last;
    //   // print("got here $register");
    //   await tester.pumpAndSettle();
    //   await tester.tap(find.byType(TextButton).first);
    //   await tester.pumpAndSettle();
    //   await Future.delayed(Duration(seconds: 2));

    //   print("got here");
    // });
  });
}
