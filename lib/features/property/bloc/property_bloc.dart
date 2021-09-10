import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:sqflite/sqflite.dart';

part "property_event.dart";
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _propertyRepository;
  PropertyBloc(
    this._propertyRepository,
  ) : super(
          PropertyLoading(),
        );

  @override
  Stream<PropertyState> mapEventToState(PropertyEvent event) async* {
    if (event is PropertiesLoad) {
      yield PropertyLoading();
      try {
        var data = await _propertyRepository.getPropertiesFromRemote();

        if (data!.length == 0) {
          yield PropertyFeedEmpty();
        } else
          yield PropertyOperationSuccess(data);
      } catch (e) {
        print(e.toString());
        yield PropertyOperationFailure();
      }
    } else if (event is PropertySearch) {
      yield PropertyLoading();
      try {
        var keyword = (event.keyWord);
        var data = await _propertyRepository.propertyRemoteDataProvider
            .searchProperty(keyword);
        if (data.length == 0) {
          yield PropertyNotFound();
        } else
          yield PropertyOperationSuccess(data);
      } catch (e) {
        yield PropertyOperationFailure();
      }
    } else if (event is PropertyCreate) {
      yield PropertyLoading();
      try {
        /* you will make a call to remote to create a property resource*/
      } catch (e) {
        yield PropertyOperationFailure();
      }
    } else {}
  }
}
