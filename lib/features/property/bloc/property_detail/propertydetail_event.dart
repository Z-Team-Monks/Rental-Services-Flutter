part of 'propertydetail_bloc.dart';

abstract class PropertyDetailEvent extends Equatable {
  const PropertyDetailEvent();

  @override
  List<Object?> get props => [];
}

class RequestPropertyDetail extends PropertyDetailEvent {
  const RequestPropertyDetail({
    required String id,
  });
}

