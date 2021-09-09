import 'package:floor/floor.dart';

@Entity(tableName: "users")
class UserEntity {
  @primaryKey
  final String id;
  final String profileImage;
  final String name;
  final String email;
  final bool isAdmin;

  UserEntity(
      {required this.id,
      required this.email,
      required this.name,
      required this.profileImage,
      required this.isAdmin});
}

@Entity(tableName: "images")
class ImageEntity {
  @primaryKey
  final String id;
  final int isFromUser;
  final String imageUrl;

  ImageEntity({
    required this.id,
    required this.isFromUser,
    required this.imageUrl,
  });
}

@Entity(tableName: "properties")
class PropertyEntity {
  @primaryKey
  final String id;
  final String ownerid;
  final String createdAt;
  final String updatedAt;
  final String title;
  final String description;
  final String category;
  final double bill;
  final String per;
  final String status;
  final double rating;

  PropertyEntity({
    required this.id,
    required this.ownerid,
    required this.title,
    required this.description,
    required this.category,
    required this.bill,
    required this.per,
    required this.status,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ReviewEntity {}
