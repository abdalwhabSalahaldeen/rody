import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';

import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/screens/widgets.dart';

class RegisterController extends GetxController {
  String? name;
  String? password;
  String? password2;
  String? email;
  String? phone_number;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phone_numberController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  MainController mainController = Get.put(MainController());
  onSavedEmail(value) {
    email = value;
    print(value);
    update();
  }

  onSavedPassword(value) {
    password = value;
    password2 = value;
    print(value);
    update();
  }

  onSavedName(value) {
    name = value;
    print(value);
    update();
  }

  onSavedPhoneNumber(value) {
    phone_number = value;
    print(value);
    update();
  }

  registerUser() async {
    var url = Uri.parse("https://rodyboutique.com/api/register/");
    print(name);
    print(password);
    print(password2);
    print(email);
    print(phone_number);
    await http.post(url, body: {
      "name": name!,
      "password": password!,
      "password2": password!,
      "email": email!,
      "phone_number": phone_number!
    }).then((response) {
      dynamic responseDecode = (json.decode(response.body));
      print(response.statusCode);
      print(responseDecode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        mainController.loginApi(email, password);
        print("done");
        print(responseDecode);
      } else {
        showToastCostum("${responseDecode}", Toast.LENGTH_LONG);
      }
    });

    update();
  }
}
