part of "property_bloc.dart";

abstract class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Property> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyOperationSuccess extends PropertyState {
  final List<Property> properties;

  PropertyOperationSuccess([this.properties = const []]);

  @override
  List<Property> get props => properties;
}

class PropertyOperationFailure extends PropertyState {}

class PropertyNotFound extends PropertyState {}

// property fllter bloc states
class PropertyFillturedSuccess extends PropertyState {
  final List<Property> properties;
  PropertyFillturedSuccess(this.properties);
  @override
  List<Property> get props => properties;
}

class PropertyFeedEmpty extends PropertyState {}
