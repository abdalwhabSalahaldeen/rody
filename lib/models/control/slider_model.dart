// To parse this JSON data, do
//
//     final SliderModel = SliderModelFromJson(jsonString);

import 'dart:convert';

List<SliderModel> SliderModelFromJson(String str) => List<SliderModel>.from(
    json.decode(str).map((x) => SliderModel.fromJson(x)));

String SliderModelToJson(List<SliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  SliderModel({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });

  int id;
  String title;
  String image;
  dynamic link;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "link": link,
      };
}
