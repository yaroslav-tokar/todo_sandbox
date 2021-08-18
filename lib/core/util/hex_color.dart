import 'package:flutter/cupertino.dart';

class HexColor extends Color {
  HexColor(String hexValue) : super(_getColorFromHex(hexValue));

  static int _getColorFromHex(String hexColor) {
    String? hexResult;

    if (hexColor.length == 7) hexResult = 'FF${hexColor.replaceAll('#', '')}';

    return int.parse(hexResult ?? hexColor, radix: 16);
  }
}
