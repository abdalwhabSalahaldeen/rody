import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rody_app/controllers/control/slider_controller.dart';
import 'package:rody_app/models/auth/login_model.dart';
import 'package:rody_app/models/chat/message_model.dart';
import 'package:rody_app/models/chat/rooms_model.dart';
import 'package:rody_app/models/control/control_model.dart';
import 'package:rody_app/screens/auth/login_screen.dart';
import 'package:rody_app/screens/home/home_screen.dart';
import 'package:rody_app/screens/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:rody_app/models/control/slider_model.dart';

class MainController extends GetxController {
  final userToken = GetStorage();
  String email = "";
  String name = "";
  String username = "";
  String image = "";
  int pk = 1;
  dynamic phoneNumber;
  DateTime dateJoined = DateTime.now();
  DateTime dateModified = DateTime.now();
  var device;
  var devicePlatform;
  var isToken = false;
  Control? control;
  getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      await deviceInfo.androidInfo.then((value) {
        device = value.androidId;
        devicePlatform = "android";
      });
    } else if (Platform.isIOS) {
      await deviceInfo.iosInfo.then((value) {
        device = value.name;
        devicePlatform = "ios";
      });
    }
  }

  writeToken(token) {
    userToken.write("token", token);
    if (token == null) {
      Get.to(() => LoginScreen());
    }
    //print(token);
  }

  getControl() async {
    var url = Uri.parse('https://rodyboutique.com/api/controls/');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    //print(responseDecode[0]);
    // to get first object ass [0] to the list
    control = Control.fromJson(responseDecode['results'][0]);
    print(control!.facebook);
  }

  loginApi(email, password) async {
    var url = Uri.parse("https://rodyboutique.com/api/token/");

    await http.post(url, body: {
      "email": email,
      "password": password,
    }).then((response) {
      dynamic responseDecode = jsonDecode(response.body);
      writeToken(responseDecode['access']);
      userProfile(responseDecode['access']);
      getControl();
      if (response.statusCode == 200) {
        print(responseDecode);

        Get.off(() => HomePage());
        showToastCostum("تم تسجيل الدخول بنجاح", Toast.LENGTH_LONG);
      } else {
        showToastCostum("${responseDecode['detail']}", Toast.LENGTH_LONG);
      }
    });

    update();
  }

  userProfile(token) async {
    var url = Uri.parse('https://rodyboutique.com/rest-auth/user/');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
    } else if (response.statusCode == 401) {
      //writeToken(null);
    } else {}
    User user = User.fromJson(responseDecode);
    pk = user.pk;
    email = user.email;
    name = user.name;
    image = user.image;
    phoneNumber = user.phoneNumber;
    dateJoined = user.dateJoined;
    dateModified = user.dateModified;

    update();
  }

  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  saveTokeninApi(token) async {
    if (userToken.read("istokenForFireBase") != true) {
      var url = Uri.parse("https://rodyboutique.com/api/devices/");
      await http.post(url, body: {
        "name": "",
        "registration_id": token,
        "device_id": this.device,
        "type": this.devicePlatform
      }).then((response) {
        dynamic responseDecode = jsonDecode(response.body);

        if (response.statusCode == 201) {
          print(responseDecode);
          userToken.write("istokenForFireBase", true);
        }
      });

      update();
    }
  }

  Future natifaction() async {
    if (userToken.read("istokenForFireBase") != true) {
      // FirebaseMessaging messaging = FirebaseMessaging.instance;
      // await messaging
      //     .requestPermission(
      //       alert: true,
      //       announcement: false,
      //       badge: true,
      //       carPlay: false,
      //       criticalAlert: false,
      //       provisional: false,
      //       sound: true,
      //     )
      //     .then((settings) async {});

      // await messaging.getToken().then((token) {
      //   print("token token");
      //   print(token);
      //   saveTokeninApi(token);
      //   print("send token is done");

      //   //mainController.sentToken(resp);
      // });
    }
  }

  List sliders = [];

  getSliders(token) async {
    print("get getsliders");
    var url = Uri.parse('https://rodyboutique.com/api/sliders/?limit=30');
    await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).then((response) {
      print(response.body);
      dynamic responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

      // return reciver user to show image and name in messages screen

      for (var i = 0; i < responseDecode.length; i++) {
        sliders.add(SliderModel.fromJson(responseDecode['results'][i]));
      }
      print("sliders");

      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        //writeToken(null);
      } else {}
    });

    update();
  }

  @override
  void onInit() async {
    print("main controller");
    super.onInit();
    await getDeviceDetails();
    await natifaction();
    await getControl();
  }
}

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  var mainController = Get.put(MainController());

  onSavedEmail(value) {
    email = value;
    print(email);
    update();
  }

  onSavedPassword(value) {
    password = value;
    print(password);
    update();
  }

  loginPressed() {
    print(password);

    mainController.loginApi(email, password);
//    emailController.clear();
    //   passwordController.clear();
  }
}
