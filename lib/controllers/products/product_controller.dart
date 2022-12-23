import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rody_app/models/products/products_model.dart';

class ProductsController extends GetxController {
  List products = [];
  List productsfliter = [];
  List favorites = [];
  IconData favoriteIcon = Icons.favorite_border;
  GetStorage favorite = GetStorage();
  favoriteOnPressed(index) {
    update();
  }

  bool enablePullUp = true;

  enablePullUpupdate() {
    print("run update pull");
    enablePullUp = false;
    update();
  }

  var next = 'begin';
  getProducts({filter = null}) async {
    print("get getProducts");
    var url;
    print("url == $url");
    print(url.runtimeType);

    if (next == 'begin') {
      if (filter != null) {
        url = Uri.parse(
            'https://rodyboutique.com/api/products/?category=$filter');
      } else {
        url = Uri.parse('https://rodyboutique.com/api/products/');
      }
      print("url begin $url");
    } else if (next != null && next != 'begin') {
      print("url not begin nut null $url");
      if (filter != null) {
        url = Uri.parse('$next&category=$filter');
      } else {
        url = Uri.parse('$next');
      }
    }
    if (next != null) {
      await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }).then((response) {
        dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

        // return reciver user to show image and name in messages screen

        if (response.statusCode == 200) {
          print('next in response $next');
          if (next == 'begin') {
            if (filter != null) {
              productsfliter.clear();
            } else {
              products.clear();
            }

            for (var i = 0; i < responseDecode['results'].length; i++) {
              if (filter != null) {
                productsfliter
                    .add(Product.fromJson(responseDecode['results'][i]));
              } else {
                products.add(Product.fromJson(responseDecode['results'][i]));
              }
            }
          } else if (next != null && next != 'begin') {
            print("next != null && next != 'begin'");
            for (var i = 0; i < responseDecode['results'].length; i++) {
              if (filter != null) {
                productsfliter
                    .add(Product.fromJson(responseDecode['results'][i]));
              } else {
                products.add(Product.fromJson(responseDecode['results'][i]));
              }
            }

            print("next != null && next != 'begin'");
            print(productsfliter);
          }

          print("next");
          print(responseDecode['next']);
          next = responseDecode['next'];
          print(next);
        } else if (response.statusCode == 401) {
          //writeToken(null);
        } else {}
      });
    } else if (next == null) {
      print("next = null $next");
      print("run update pull");
      enablePullUp = false;
    }
    print("last print $next");

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts(filter: null);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
