import 'package:rental/core/models/entity.dart';
import 'package:rental/core/models/review.dart';
import 'package:rental/core/models/user.dart';

class Property extends EntityModel {
  final String? id;
  final String? ownerid;
  final String? createdAt;
  final String? updatedAt;
  final String title;
  final String description;
  String category;
  final double bill;
  String per;
  // TODO: improve by createing an image model
  final List<dynamic> images;
  final String? status;
  final double? rating;
  final User? owner;
  // TODO: improve by createing a review model
  final List<dynamic>? reviewes;
  final List<dynamic>? likedBy;
  bool visible = true;

  Property({
    this.id,
    this.ownerid,
    required this.title,
    required this.description,
    required this.category,
    required this.bill,
    required this.per,
    required this.images,
    this.status,
    this.rating,
    this.reviewes,
    this.createdAt,
    this.updatedAt,
    this.likedBy,
    this.owner,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["_id"],
      status: json["status"],
      rating: json["rating"] * 1.0,
      reviewes:
          (json["reviewes"] as List).map((i) => Review.fromJson(i)).toList(),
      likedBy: json["likedBy"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      bill: json["cost"]["bill"] * 1.0, //double.tryParse(jjson["cost"]["bill"])
      per: json["cost"]["per"],
      ownerid: json["ownerid"],
      createdAt: json["createdAt"],
      owner: User.fromJson(
        json["owner"],
      ),
      images: json["images"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": this.status,
      "rating": this.rating,
      "_id": this.id,
      "title": this.title,
      "description": this.description,
      "category": this.category,
      "bill": this.bill,
      "per": this.per,
      "ownerid": this.ownerid,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}
