import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/controllers/auth/navigation_bar_controller.dart';
import 'package:rody_app/screens/home/widgets/homeFFnavigationbar.dart';
import 'package:rody_app/screens/home/widgets/homeappbar.dart';
import 'package:rody_app/screens/home/widgets/homedrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: HomeAppBar(scaffoldKey),
      endDrawer: homeDrawer(context),
      bottomNavigationBar: GetBuilder<NavigationBarController>(
        init: NavigationBarController(),
        initState: (_) {},
        builder: (homeController) {
          return HomeFFNavigationBar(homeController);
        },
      ),
      body: GetBuilder<NavigationBarController>(
        init: NavigationBarController(),
        initState: (_) {},
        builder: (homeController) {
          return Container(
              child: homeController.widgetList[homeController.selectedIndex]);
        },
      ),
    );
  }
}
