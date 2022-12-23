import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/screens/chat/chat_screen.dart';
import 'package:rody_app/screens/control/control_screen.dart';
import 'package:rody_app/screens/home/widgets/custom_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';

Drawer homeDrawer(BuildContext context) {
  return Drawer(
    elevation: 0.0,
    child: GetBuilder<MainController>(
      init: MainController(),
      initState: (_) {},
      builder: (mainController) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade200,
            width: double.infinity, //Your desire Width
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,

              //mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 250,
                  child: DrawerHeader(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: CircleAvatar(
                            backgroundColor: secondColor.withOpacity(0.7),
                            child:
                                // ignore: unnecessary_null_comparison
                                mainController.image == null
                                    ? Image.asset('images/Logo.png')
                                    : Image.network("${mainController.image}"),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text("${mainController.name}"),
                        Text("${mainController.email}"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    //mainController.writeToken(null);

                    print(mainController.control!.description);
                    Get.to(
                      () => ControlScreen(
                        aboutUs: mainController.control!.description,
                        appbar: Text('عن المتجر'),
                      ),
                    );
                  },
                  child: customListTile("عن المتجر", threeColor, Icons.info),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => ControlScreen(
                        aboutUs: mainController.control!.termsOfUse,
                        appbar: Text("شروط الاستخدام"),
                      ),
                    );
                  },
                  child: customListTile(
                      "شروط الاستخدام", threeColor, Icons.person_off),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => ControlScreen(
                        aboutUs: mainController.control!.usagePolicy,
                        appbar: Text("سياسة الاستخدام"),
                      ),
                    );
                  },
                  child: customListTile(
                      "سياسة الاستخدام", threeColor, Icons.security),
                ),
                InkWell(
                  onTap: () {
                    mainController.writeToken(null);
                  },
                  child: customListTile("تسجيل خروج", threeColor, Icons.logout),
                ),
                const Spacer(),
                const AutoSizeText(""),
                const SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                    " تواصل معنا - رقم الهاتف : ${mainController.control!.callUs}"),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      launch(Uri(
                              scheme: 'mailto',
                              path: mainController.control!.email)
                          .toString());
                    },
                    child: AutoSizeText(
                        "الايميل : ${mainController.control!.email}")),
                const SizedBox(
                  height: 0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        mainController
                            .launchURL(mainController.control!.twitter);
                      },
                      child: const SizedBox(
                        height: 37,
                        width: 37,
                        child:
                            Icon(FontAwesome5Brands.twitter, color: threeColor),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        mainController
                            .launchURL(mainController.control!.instagram);
                      },
                      child: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(FontAwesome5Brands.instagram,
                            color: threeColor),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        mainController
                            .launchURL(mainController.control!.facebook);
                      },
                      child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(FontAwesome5Brands.facebook_f,
                            color: threeColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
