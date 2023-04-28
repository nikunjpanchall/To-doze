import 'package:flutter/material.dart';

class AppTheme {
  static TextStyle titleText = const TextStyle(
    fontSize: 24,
    fontFamily: 'Montserrat-Bold',
  );

  static TextStyle subtitleText = const TextStyle(
    fontSize: 20,
    fontFamily: 'Montserrat',
  );

  static TextStyle bodyText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Montserrat',
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    minimumSize: const Size(400, 50),
    textStyle: AppTheme.subtitleText,
  );
}
