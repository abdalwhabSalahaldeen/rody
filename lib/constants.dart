import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'dart:math';
import 'package:flutter/material.dart';

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

const primaryColor = Color(0xFFe4bc01);
final switchColor = Colors.yellow;
const secondColor = Color(0xFFffffff);
const threeColor = Colors.black54;
const headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const styleLabel = TextStyle(
  fontWeight: FontWeight.w600,
  color: Color(0xFF709437),
);

const defaultDuration = Duration(milliseconds: 250);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "فضلاً أدخل عنوان البريد الألكتروني";
const String kInvalidEmailError = "فضلاً أدخل عنوان بريد إلكتروني صالح";
const String kPassNullError = "فضلا أدخل كلمة المرور";
const String kShortPassError = "كلمة المرور قصيرة";
const String kMatchPassError = "كلمة المرور غير مطابقة";
const String kNameNullError = "فضلاً أدخل اسمك";
const String kPhoneNumberNullError = "فضلا أدخل رقم الهاتف";
const String kAddressNullError = "فضلا أدخل العنوان";
const String NullError = "";
String nullError(String title) {
  String nullError = "$title";
  return nullError;
}
