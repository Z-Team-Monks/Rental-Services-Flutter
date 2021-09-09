import 'package:rental/core/models/entity.dart';

class Review extends EntityModel {
  final String? userId;
  final String message;
  final double? rating;

  Review({
    this.userId,
    required this.message,
    this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json["id"],
      message: json["message"],
      rating: json["rating"] * 1.0,
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
