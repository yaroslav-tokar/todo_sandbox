import 'package:flutter/cupertino.dart';

class HexColor extends Color {
  HexColor(String hexValue) : super(_getColorFromHex(hexValue));

  static int _getColorFromHex(String hexColor) {
    if (hexColor.length == 7) {
      hexColor = hexColor.replaceAll('#', '');
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
