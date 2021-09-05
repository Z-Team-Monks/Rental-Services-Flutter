part of 'property_add_bloc.dart';

class AddPropertyFormState extends Equatable {
  final String dropdownValue;
  final List<XFile> images;
  final bool isLoading;
  final bool submitSuccess;
  final bool submitFailure;

  AddPropertyFormState(
      {required this.dropdownValue,
      required this.images,
      required this.isLoading,
      required this.submitSuccess,
      required this.submitFailure});

  AddPropertyFormState copyWith(
          {String? dropdownValue,
          List<XFile>? images,
          bool? isLoading,
          bool? submitSuccess,
          bool? submitFailure}) =>
      AddPropertyFormState(
          dropdownValue: dropdownValue ?? this.dropdownValue,
          images: images ?? this.images,
          isLoading: isLoading ?? this.isLoading,
          submitSuccess: submitSuccess ?? this.submitSuccess,
          submitFailure: submitFailure ?? this.submitFailure);

  @override
  List<Object> get props =>
      [dropdownValue, images, isLoading, submitSuccess, submitFailure];
}

abstract class PropertyAddState extends Equatable {
  final AddPropertyFormState propertyState;
  // final String dropDownValue;
  PropertyAddState({required this.propertyState});
  @override
  List<Object> get props => [propertyState];
}

class PropertyAddWidgetState extends PropertyAddState {
  PropertyAddWidgetState({required AddPropertyFormState propertyState})
      : super(propertyState: propertyState);
}
