import 'package:flutter/material.dart';

class AppTheme {
  static TextStyle titleText = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans-Medium',
  );
  static TextStyle bodyText = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    fontFamily: 'OpenSans-Light',
  );
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}