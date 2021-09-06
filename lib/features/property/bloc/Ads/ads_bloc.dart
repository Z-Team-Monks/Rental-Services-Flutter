import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'ads_event.dart';
part "ads_state.dart";

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  final AdsRepository adsRepository;
  AdsBloc({
    required this.adsRepository,
  }) : super(InitialAds());

  @override
  Stream<AdsState> mapEventToState(AdsEvent event) async* {
    if (event is RequestAd) {
      yield AdOperationLoading();
      try {
        await Future.delayed(Duration(seconds: 5));
        // await this.adsRepository.store(event.ad);
        yield AdOperationSuccess();
      } catch (e) {
        yield AdOperationFailure();
      }
    } else if (event is LoadAds) {
      print("--------------Load Ads----------------");
      yield AdOperationLoading();
      try {
        await Future.delayed(Duration(seconds: 5));

        // var data = await this.adsRepository.loadAds();
        print("--------------Load Ads Success----------------");

        yield AdFetchOperationSuccess(
          [],
        );
      } catch (e) {
        yield AdOperationFailure();
      }
      
      print("--------------Load Ads End----------------");
    } else {}
  }
}

class AdsRepository {
  store(Ad ad) {}

  loadAds() {
    return [];
  }
}
