import 'package:flutter/material.dart';

class AppTheme {
  static final AppTheme _singleton = AppTheme._internal();

  AppTheme._internal();

  static AppTheme getInstance() {
    return _singleton;
  }

  //=====================
  // App Colors
  //=====================

  static const Color blackColor = Color(0xFF000000);
  static const Color textColor = Color(0xFF323238);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color darkBlueColor = Color(0xFF0E8AD7);
  static const Color borderGreyColor = Color(0xFFE5E5E5);
  static const Color greyTextColor = Color(0xFF949C9E);
  static const Color lightBlueColor = Color(0xFFEDF8FF);

  //=========================
  // APP Text Field Borders
  //=========================

  InputDecoration textFieldDecoration({required String hintTextStyle}) {
    return InputDecoration(
      hintText: hintTextStyle,
      hintStyle: AppTheme.getInstance().textStyle16Light(color: AppTheme.greyTextColor),
      border: InputBorder.none,
    );
  }

  //=========================
  // Text Styles
  //=========================

  TextStyle textStyle12({double opacity = 1, Color? color}) {
    final bt1TextStyle =
        TextStyle(color: (color ?? textColor).withOpacity(opacity), fontSize: 12.0, fontWeight: FontWeight.w400);
    return bt1TextStyle;
  }

  TextStyle textStyle14({double opacity = 1, Color? color}) {
    final bt1TextStyle =
        TextStyle(color: (color ?? textColor).withOpacity(opacity), fontSize: 14.0, fontWeight: FontWeight.w400);
    return bt1TextStyle;
  }

  TextStyle textStyle15({double opacity = 1, Color? color}) {
    final bt1TextStyle =
        TextStyle(color: (color ?? textColor).withOpacity(opacity), fontSize: 15.0, fontWeight: FontWeight.w400);
    return bt1TextStyle;
  }

  TextStyle textStyle16({double opacity = 1, Color? color}) {
    final bt1TextStyle =
        TextStyle(color: (color ?? textColor).withOpacity(opacity), fontSize: 16.0, fontWeight: FontWeight.w500);
    return bt1TextStyle;
  }

  TextStyle textStyle16Light({double opacity = 1, Color? color}) {
    final bt1TextStyle =
        TextStyle(color: (color ?? textColor).withOpacity(opacity), fontSize: 16.0, fontWeight: FontWeight.w400);
    return bt1TextStyle;
  }

  TextStyle textStyle18({double opacity = 1, Color? color}) {
    final bt1TextStyle =
        TextStyle(color: (color ?? textColor).withOpacity(opacity), fontSize: 18.0, fontWeight: FontWeight.w500);
    return bt1TextStyle;
  }
}
