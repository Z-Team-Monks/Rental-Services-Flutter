part of 'propertydetail_bloc.dart';

abstract class PropertyDetailEvent extends Equatable {
  const PropertyDetailEvent();

  @override
  List<Object?> get props => [];
}

class RequestPropertyDetail extends PropertyDetailEvent {
  final String id;
  const RequestPropertyDetail({
    required this.id,
  });

  @override
  List<String?> get props => [id];
}
