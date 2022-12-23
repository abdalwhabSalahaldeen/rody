import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rody_app/constants.dart';

FFNavigationBar HomeFFNavigationBar(homeController) {
  return FFNavigationBar(
    theme: FFNavigationBarTheme(
      barBackgroundColor: Colors.white,
      selectedItemBorderColor: secondColor,
      selectedItemBackgroundColor: primaryColor,
      selectedItemIconColor: Colors.white,
      selectedItemLabelColor: Colors.black,
    ),
    selectedIndex: homeController.selectedIndex,
    onSelectTab: (index) {
      homeController.changeselectedIndex(index);
    },
    items: [
      FFNavigationBarItem(
        iconData: Icons.home,
        label: 'الرئيسيه',
      ),
      // FFNavigationBarItem(
      //   iconData: Icons.message,
      //   label: 'المحادثات',
      // ),
      FFNavigationBarItem(
        iconData: Icons.notifications,
        label: 'آشعارات',
      ),
      FFNavigationBarItem(
        iconData: Icons.receipt_long_rounded,
        label: 'الطلبات',
      ),
      FFNavigationBarItem(
        iconData: Icons.shopping_bag_outlined,
        label: 'السلة',
      ),
    ],
  );
}
