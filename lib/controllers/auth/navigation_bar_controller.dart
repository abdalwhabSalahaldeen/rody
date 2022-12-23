import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/screens/chat/rooms_screen.dart';
import 'package:rody_app/screens/home/home_body_screen.dart';
import 'package:rody_app/screens/natifation/notifation_screen.dart';
import 'package:rody_app/screens/products/my_cart_screen.dart';
import 'package:rody_app/screens/products/order_screen.dart';

class NavigationBarController extends GetxController {
  int selectedIndex = 0;
  List<Widget> widgetList = [
    HomeBodyScreen(),
    // MessageScreen(),
    Natifaction(),
    OrderScreen(),
    MyCartScreen()
  ];
  changeselectedIndex(index) {
    selectedIndex = index;
    update();
  }
}
