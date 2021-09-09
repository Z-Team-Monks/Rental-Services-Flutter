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


// property fillter events
class PropertySearch extends PropertyEvent {
  final String keyWord;
  PropertySearch({required this.keyWord});

  @override
  List<Property?> get props => [];
}

// class PropertyFilterWithCategory extends PropertyEvent {
//   final String category;
//   final List<Property> properties;
//   PropertyFilterWithCategory(this.category, [this.properties = const []]);

//   @override
//   List<String?> get props => [category];
//   List<Property> get fillteredProperties => this.properties;
// }


