part of 'ads_bloc.dart';

abstract class AdsState extends Equatable {
  const AdsState();
  @override
  List<Object?> get props => [];
}

class AdOperationFailure extends AdsState {}

class AdOperationLoading extends AdsState {}

class AdFetchOperationSuccess extends AdsState {
  
  final Iterable<Ad> ads;
  const AdFetchOperationSuccess([this.ads = const []]);

  @override
  List<Object?> get props => [ads];
}

class AdOperationSuccess extends AdsState {}

class InitialAds extends AdsState {}
