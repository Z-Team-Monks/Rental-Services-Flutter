part of 'house_property_bloc.dart';

abstract class PropertyHouseFillterEvent extends Equatable {
  const PropertyHouseFillterEvent();
}
// property fillter events
class PropertyFilterHouse extends PropertyHouseFillterEvent {
  final List<Property> properties;
  PropertyFilterHouse([this.properties = const []]);

  @override
  List<Property> get props => properties;
  // List<Property> get fillteredProperties => this.properties;
}
