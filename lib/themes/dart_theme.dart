import 'package:flutter/material.dart';
import 'package:app/utils/color_util.dart';

class DarkTheme {
  static ThemeData get() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorUtil.hexColor(0x222222),
      accentColor: Color(0xFFFF6732),
      buttonColor: Color(0xFFFF6732),
    );
  }
}