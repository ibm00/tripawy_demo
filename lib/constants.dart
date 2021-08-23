import 'package:flutter/material.dart';

enum TripState { Done, Cancelled }

class AppColors {
  static Color primaryColor = Color(0xFF795548);
  static Color lightPrimaryColor = Color(0xFFD7CCC8);
  static Color darkPrimaryColor = Color(0xFF5D4037);
  static Color accentColor = Colors.deepOrange;
  static Color primaryTextColor = Color(0xFFFF5722);
  static Color iconsColor = Color(0xFF757575);
  static Color dividerColor = Color(0xFFBDBDBD);
  static Color? backgroundColor = Colors.yellow[100];
}

class AppStyles {
  static OutlineInputBorder myFocusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.brown,
    ),
    borderRadius: BorderRadius.circular(20.0),
  );
  static TextStyle myHintSyle = TextStyle(
    fontStyle: FontStyle.italic,
    color: Colors.grey,
    fontSize: 17,
  );
}
