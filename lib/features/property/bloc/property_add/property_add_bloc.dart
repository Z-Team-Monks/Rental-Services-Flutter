import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'property_add_event.dart';
part 'property_add_state.dart';

class PropertyAddBloc extends Bloc<PropertyAddEvent, PropertyAddState> {
  PropertyAddBloc({required this.propertyRepository})
      : super(PropertyAddWidgetState(
            propertyState: new AddPropertyFormState(
                dropdownValue: 'Month',
                category: 'House',
                images: [],
                isLoading: false,
                submitSuccess: false,
                submitFailure: false)));

  final PropertyRepository propertyRepository;

  @override
  Stream<PropertyAddState> mapEventToState(
    PropertyAddEvent event,
  ) async* {
    if (event is PropertyAddChangePerDropDown) {
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              category: "New category",
              dropdownValue: event.properyEventValue.dropdownValue,
              isLoading: false,
              submitFailure: false,
              submitSuccess: false));
    }

    if (event is PropertyAddChangeCategoryDropDown) {
      // print(event.properyEventValue.category);
      // yield PropertyAddWidgetState(
      //     propertyState: state.propertyState.copyWith(
      //         isLoading: false, submitSuccess: true, submitFailure: false));

      print(event.properyEventValue.category);
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              category: Random().nextInt(100).toString(),
              dropdownValue: event.properyEventValue.dropdownValue,
              isLoading: false,
              submitFailure: false,
              submitSuccess: false));
    }

    if (event is PropertyAddImages) {
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              images: event.properyEventValue.images,
              isLoading: false,
              submitFailure: false,
              submitSuccess: false));
    }
    if (event is PropertyAddRemote) {
      print("updating");
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              isLoading: true, submitSuccess: false, submitFailure: false));

      //do repository call here
      // await Future.delayed(Duration(seconds: 1));
      await propertyRepository.addProduct(
          property: event.property, images: event.images);

      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              isLoading: false, submitSuccess: true, submitFailure: false));
    }
  }
}
