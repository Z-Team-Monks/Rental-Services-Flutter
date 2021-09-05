part of 'property_add_bloc.dart';

// class AddPropertyFormEventValue {
//   final String dropdownValue;
//   final List<XFile> images;
//   final String
// }

abstract class PropertyAddEvent extends Equatable {
  final String dropdownValue;
  final List<XFile> images;
  // final String dropdownValue;
  PropertyAddEvent({required this.dropdownValue, required this.images});
  @override
  List<Object> get props => [];
}

class PropertyAddChangeDropDown extends PropertyAddEvent {
  PropertyAddChangeDropDown(
      {required String dropdownValue, required List<XFile> images})
      : super(dropdownValue: dropdownValue, images: images);
}

class PropertyAddImages extends PropertyAddEvent {
  PropertyAddImages(
      {required String dropdownValue, required List<XFile> images})
      : super(dropdownValue: dropdownValue, images: images);
}

class PropertyAddRemote extends PropertyAddEvent {
  final Property property;
  PropertyAddRemote(
      {required this.property,
      required String dropdownValue,
      required List<XFile> images})
      : super(dropdownValue: dropdownValue, images: images);
}
