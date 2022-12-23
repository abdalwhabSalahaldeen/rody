import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/models/products/order_model.dart';

class OrdersController extends GetxController {
  MainController mainController = Get.put(MainController());
  List orders = [];
  getOrders(token) async {
    print("get getOrders");
    var url = Uri.parse('https://rodyboutique.com/api/orders/');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) {
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // return reciver user to show image and name in messages screen

      for (var i = 0; i < responseDecode['results'].length; i++) {
        print(responseDecode['results']);
        orders.add(Orders.fromJson(responseDecode['results'][i]));
      }
      print(orders);

      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        //writeToken(null);
      } else {}
    });

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrders(mainController.userToken.read('token'));
  }
}
