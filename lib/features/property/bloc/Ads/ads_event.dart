part of "ads_bloc.dart";

abstract class AdsEvent extends Equatable {
  const AdsEvent();
  @override
  List<Object?> get props => [];
}

class RequestAd extends AdsEvent {
  final Ad ad;
  const RequestAd({required this.ad});
}

class LoadAds extends AdsEvent {}

class Ad {}
