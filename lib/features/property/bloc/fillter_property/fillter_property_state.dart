part of 'fillter_property_bloc.dart';

abstract class FillterPropertyState extends Equatable {
  const FillterPropertyState();

  @override
  List<Property> get props => [];
}

// property fllter bloc states
class PropertyFillturedSuccessF extends FillterPropertyState {
  final List<Property> properties;
  PropertyFillturedSuccessF(this.properties);
  @override
  List<Property> get props => properties;
}

class PropertyFillturedFailure extends FillterPropertyState {}

class PropertyFilltureInitial extends FillterPropertyState {}

class PropertyFilltureLoading extends FillterPropertyState {}

class PropertyFillterNotFound extends FillterPropertyState {}
