import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/constants.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/screens/auth/forget_password_screen.dart';
import 'package:rody_app/screens/auth/register_screen.dart';
import 'package:rody_app/screens/widgets.dart';

class LoginScreen extends StatefulWidget {
  var loginController = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Spacer(),
            SizedBox(
                width: 100, height: 100, child: Image.asset("images/Logo.png")),
            const Center(
              child: Text(
                'تسجيل دخوول',
                style: TextStyle(fontSize: 26.0),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            GetBuilder<LoginController>(
              init: LoginController(),
              initState: (_) {},
              builder: (login) {
                return Form(
                  child: Column(
                    children: [
                      TextFormCostumField(
                          TextInputType.emailAddress,
                          login.emailController,
                          false,
                          login.onSavedEmail,
                          "الايميل",
                          "ادخل الايميل"),
                      TextFormCostumField(
                           TextInputType.visiblePassword,
                          login.passwordController,
                          true,
                          login.onSavedPassword,
                          "كلمة السر",
                          "ادخل كلمة السر"),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ForgetPasswordScreen());
                          },
                          child: AutoSizeText("نسيت كلمة السر !"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            DefaultButton("تسجيل دخول", widget.loginController.loginPressed),
            SizedBox(
              height: 15,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Get.to(() => RigsterScreen());
                },
                child: AutoSizeText("تسجيل حساب جديد"),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
