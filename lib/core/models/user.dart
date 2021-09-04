import 'package:rental/core/models/entity.dart';

class User extends EntityModel {
  final String? id;
  final String? profileImage;
  final List<String>? likedProperties;
  final String name;
  final String email;
  final String? password;
  final bool? isAdmin;
  final int? v;

  User({
    required this.name,
    required this.email,
    this.id,
    this.isAdmin,
    this.password,
    this.profileImage,
    this.likedProperties,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      isAdmin: json["isAdmin"],
      profileImage: json["profileImage"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profileImage": this.profileImage,
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "isAdmin": this.isAdmin,
    };
  }
}
