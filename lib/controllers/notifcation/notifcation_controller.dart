import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rody_app/models/notifcation/notifcation_model.dart';
import 'package:rody_app/models/products/categorys_model.dart';

import 'package:get/get.dart';

class NotifcationController extends GetxController {
  List notifcations = [];

  getNotifcations() async {
    print("get getNotifcations");
    var url = Uri.parse('https://rodyboutique.com/api/notifcations/');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((response) {
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // return reciver user to show image and name in messages screen

      for (var i = 0; i < responseDecode['results'].length; i++) {
        notifcations.add(Notifcation.fromJson(responseDecode['results'][i]));
      }
      print(notifcations);

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
    getNotifcations();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
