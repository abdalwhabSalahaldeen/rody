// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.isDelvery,
    required this.isread,
    required this.senderId,
    required this.reciverId,
  });

  int id;
  String message;
  String timestamp;
  bool isDelvery;
  bool isread;
  int senderId;
  int reciverId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        message: json["message"],
        timestamp: json["timestamp"],
        isDelvery: json["isDelvery"],
        isread: json["isread"],
        senderId: json["senderId"],
        reciverId: json["reciverId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "timestamp": timestamp,
        "isDelvery": isDelvery,
        "isread": isread,
        "senderId": senderId,
        "reciverId": reciverId,
      };
}
