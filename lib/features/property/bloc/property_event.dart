part of "property_bloc.dart";

abstract class PropertyEvent extends Equatable {
  const PropertyEvent();
}

class PropertiesLoad extends PropertyEvent {
  const PropertiesLoad();

  @override
  List<Object> get props => [];
}

class PropertyCreate extends PropertyEvent {
  final Property property;

  const PropertyCreate(this.property);

  @override
  List<Object> get props => [property];

  @override
  String toString() => 'Property Created {property: $property}';
}

class PropertyFilter extends PropertyEvent {
  final String keyWord;
  PropertyFilter({required this.keyWord});

  @override
  List<Property?> get props => [];
}
