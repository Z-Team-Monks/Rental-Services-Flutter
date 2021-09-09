import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/features/property/repository/like_property/like_property_repository.dart';

import 'like_property_event.dart';
import 'like_property_state.dart';

class LikePropertyBloc extends Bloc<LikePropertyEvent, LikePropertyState> {
  final String propertyId;
  final String token;
  final LikePropertyRepository likePropertyRepository;
  LikePropertyBloc({required this.likePropertyRepository})
      : propertyId = "6139bbd54cd1c14db8d43bfc",
        token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMzliYjM3NGNkMWMxNGRiOGQ0M2JmOCIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2MzExNzM1NDV9.DoR9lgtTcYlEYMxnnEV4-n56eargHLp3Ipkxkbrlou0",
        super(LikePropertyInitial());

  @override
  Stream<LikePropertyState> mapEventToState(LikePropertyEvent event) async* {
    yield LikePropertyInprogress();
    if (event is LoadLikeStatus) {
      yield LikeStatusLoadSuccess(event.isLiked);
    } else if (event is LikePropertyChanged) {
      int likeCount;
      if (event.isLiked) {
        try {
          likeCount = await likePropertyRepository.likePropertyRemote(
            propertyId: propertyId,
            token: token,
          );
          print("--- like property success ----");
        } catch (e) {
          print(e.toString());
          yield LikePropertyInitial();
        }
      } else {
        try {
          likeCount = await likePropertyRepository.unlikePropertyRemote(
            propertyId: propertyId,
            token: token,
          );
          print("--- like property success ----");
        } catch (e) {
          print(e.toString());
          yield LikePropertyInitial();
        }
      }
      yield LikePropertySuccess(event.isLiked);
    } else {
      yield LikePropertyInitial();
    }
  }
}
