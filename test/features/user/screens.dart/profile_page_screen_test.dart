import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/screens/profile/profile_page.dart';
import 'package:rental/features/user/screens/profile/update_profile_screen.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

final profile =
    "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
final user = User(
  id: "0",
  name: "Kidus",
  email: "Yoseph",
  profileImage: profile,
  phoneNumber: "0911758707",
  likedProperties: [],
  posts: [],
);

class ProfileStateFake extends Fake implements ProfileState {}

class ProfileEventFake extends Fake implements ProfileEvent {}

void main() {
  group('Login', () {
    setUpAll(() {
      registerFallbackValue<ProfileState>(ProfileStateFake());
      registerFallbackValue<ProfileEvent>(ProfileEventFake());
    });

    testWidgets('tabs should exist to show properties and liked properties',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final mockProfileBloc = MockProfileBloc();
        when(() => mockProfileBloc.state).thenReturn(
          ProfileLoaded(user: user), // the desired state
        );

        // find
        final widget = ProfilePage();

        // test
        await mockNetworkImagesFor(() async => await tester.pumpWidget(
              BlocProvider<ProfileBloc>(
                create: (context) => mockProfileBloc,
                child: MaterialApp(
                  title: 'Widget Test',
                  home: Scaffold(body: widget),
                ),
              ),
            ));

        final List<String> tabs = <String>['Properties', 'Liked'];

        for (var tab in tabs) {
          final tabFinder = find.text(tab);
          expect(tabFinder, findsOneWidget);
        } // expect
      });
      // test code here
    });

    testWidgets('page should show some information about the loaded user',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final mockProfileBloc = MockProfileBloc();
        when(() => mockProfileBloc.state).thenReturn(
          ProfileLoaded(user: user), // the desired state
        );

        // find
        final widget = ProfilePage();

        // test
        await mockNetworkImagesFor(() async => await tester.pumpWidget(
              BlocProvider<ProfileBloc>(
                create: (context) => mockProfileBloc,
                child: MaterialApp(
                  title: 'Widget Test',
                  home: Scaffold(body: widget),
                ),
              ),
            ));

        final nameFinder = find.text('Kidus');
        final phoneFinder = find.text('0911758707');

        // expect
        expect(nameFinder, findsOneWidget);
        expect(phoneFinder, findsOneWidget);
      });
      // test code here
    });

    // arrange
  });
}
