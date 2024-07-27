import 'package:flutter/material.dart';

abstract class CustomColors {
  static const statusBar = Color.fromRGBO(2, 69, 163, 1);

  static const primary = MaterialColor(0xFFff0000, {
    0: Color.fromRGBO(255, 0, 0, .0),
    50: Color.fromRGBO(255, 0, 0, .05),
    100: Color.fromRGBO(255, 0, 0, .2),
    200: Color.fromRGBO(255, 0, 0, .3),
    300: Color.fromRGBO(255, 0, 0, .4),
    400: Color.fromRGBO(255, 0, 0, .5),
    500: Color.fromRGBO(255, 0, 0, .6),
    600: Color.fromRGBO(255, 0, 0, .7),
    700: Color.fromRGBO(255, 0, 0, .8),
    800: Color.fromRGBO(255, 0, 0, .9),
    900: Color.fromRGBO(255, 0, 0, 1),
  });
}
