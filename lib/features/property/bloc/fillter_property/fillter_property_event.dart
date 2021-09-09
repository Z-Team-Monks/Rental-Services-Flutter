part of 'fillter_property_bloc.dart';

abstract class PropertyFillterEvent extends Equatable {
  const PropertyFillterEvent();
}
// property fillter events
class PropertyFilterWithCategory extends PropertyFillterEvent {
  final String category;
  final List<Property> properties;
  PropertyFilterWithCategory(this.category, [this.properties = const []]);

  @override
  List<String?> get props => [category];
  List<Property> get fillteredProperties => this.properties;
}


// class PropertyFillterRefresh extends Pro