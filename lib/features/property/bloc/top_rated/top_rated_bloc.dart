import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/repository/top_rated/top_rated_repository.dart';
part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final TopRatedRepository topRatedRepository;
  TopRatedBloc({
    required this.topRatedRepository,
  }) : super(TopRatedInitial());

  @override
  Stream<TopRatedState> mapEventToState(TopRatedEvent event) async* {
    if (event is LoadTopRated) {
      yield TopRatedOperationLoading();
      try {
        var data = await this.topRatedRepository.getTopRatedProperties();
        yield TopRatedOperationSuccess(data);
      } catch (e) {
        yield TopRatedOperationFailure();
      }
    } 
  }
}
