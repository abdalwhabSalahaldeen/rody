import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/screens/auth/login_screen.dart';
import 'package:splashscreen/splashscreen.dart';

import 'screens/home/home_screen.dart';

class SplashScreenScreen extends StatelessWidget {
  var token;

  SplashScreenScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        loadingText: Text("مرحبا بك"),
        image: Image.asset('images/Logo.png'),
        navigateAfterSeconds: token != null ? HomePage() : LoginScreen(),
        // title: new Text(
        //   'Welcome In Rody ',
        //   style: TextStyle(
        //     color: threeColor,
        //     fontSize: 15,
        //   ),
        // ),
        onClick: () {
          Get.to(
            () => token != null ? HomePage() : LoginScreen(),
          );
        },
        backgroundColor: secondColor,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        useLoader: false,
        loaderColor: threeColor);
  }
}
