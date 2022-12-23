// To parse this JSON data, do
//
//     final room = roomFromJson(jsonString);

import 'dart:convert';

List<Room> roomFromJson(String str) =>
    List<Room>.from(json.decode(str).map((x) => Room.fromJson(x)));

String roomToJson(List<Room> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Room {
  Room({
    required this.id,
    required this.user1,
    required this.user2,
    required this.roomName,
    required this.name1,
    required this.name2,
    required this.image1,
    required this.image2,
  });

  int id;
  int user1;
  int user2;
  String roomName;
  String name1;
  String name2;
  String image1;
  String image2;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        user1: json["user1"],
        user2: json["user2"],
        roomName: json["room_name"],
        name1: json["name1"],
        name2: json["name2"],
        image1: json["image1"],
        image2: json["image2"] == null ? json["image1"] : json["image2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user1": user1,
        "user2": user2,
        "room_name": roomName,
        "name1": name1,
        "name2": name2,
        "image1": image1,
        "image2": image2 == image1 ? null : image2,
      };
}
