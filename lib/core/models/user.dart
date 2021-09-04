import 'package:rental/core/models/entity.dart';

class User extends EntityModel {
  final String? id;
  final String? profileImage;
  final List<String>? likedProperties;
  final String name;
  final String email;
  final String? phoneNumber;
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
    this.phoneNumber,
  });

  User copyWith({
    String? id,
    String? profileImage,
    List<String>? likedProperties,
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    bool? isAdmin,
    int? v,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
    );
  }

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
