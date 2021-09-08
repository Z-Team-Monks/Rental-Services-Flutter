import 'package:flutter_bloc/flutter_bloc.dart';

import 'like_property_event.dart';
import 'like_property_state.dart';

class LikePropertyBloc extends Bloc<LikePropertyEvent, LikePropertyState> {
  LikePropertyBloc(LikePropertyState initialState) : super(initialState);

  @override
  Stream<LikePropertyState> mapEventToState(LikePropertyEvent event) async* {
    yield LikePropertyInprogress();
    if (event is LoadLikeStatus) {
      await Future.delayed(Duration(seconds: 2));
      final bool isLiked = true;
      yield LikeStatusLoadSuccess(isLiked);
    } else if (event is LikedProperty) {
      await Future.delayed(Duration(seconds: 2));
      yield LikePropertySuccess();
    } else if (event is UnlikedProperty) {
      yield LikeInitial();
    }
  }
}
