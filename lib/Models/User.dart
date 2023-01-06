import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String name;
  final String major;
  final String studyAt;
  final String imageProfil;

  User(
      {@required this.id,
      @required this.name,
      @required this.major,
      @required this.studyAt,
      @required this.imageProfil});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['nama'],
        major: json['major'],
        studyAt: json['studyAt'],
        imageProfil: json['imageProfil']);
  }
}
