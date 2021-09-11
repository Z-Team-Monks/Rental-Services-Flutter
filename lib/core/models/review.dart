import 'package:rental/core/models/entity.dart';
import 'package:rental/core/models/user.dart';

class Review extends EntityModel {
  final String? userId;
  final User? user;
  final String message;
  final double? rating;

  Review({
    this.userId,
    required this.message,
    this.rating,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      // userId: json["id"],
      message: json["message"],
      rating: json["rating"] * 1.0,
      // user: User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "id": this.userId,
      "message": this.message,
      "rating": this.rating,
    };
  }
}
