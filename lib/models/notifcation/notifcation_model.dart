// To parse this JSON data, do
//
//     final notifcation = notifcationFromJson(jsonString);

import 'dart:convert';

List<Notifcation> notifcationFromJson(String str) => List<Notifcation>.from(
    json.decode(str).map((x) => Notifcation.fromJson(x)));

String notifcationToJson(List<Notifcation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifcation {
  Notifcation({
    this.id,
    this.title,
    this.body,
    this.imageUrl,
    this.sendNow,
    this.date,
  });

  int? id;
  String? title;
  String? body;
  String? imageUrl;
  bool? sendNow;
  DateTime? date;

  factory Notifcation.fromJson(Map<String, dynamic> json) => Notifcation(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        imageUrl: json["image_url"],
        sendNow: json["send_now"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "image_url": imageUrl,
        "send_now": sendNow,
        "date": date!.toIso8601String(),
      };
}
