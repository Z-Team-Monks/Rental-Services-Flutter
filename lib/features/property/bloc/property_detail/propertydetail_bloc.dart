import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/property_repository.dart';

part 'propertydetail_event.dart';
part 'propertydetail_state.dart';

class PropertyDetailBloc
    extends Bloc<PropertyDetailEvent, PropertyDetailState> {
  final PropertyRepository propertyRepository;
  PropertyDetailBloc({
    required this.propertyRepository,
  }) : super(PropertyDetailInitial());

  @override
  Stream<PropertyDetailState> mapEventToState(
      PropertyDetailEvent event) async* {
    if (event is RequestPropertyDetail) {
      yield PropertyDetailLoading();
      try {
        print("--- property id -- ${event.props[0]}");
        var data =
            await propertyRepository.propertyRemoteDataProvider.getProperty(
          event.props[0]!,
        );
        print("${data.reviewes} -- reviews return");
        yield PropertyDetailOperationSuccess(data);
      } catch (e) {
        print(e.toString());
        yield PropertyDetailOperationFailure();
      }
    }
  }
}
