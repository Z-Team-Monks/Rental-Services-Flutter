import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/bloc/Ads/ads_bloc.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'propertydetail_event.dart';
part 'propertydetail_state.dart';



class PropertyDetailBloc extends Bloc<PropertyDetailEvent, PropertyDetailState> {
  final PropertyRepository propertyRepository;
  PropertyDetailBloc({required this.propertyRepository,}) : super(PropertyDetailInitial());

  @override
  Stream<PropertyDetailState> mapEventToState(PropertyDetailEvent event) async* {
    if(event is RequestPropertyDetail) {
      yield PropertyDetailLoading();
      try {
        // call the detail repo in here
        // yield PropertyDetailOperationSuccess(property);
      } catch (e) {
        yield PropertyDetailOperationFailure();
      }
    }
  }
}


