import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rody_app/constants.dart';

Widget customListTile(text, color, icon) {
  return Container(
    decoration: BoxDecoration(
      color: primaryColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(0),
    ),
    margin: EdgeInsets.only(top: 5, bottom: 5),
    child: ListTile(
      leading: Icon(icon, color: color),
      title: AutoSizeText(
        "$text",
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ),
  );
}
