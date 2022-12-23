import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'screens/auth/login_screen.dart';
import 'splashscreen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  //print(firestore);
  // await firestore.collection("col").doc("conter").update({'cont': 20});

  final MainController mainController =
      Get.put(MainController(), permanent: true);

// runApp(
//     DevicePreview(
//       enabled: true,
//       child: MyApp(
//         userToken: mainController.userToken,
//       ),
//     ),
//   );

  runApp(MyApp(
    userToken: mainController.userToken,
  ));
}

class MyApp extends StatelessWidget {
  GetStorage userToken;
  final MainController mainController =
      Get.put(MainController(), permanent: true);

  MyApp({Key? key, required this.userToken}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //print(userToken.read('token'));
    dynamic user = mainController.userProfile(userToken.read('token'));
    return GetMaterialApp(
      title: 'Rody Market',
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "El Messiri",
        backgroundColor: Colors.grey.shade200,
        scaffoldBackgroundColor: Colors.grey.shade100,
        textTheme: GoogleFonts.tajawalTextTheme(),
        primarySwatch: generateMaterialColor(Palette.primary),
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(
          toolbarHeight: 55.0,
          actionsIconTheme: IconThemeData(size: 22, color: primaryColor),

          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          // color: secondColor,
          centerTitle: false,
          backgroundColor: secondColor,
          elevation: 0.0,
        ),
      ),
      home: SplashScreenScreen(token: userToken.read('token')),
    );
  }
}

class Palette {
  static const Color primary = primaryColor;
}
