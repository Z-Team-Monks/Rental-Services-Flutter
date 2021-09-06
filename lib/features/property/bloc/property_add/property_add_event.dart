part of 'property_add_bloc.dart';

class AddPropertyFormEventValue {
  final String dropdownValue;
  final List<XFile> images;
  final String category;

  AddPropertyFormEventValue(
      {required this.dropdownValue,
      required this.images,
      required this.category});

  List<Object> get props => [dropdownValue, images, category];
}

abstract class PropertyAddEvent extends Equatable {
  final AddPropertyFormEventValue properyEventValue;
  PropertyAddEvent({required this.properyEventValue});

  @override
  List<Object> get props => [properyEventValue];
}

class PropertyAddChangePerDropDown extends PropertyAddEvent {
  PropertyAddChangePerDropDown(
      {required AddPropertyFormEventValue properyEventValue})
      : super(properyEventValue: properyEventValue);
}

class PropertyAddChangeCategoryDropDown extends PropertyAddEvent {
  PropertyAddChangeCategoryDropDown(
      {required AddPropertyFormEventValue properyEventValue})
      : super(properyEventValue: properyEventValue);
}

class PropertyAddImages extends PropertyAddEvent {
  PropertyAddImages({required AddPropertyFormEventValue properyEventValue})
      : super(properyEventValue: properyEventValue);
}

class PropertyAddRemote extends PropertyAddEvent {
  final Property property;
  List<XFile> images;
  PropertyAddRemote(
      {required this.property,
      required this.images,
      required AddPropertyFormEventValue properyEventValue})
      : super(properyEventValue: properyEventValue);
}
