part of 'house_property_bloc.dart';

abstract class FillterHousePropertyState extends Equatable {
  const FillterHousePropertyState();

  @override
  List<Property> get props => [];
}

// property fllter bloc states
class PropertyHouseSuccessF extends FillterHousePropertyState {
  final List<Property> properties;
  PropertyHouseSuccessF(this.properties);
  @override
  List<Property> get props => properties;
}

class PropertyHouseFailure extends FillterHousePropertyState {}

class PropertyHouseInitial extends FillterHousePropertyState {}

class PropertyHouseLoading extends FillterHousePropertyState {}

class PropertyHouseNotFound extends FillterHousePropertyState {}
