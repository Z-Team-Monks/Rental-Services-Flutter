import 'package:rental/core/models/entity.dart';

class User extends EntityModel {
  final String? id;
  final String? profileImage;
  final List<dynamic>? likedProperties;
  final List<dynamic>? posts;
  final String name;
  final String email;
  final String? phoneNumber;
  //should password be here?
  final String? password;
  final bool? isAdmin;
  final int? v;

  User({
    required this.name,
    required this.email,
    this.id,
    this.profileImage,
    this.likedProperties,
    this.posts,
    this.phoneNumber,
    this.password,
    this.isAdmin,
    this.v,
  });

  User copyWith({
    String? name,
    String? email,
    String? id,
    String? profileImage,
    List<dynamic>? likedProperties,
    List<dynamic>? posts,
    String? password,
    String? phoneNumber,
    bool? isAdmin,
    int? v,
  }) {
    return User(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      likedProperties: likedProperties ?? this.likedProperties,
      posts: posts ?? this.posts,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      profileImage: json["profileImage"],
      likedProperties: json["likedProperties"],
      posts: json["posts"],
      password: json["password"],
      phoneNumber: json["phoneNumber"],
      isAdmin: json["isAdmin"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "profileImage": this.profileImage,
      "likedProperties": this.likedProperties,
      "posts": this.posts,
      "password": this.password,
      "phoneNumber": this.phoneNumber,
      "isAdmin": this.isAdmin,
      "phoneNumber": this.isAdmin
    };
  }
}
