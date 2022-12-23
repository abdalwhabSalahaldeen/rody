// To parse this JSON data, do
//
//     final results = resultsFromJson(jsonString);

import 'dart:convert';

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));

String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    required this.count,
    required this.next,
    required this.previous,
    required this.product,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Product> product;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        product:
            List<Product>.from(json["Product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "Product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.getCategory,
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.price,
    required this.description,
    required this.warranty,
    required this.returnPolicy,
    required this.viewCount,
    required this.createdAt,
    required this.maxQuantity,
    required this.user,
    required this.category,
    required this.getRate,
  });

  String getCategory;
  int id;
  String title;
  String slug;
  String image;
  int price;
  String description;
  String warranty;
  dynamic returnPolicy;
  int viewCount;
  DateTime createdAt;
  int maxQuantity;
  int user;
  int category;
  double getRate;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        getCategory: json["getCategory"],
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        image: json["image"],
        price: json["price"],
        description: json["description"],
        warranty: json["warranty"] == null ? null : json["warranty"],
        returnPolicy: json["return_policy"],
        viewCount: json["view_count"],
        createdAt: DateTime.parse(json["created_at"]),
        maxQuantity: json["max_quantity"] == null ? null : json["max_quantity"],
        user: json["user"],
        category: json["category"],
        getRate: json["getRate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "getCategory": getCategory,
        "id": id,
        "title": title,
        "slug": slug,
        "image": image,
        "price": price,
        "description": description,
        "warranty": warranty == null ? null : warranty,
        "return_policy": returnPolicy,
        "view_count": viewCount,
        "created_at": createdAt.toIso8601String(),
        "max_quantity": maxQuantity == null ? null : maxQuantity,
        "user": user,
        "category": category,
        "getRate": getRate,
      };
}

List<CartFlutter> cartFlutterFromJson(String str) => List<CartFlutter>.from(
    json.decode(str).map((x) => CartFlutter.fromJson(x)));

String cartFlutterToJson(List<CartFlutter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuantityCartProduct {
  int quantity;
  int productId;
  QuantityCartProduct({
    required this.quantity,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'productId': productId,
    };
  }

  factory QuantityCartProduct.fromMap(Map<String, dynamic> map) {
    return QuantityCartProduct(
      quantity: map['quantity'],
      productId: map['productId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuantityCartProduct.fromJson(String source) =>
      QuantityCartProduct.fromMap(json.decode(source));
}

class CartFlutter {
  CartFlutter({
    required this.quantity,
    required this.productId,
    required this.rate,
    required this.title,
    required this.getCategory,
    required this.image,
  });

  int quantity;
  int productId;
  int rate;
  String title;
  String getCategory;
  String image;

  factory CartFlutter.fromJson(Map<String, dynamic> json) => CartFlutter(
        quantity: json["quantity"],
        productId: json["productId"],
        rate: json["rate"],
        title: json["title"],
        getCategory: json["getCategory"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "productId": productId,
        "rate": rate,
        "title": title,
        "getCategory": getCategory,
        "image": image,
      };
}
