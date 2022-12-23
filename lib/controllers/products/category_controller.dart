import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rody_app/controllers/products/product_controller.dart';
import 'package:rody_app/models/products/categorys_model.dart';

class CategorysController extends GetxController {
  var productsController = Get.put(ProductsController(), permanent: true);
  List categorys = [];

  getProductsCategory(caetogry) {
    productsController.productsfliter.clear();
    productsController.next = 'begin';
    productsController.getProducts(filter: caetogry);
  }

  getCategorys() async {
    print("get getCategorys");
    var url = Uri.parse('https://rodyboutique.com/api/categorys/');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // return reciver user to show image and name in messages screen

      for (var i = 0; i < responseDecode['results'].length; i++) {
        categorys.add(Category.fromJson(responseDecode['results'][i]));
      }
      print(categorys);

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
    getCategorys();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
