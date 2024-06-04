import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.isEmpty) {
      hexColor = "000000";
    }else
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}