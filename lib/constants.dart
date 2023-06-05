import 'package:flutter/material.dart';

class Constants {
  
  static const String baseUrl = 'jsonplaceholder.typicode.com';
  static const kUserKey = "savedUsers";
  static Color mainGreen = const Color.fromRGBO(55, 93, 52, 1.0);

  static MaterialColor mainGreenSwatch = MaterialColor(0xFF375D34, {
    50: mainGreen,
    100: mainGreen,
    200: mainGreen,
    300: mainGreen,
    400: mainGreen,
    500: mainGreen,
    600: mainGreen,
    700: mainGreen,
    800: mainGreen,
    900: mainGreen,
  });
}
