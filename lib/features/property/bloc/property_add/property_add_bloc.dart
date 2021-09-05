import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental/core/models/property.dart';

part 'property_add_event.dart';
part 'property_add_state.dart';

class PropertyAddBloc extends Bloc<PropertyAddEvent, PropertyAddState> {
  PropertyAddBloc()
      : super(PropertyAddWidgetState(
            propertyState: new AddPropertyFormState(
                dropdownValue: 'PER MONTH',
                images: [],
                isLoading: false,
                submitSuccess: false,
                submitFailure: false)));

  @override
  Stream<PropertyAddState> mapEventToState(
    PropertyAddEvent event,
  ) async* {
    if (event is PropertyAddChangeDropDown) {
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              dropdownValue: event.dropdownValue,
              isLoading: false,
              submitFailure: false,
              submitSuccess: false));
    }
    if (event is PropertyAddImages) {
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              images: event.images,
              isLoading: false,
              submitFailure: false,
              submitSuccess: false));
    }
    if (event is PropertyAddRemote) {
      // print("updating");
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              isLoading: true, submitSuccess: false, submitFailure: false));

      await Future.delayed(Duration(seconds: 1));
      //do repository call here
      yield PropertyAddWidgetState(
          propertyState: state.propertyState.copyWith(
              isLoading: false, submitSuccess: true, submitFailure: false));
    }
  }
}
