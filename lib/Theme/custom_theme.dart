import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get blueTheme {
    return ThemeData(
      primaryColor: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'SourceSansPro',
    );
  }
}
