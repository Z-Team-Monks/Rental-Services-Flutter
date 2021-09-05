part of "property_bloc.dart";

abstract class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertyOperationSuccess extends PropertyState {
  final Iterable<Property> properties;

  PropertyOperationSuccess([this.properties = const []]);

  @override
  List<Object> get props => [properties];
}

class PropertyOperationFailure extends PropertyState {}
