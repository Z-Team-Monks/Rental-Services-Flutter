import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'car_property_event.dart';
part 'car_property_state.dart';

class FillterCarPropertyBloc
    extends Bloc<PropertyCarFillterEvent, FillterCarPropertyState> {
  final PropertyRepository _propertyRepository;
  FillterCarPropertyBloc(
    this._propertyRepository,
  ) : super(
          PropertyCarInitial(),
        );

  @override
  Stream<FillterCarPropertyState> mapEventToState(
      PropertyCarFillterEvent event) async* {
    if (event is PropertyFilterCar) {
      yield PropertyCarLoading();
      print("event -> PropertyFilterWithCategory");
      try {
        if (event.properties.length != 0) {
          print("event -> PropertyFilterWithCategory length != 0");
          var data = event.properties.map(
            (element) {
              if (element.category == "Car") {
                return element;
              }
            },
          );
          if (data.length == 0) {
            print("event -> PropertyFilterWithCategory data.length = 0");
            yield PropertyCarNotFound();
          } else {
            print("event -> PropertyFilterWithCategory else");
            yield PropertyCarSuccessF(data as List<Property>);
          }
        } else {
          var data = await _propertyRepository.propertyRemoteDataProvider
              .fetchByCategory("Car");

          if (data.length == 0) {
            yield PropertyCarNotFound();
          } else
            yield PropertyCarSuccessF(data);
        }
      } catch (e) {
        yield PropertyCarFailure();
      }
    }
  }
}
