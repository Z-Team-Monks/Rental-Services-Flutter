import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'other_property_event.dart';
part 'other_property_state.dart';

class FillterOtherPropertyBloc
    extends Bloc<PropertyOtherFillterEvent, FillterOtherPropertyState> {
  final PropertyRepository _propertyRepository;
  FillterOtherPropertyBloc(
    this._propertyRepository,
  ) : super(
          PropertyOtherInitial(),
        );

  @override
  Stream<FillterOtherPropertyState> mapEventToState(
      PropertyOtherFillterEvent event) async* {
    if (event is PropertyFilterOther) {
      yield PropertyOtherLoading();
      print("event -> PropertyFilterWithCategory");
      try {
        if (event.properties.length != 0) {
          print("event -> PropertyFilterWithCategory length != 0");
          var data = event.properties.map(
            (element) {
              if (element.category == "Other") {
                return element;
              }
            },
          );
          if (data.length == 0) {
            print("event -> PropertyFilterWithCategory data.length = 0");
            yield PropertyOtherNotFound();
          } else {
            print("event -> PropertyFilterWithCategory else");
            yield PropertyOtherSuccessF(data as List<Property>);
          }
        } else {
          var data = await _propertyRepository.propertyRemoteDataProvider
              .fetchByCategory("Other");

          if (data.length == 0) {
            yield PropertyOtherNotFound();
          } else
            yield PropertyOtherSuccessF(data);
        }
      } catch (e) {
        yield PropertyOtherFailure();
      }
    }
  }
}
