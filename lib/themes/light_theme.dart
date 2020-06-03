import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xFF3569e5),
      accentColor: Color(0xFFFF6732),
      buttonColor: Color(0xFFFF6732),
    );
  }
}