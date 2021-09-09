part of 'other_property_bloc.dart';

abstract class FillterOtherPropertyState extends Equatable {
  const FillterOtherPropertyState();

  @override
  List<Property> get props => [];
}

// property fllter bloc states
class PropertyOtherSuccessF extends FillterOtherPropertyState {
  final List<Property> properties;
  PropertyOtherSuccessF(this.properties);
  @override
  List<Property> get props => properties;
}

class PropertyOtherFailure extends FillterOtherPropertyState {}

class PropertyOtherInitial extends FillterOtherPropertyState {}

class PropertyOtherLoading extends FillterOtherPropertyState {}

class PropertyOtherNotFound extends FillterOtherPropertyState {}
