import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rody_app/constants.dart';

class ControlScreen extends StatelessWidget {
  String aboutUs = "";
  Widget appbar;
  ControlScreen({Key? key, required this.aboutUs, required this.appbar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbar,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey.shade200,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: HtmlWidget(
            """  $aboutUs """,
          ),
        ),
      ),
    );
  }
}
