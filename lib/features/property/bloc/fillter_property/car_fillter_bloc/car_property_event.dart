part of 'car_property_bloc.dart';

abstract class PropertyCarFillterEvent extends Equatable {
  const PropertyCarFillterEvent();
}
// property fillter events
class PropertyFilterCar extends PropertyCarFillterEvent {
  final List<Property> properties;
  PropertyFilterCar([this.properties = const []]);

  @override
  List<Property> get props => properties;
  // List<Property> get fillteredProperties => this.properties;
}


// class PropertyFillterRefresh extends Pro