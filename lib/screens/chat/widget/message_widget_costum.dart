import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Directionality MessageWidgetCostum(
    TextDirection direction, Color chatBackground, color, message) {
  return Directionality(
    textDirection: direction,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: chatBackground, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: AutoSizeText(
            "$message",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
