part of 'propertydetail_bloc.dart';

abstract class PropertyDetailState extends Equatable {
  const PropertyDetailState();
  @override
  List<Object?> get props => [];
}

class PropertyDetailInitial extends PropertyDetailState {}

class PropertyDetailLoading extends PropertyDetailState {}

class PropertyDetailOperationSuccess extends PropertyDetailState {
  final Property? property;
  const PropertyDetailOperationSuccess(this.property);

  @override
  List<Property?> get props => [
        this.property,
      ];
}

class PropertyDetailOperationFailure extends PropertyDetailState {}
