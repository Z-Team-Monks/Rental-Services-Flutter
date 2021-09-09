part of 'update_property_bloc.dart';

abstract class UpdatePropertyState extends Equatable {
  const UpdatePropertyState();

  @override
  List<Object> get props => [];
}

class UpdatePropertyLoadingProperty extends UpdatePropertyState {}

class UpdatePropertyLoadingFailed extends UpdatePropertyState {}

class UpdatePropertyLoadedProperty extends UpdatePropertyState {
  Property property;
  bool? isUpdated;
  bool isLoading;
  bool isLoaded;

  UpdatePropertyLoadedProperty(
      {required this.property,
      required this.isLoading,
      required this.isLoaded,
      this.isUpdated});
  List<Object> get props => [property, isLoading];
}

// class UpdateProperty extends UpdatePropertyState {}

// class UpdaePropertyProperty extends UpdatePropertyState {}
