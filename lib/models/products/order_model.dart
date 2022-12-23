// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    required this.id,
    required this.phoneCustomer,
    required this.email,
    required this.subtotal,
    required this.total,
    required this.orderStatus,
    required this.createdAt,
    required this.paymentMethod,
    required this.paymentSend,
    required this.location,
    required this.paymentCompleted,
    required this.customer,
    required this.cart,
  });

  int id;
  dynamic phoneCustomer;
  dynamic email;
  int subtotal;
  int total;
  String orderStatus;
  DateTime createdAt;
  String paymentMethod;
  bool paymentSend;
  String location;
  bool paymentCompleted;
  dynamic customer;
  int cart;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["id"],
        phoneCustomer: json["phone_customer"],
        email: json["email"],
        subtotal: json["subtotal"],
        total: json["total"],
        orderStatus: json["order_status"],
        createdAt: DateTime.parse(json["created_at"]),
        paymentMethod: json["payment_method"],
        paymentSend: json["payment_send"],
        location: json["location"],
        paymentCompleted: json["payment_completed"],
        customer: json["customer"],
        cart: json["cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_customer": phoneCustomer,
        "email": email,
        "subtotal": subtotal,
        "total": total,
        "order_status": orderStatus,
        "created_at": createdAt.toIso8601String(),
        "payment_method": paymentMethod,
        "payment_send": paymentSend,
        "location": location,
        "payment_completed": paymentCompleted,
        "customer": customer,
        "cart": cart,
      };
}
