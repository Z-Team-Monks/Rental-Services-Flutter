part of 'other_property_bloc.dart';

abstract class PropertyOtherFillterEvent extends Equatable {
  const PropertyOtherFillterEvent();
}
// property fillter events
class PropertyFilterOther extends PropertyOtherFillterEvent {
  final List<Property> properties;
  PropertyFilterOther([this.properties = const []]);

  @override
  List<Property> get props => properties;
  // List<Property> get fillteredProperties => this.properties;
}


// class PropertyFillterRefresh extends Pro