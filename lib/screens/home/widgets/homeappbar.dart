import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

AppBar HomeAppBar(scaffoldKey) {
  return AppBar(
    title: Row(
      children: [
        SizedBox(width: 55, height: 60, child: Image.asset("images/Logo.png")),
        SizedBox(width: 15),
        const AutoSizeText("متجر رودي",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
  );
}
