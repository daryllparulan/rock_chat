import 'package:flutter/material.dart';

class RockColors {
  static final Color colorPrimary = Colors.indigo; // primary
  static final Color colorPrimaryDark = Colors.indigo[700]!; // primaryDark
  static final Color colorLightAccent = Colors.pinkAccent; // accent
  static final Color colorDarkAccent = Colors.indigoAccent;

  static final Map<int, Color> primaryMap = {
    50: Colors.indigo,
    100: Colors.indigo[100]!,
    200: Colors.indigo[200]!,
    300: Colors.indigo[300]!,
    400: Colors.indigo[400]!,
    500: Colors.indigo[500]!,
    600: Colors.indigo[600]!,
    700: Colors.indigo[800]!,
    800: Colors.indigo[900]!,
    900: Colors.indigo[700]!,
  };
}
