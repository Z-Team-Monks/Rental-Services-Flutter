import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'fillter_property_event.dart';
part 'fillter_property_state.dart';

class FillterPropertyBloc
    extends Bloc<PropertyFillterEvent, FillterPropertyState> {
  final PropertyRepository _propertyRepository;
  FillterPropertyBloc(
    this._propertyRepository,
  ) : super(
          PropertyFilltureInitial(),
        );

  @override
  Stream<FillterPropertyState> mapEventToState(
      PropertyFillterEvent event) async* {
    if (event is PropertyFilterWithCategory) {
      yield PropertyFilltureLoading();
      print("event -> PropertyFilterWithCategory");
      try {
        if (event.properties.length != 0) {
          print("event -> PropertyFilterWithCategory length != 0");
          var data = event.properties.map(
            (element) {
              if (element.category == event.category) {
                return element;
              }
            },
          );
          if (data.length == 0) {
            print("event -> PropertyFilterWithCategory data.length = 0");
            yield PropertyFillterNotFound();
          } else {
            print("event -> PropertyFilterWithCategory else");
            yield PropertyFillturedSuccessF(data as List<Property>);
          }
        } else {
          var data = await _propertyRepository.propertyRemoteDataProvider
              .fetchByCategory(event.category);

          if (data.length == 0) {
            yield PropertyFillterNotFound();
          } else
            yield PropertyFillturedSuccessF(data);
        }
      } catch (e) {
        yield PropertyFillturedFailure();
      }
    }
  }
}
