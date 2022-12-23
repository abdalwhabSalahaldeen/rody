import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rody_app/models/products/images_model.dart';

class ImagesController extends GetxController {
  List images = [];

  getImages(product) async {
    print(product);
    print("get getImages");

    var url =
        Uri.parse('https://rodyboutique.com/api/Images/?product=${product}');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // return reciver user to show image and name in messages screen

      for (var i = 0; i < responseDecode['results'].length; i++) {
        images.add(Images.fromJson(responseDecode['results'][i]));
      }
      print(images);

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
  }
}
