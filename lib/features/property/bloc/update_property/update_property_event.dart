part of 'update_property_bloc.dart';

abstract class UpdatePropertyEvent extends Equatable {
  const UpdatePropertyEvent();

  @override
  List<Object> get props => [];
}

class UpdatePropertyLoadProperty extends UpdatePropertyEvent {
  final productId;

  UpdatePropertyLoadProperty({required this.productId});
  @override
  List<Object> get props => [productId];
}

class UpdatePropertyUpdate extends UpdatePropertyEvent {
  final Property property;

  UpdatePropertyUpdate({required this.property});
}
