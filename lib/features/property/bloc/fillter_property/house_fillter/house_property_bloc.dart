import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'house_property_event.dart';
part 'house_property_state.dart';

class FillterHousePropertyBloc
    extends Bloc<PropertyHouseFillterEvent, FillterHousePropertyState> {
  final PropertyRepository _propertyRepository;
  FillterHousePropertyBloc(
    this._propertyRepository,
  ) : super(
          PropertyHouseInitial(),
        );

  @override
  Stream<FillterHousePropertyState> mapEventToState(
      PropertyHouseFillterEvent event) async* {
    if (event is PropertyFilterHouse) {
      yield PropertyHouseLoading();
      print("event -> PropertyFilterWithCategory");
      try {
        if (event.properties.length != 0) {
          print("event -> PropertyFilterWithCategory length != 0");
          var data = event.properties.map(
            (element) {
              if (element.category == "House") {
                return element;
              }
            },
          );
          if (data.length == 0) {
            print("event -> PropertyFilterWithCategory data.length = 0");
            yield PropertyHouseNotFound();
          } else {
            print("event -> PropertyFilterWithCategory else");
            yield PropertyHouseSuccessF(data as List<Property>);
          }
        } else {
          var data = await _propertyRepository.propertyRemoteDataProvider
              .fetchByCategory("House");

          if (data.length == 0) {
            yield PropertyHouseNotFound();
          } else
            yield PropertyHouseSuccessF(data);
        }
      } catch (e) {
        yield PropertyHouseFailure();
      }
    }
  }
}
