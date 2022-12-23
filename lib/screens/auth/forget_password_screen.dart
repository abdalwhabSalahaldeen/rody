import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rody_app/controllers/auth/login_controller.dart';
import 'package:rody_app/screens/widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  var loginController = Get.put(LoginController());

  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("images/Logo.png")),
              const Center(
                child: Text(
                  'استعادة الحساب',
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
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text('ارسال كود استعادة الحساب'),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      //   side: BorderSide(
                      //    color: Colors.white,
                      //)
                    ),
                  ),
                ),
                onPressed: () {
                  widget.loginController.loginPressed();
                },
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
