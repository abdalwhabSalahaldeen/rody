import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rody_app/models/control/slider_model.dart';

class SliderController extends GetxController {
  List sliders = [];

  getSliders() async {
    print("get getsliders");
    var url = Uri.parse('https://rodyboutique.com/api/sliders/?limit=30');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // return reciver user to show image and name in messages screen

      for (var i = 0; i < responseDecode['results'].length; i++) {
        sliders.add(SliderModel.fromJson(responseDecode['results'][i]));
      }
      print(sliders);

      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        //writeToken(null);
      } else {}
    });

    update();
  }

  @override
  void onInit() async {
    await getSliders();
  }
}
