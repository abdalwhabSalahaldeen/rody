// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.title,
    this.image,
    this.showinhome,
  });

  int? id;
  String? title;
  String? image;
  bool? showinhome;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        showinhome: json["showinhome"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "showinhome": showinhome,
      };
}

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));

String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    required this.count,
    required this.next,
    required this.previous,
    required this.category,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Category> category;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        category: List<Category>.from(
            json["Category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "Category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}
