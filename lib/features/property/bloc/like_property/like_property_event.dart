import 'package:equatable/equatable.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LikePropertyEvent extends Equatable {}

class LoadLikeStatus extends LikePropertyEvent {
  late final bool isLiked;
  LoadLikeStatus(List<dynamic> likedBy) {
    var loggedInUser;
    try {
      loggedInUser = getIt<SharedPreferences>().get("user");
    } catch (e) {
      loggedInUser = "6139bb374cd1c14db8d43bf8";
    }
    this.isLiked = likedBy.contains(loggedInUser);
    print("load like status ---- $isLiked");
  }
  @override
  List<Object?> get props => [isLiked];
}

class LikePropertyChanged extends LikePropertyEvent {
  final bool isLiked;
  LikePropertyChanged(this.isLiked);
  @override
  List<Object?> get props => [isLiked];
}

class LikePropertyFailed extends LikePropertyEvent {
  @override
  List<Object?> get props => [];
}
