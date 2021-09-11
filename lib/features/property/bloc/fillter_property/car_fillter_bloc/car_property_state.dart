part of 'car_property_bloc.dart';

abstract class FillterCarPropertyState extends Equatable {
  const FillterCarPropertyState();

  @override
  List<Property> get props => [];
}

// property fllter bloc states
class PropertyCarSuccessF extends FillterCarPropertyState {
  final List<Property> properties;
  PropertyCarSuccessF(this.properties);
  @override
  List<Property> get props => properties;
}

class PropertyCarFailure extends FillterCarPropertyState {}

class PropertyCarInitial extends FillterCarPropertyState {}

class PropertyCarLoading extends FillterCarPropertyState {}

class PropertyCarNotFound extends FillterCarPropertyState {}
