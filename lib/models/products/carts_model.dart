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
    required this.cart,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Cart> cart;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        cart: List<Cart>.from(json["Cart"].map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "Cart": List<dynamic>.from(cart.map((x) => x.toJson())),
      };
}

class Cart {
  Cart({
    required this.id,
    required this.total,
    required this.createdAt,
    required this.customer,
  });

  int id;
  double total;
  DateTime createdAt;
  int customer;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        total: json["total"],
        createdAt: DateTime.parse(json["created_at"]),
        customer: json["customer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "customer": customer,
      };
}
