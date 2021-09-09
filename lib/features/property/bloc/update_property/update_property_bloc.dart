import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'update_property_event.dart';
part 'update_property_state.dart';

class UpdatePropertyBloc
    extends Bloc<UpdatePropertyEvent, UpdatePropertyState> {
  UpdatePropertyBloc(this._propertyRepository)
      : super(UpdatePropertyLoadingProperty());

  final PropertyRepository _propertyRepository;

  @override
  Stream<UpdatePropertyState> mapEventToState(
    UpdatePropertyEvent event,
  ) async* {
    // yield UpdatePropertyLoadingProperty();
    if (event is UpdatePropertyLoadProperty) {
      final property =
          await _propertyRepository.getDetailedProduct(event.productId);
      print(property);
      yield UpdatePropertyLoadedProperty(
          property: property, isLoading: false, isLoaded: true);
    }
    if (event is UpdatePropertyUpdate) {
      yield UpdatePropertyLoadedProperty(
          property: event.property, isLoading: true, isLoaded: false);
      try {
        final updatedProperty =
            await _propertyRepository.updateProdcut(event.property);
        yield UpdatePropertyLoadedProperty(
            property: updatedProperty,
            isUpdated: true,
            isLoading: false,
            isLoaded: false);
        // print("Updated " + updatedProperty.title);
      } catch (e) {
        yield UpdatePropertyLoadedProperty(
            property: event.property,
            isUpdated: false,
            isLoading: false,
            isLoaded: false);
      }
    }
  }
}
