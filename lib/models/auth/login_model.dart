// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.pk,
    required this.name,
    required this.username,
    required this.email,
    required this.image,
    required this.phoneNumber,
    required this.dateJoined,
    required this.dateModified,
  });

  int pk;
  String name;
  String username;
  String email;
  String image;
  dynamic phoneNumber;
  DateTime dateJoined;
  DateTime dateModified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        image: json["image"],
        phoneNumber: json["phone_number"],
        dateJoined: DateTime.parse(json["date_joined"]),
        dateModified: DateTime.parse(json["date_modified"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "name": name,
        "username": username,
        "email": email,
        "image": image,
        "phone_number": phoneNumber,
        "date_joined": dateJoined.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
      };
}
