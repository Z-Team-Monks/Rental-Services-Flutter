import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/property/bloc/property_add/property_add_bloc.dart';
import 'package:rental/features/property/screens/add_property/add_property_screen.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/screens/profile/update_profile_screen.dart';

class MockPropertyAddBloc extends MockBloc<PropertyAddEvent, PropertyAddState>
    implements PropertyAddBloc {}

class PropertyAddStateFake extends Fake implements PropertyAddState {}

class PropertyAddEventFake extends Fake implements PropertyAddEvent {}

void main() {
  group('Login', () {
    setUpAll(() {
      registerFallbackValue<PropertyAddState>(PropertyAddStateFake());
      registerFallbackValue<PropertyAddEvent>(PropertyAddEventFake());
    });

    testWidgets('should show a pre filled values on the add property form',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final mockPropertyAddBloc = MockPropertyAddBloc();
        when(() => mockPropertyAddBloc.state).thenReturn(
          PropertyAddWidgetState(
              propertyState: new AddPropertyFormState(
                  dropdownValue: 'Month',
                  category: 'House',
                  images: [],
                  isLoading: false,
                  submitSuccess: false,
                  submitFailure: false)), // the desired state
        );

        // find
        final widget = AddProperty();
        // test
        await mockNetworkImagesFor(() async => await tester.pumpWidget(
              BlocProvider<PropertyAddBloc>(
                create: (context) => mockPropertyAddBloc,
                child: MaterialApp(
                  title: 'Widget Test',
                  home: Scaffold(body: widget),
                ),
              ),
            ));

        final categoryFinder = find.text('House');
        final dropdownValueFinder = find.text('Month');
        final priceFinder = find.text('400');
        // expect
        expect(categoryFinder, findsWidgets);
        expect(dropdownValueFinder, findsWidgets);
        expect(priceFinder, findsWidgets);
      });
      // test code here
    });

    testWidgets(
        'should show that there are no images selected at the beginning on the add property form',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        final mockPropertyAddBloc = MockPropertyAddBloc();
        when(() => mockPropertyAddBloc.state).thenReturn(
          PropertyAddWidgetState(
              propertyState: new AddPropertyFormState(
                  dropdownValue: 'Month',
                  category: 'House',
                  images: [],
                  isLoading: false,
                  submitSuccess: false,
                  submitFailure: false)), // the desired state
        );

        // find
        final widget = AddProperty();
        // test
        await mockNetworkImagesFor(() async => await tester.pumpWidget(
              BlocProvider<PropertyAddBloc>(
                create: (context) => mockPropertyAddBloc,
                child: MaterialApp(
                  title: 'Widget Test',
                  home: Scaffold(body: widget),
                ),
              ),
            ));

        final message = find.text('No images provided');
        expect(message, findsWidgets);
      });
      // test code here
    });
    // arrange
  });
}
