import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part "property_event.dart";
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _propertyRepository;
  PropertyBloc(
    this._propertyRepository,
  ) : super(PropertyLoading());

  @override
  Stream<PropertyState> mapEventToState(PropertyEvent event) async* {
    if (event is PropertiesLoad) {
      print("----------------PRoperties Load---------------");
      yield PropertyLoading();
      try {
        await Future.delayed(
          Duration(seconds: 3),
        );
        List<Property> data = [];
      print("----------------PRoperties Load---------------");

        // var data = await _propertyRepository.propertyRemoteDataProvider
        //     .getProperties();
        yield PropertyOperationSuccess(data);
      } catch (e) {
        yield PropertyOperationFailure();
      }
    } else if (event is PropertyFilter) {
      yield PropertyLoading();
      try {
        // var keyword = (event.keyWord);
        // var data = await _propertyRepository.propertyRemoteDataProvider
        //     .getProperties();
        // yield PropertyOperationSuccess(data);
      } catch (e) {
        yield PropertyOperationFailure();
      }
    } else if (event is PropertyCreate) {
      yield PropertyLoading();
      try {
        // var data = await _propertyRepository.propertyRemoteDataProvider
        //     .createProperty(property: property, token: token)();
        // yield PropertyOperationSuccess(data);
      } catch (e) {
        yield PropertyOperationFailure();
      }
    } else {}
  }
}
