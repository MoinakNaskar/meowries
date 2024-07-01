// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String userName;
  final String gender;
  final String description;
  final String avatar;
  final List<String> links;
  final List<String> feedPhotos;
  final List<String> reels;

  UserModel(
      {required this.name,
      required this.email,
      required this.userName,
      required this.gender,
      required this.description,
      required this.avatar,
      required this.links,
      required this.feedPhotos,
      required this.reels});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'userName': userName,
      'gender': gender,
      'description': description,
      'avatar': avatar,
      'links': links,
      'feedPhotos': feedPhotos,
      'reels': reels,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      gender: map['gender'] as String,
      description: map['description'] as String,
      avatar: map['avatar'] as String,
      links: List<String>.from(map['links'] as List<String>),
      feedPhotos: List<String>.from(map['feedPhotos'] as List<String>),
      reels: List<String>.from(map['reels'] as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
