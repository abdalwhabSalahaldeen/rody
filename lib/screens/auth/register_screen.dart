import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/controllers/auth/register_controller.dart';
import 'package:rody_app/screens/auth/login_screen.dart';
import 'package:rody_app/screens/widgets.dart';

class RigsterScreen extends StatefulWidget {
  var registerController = Get.put(RegisterController());

  RigsterScreen({Key? key}) : super(key: key);

  @override
  _RigsterScreenState createState() => _RigsterScreenState();
}

class _RigsterScreenState extends State<RigsterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      'تسجيل حساب جديد',
                      style: TextStyle(fontSize: 26.0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  GetBuilder<RegisterController>(
                    init: RegisterController(),
                    initState: (_) {},
                    builder: (register) {
                      return Form(
                        child: Column(
                          children: [
                            TextFormCostumField(
                                TextInputType.text,
                                register.nameController,
                                false,
                                register.onSavedName,
                                "الاسم",
                                "ادخل الاسم"),
                            TextFormCostumField(
                                TextInputType.emailAddress,
                                register.emailController,
                                false,
                                register.onSavedEmail,
                                "الايميل",
                                "ادخل الايميل"),
                            TextFormCostumField(
                                TextInputType.phone,
                                register.phone_numberController,
                                false,
                                register.onSavedPhoneNumber,
                                "رقم الهاتف",
                                "ادخل رقم الهاتف"),
                            TextFormCostumField(
                                TextInputType.visiblePassword,
                                register.passwordController,
                                true,
                                register.onSavedPassword,
                                "كلمة السر",
                                "ادخل كلمة السر"),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DefaultButton("تسجيل حساب جديد",
                        widget.registerController.registerUser),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text("آو"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => LoginScreen());
                      },
                      child: AutoSizeText("تسجيل دخول"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
