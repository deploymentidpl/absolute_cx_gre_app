import 'package:flutter/material.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';

import '../config/Helper/hex_to_color.dart';

class ColorTheme {
  static bool _isDark =
      PreferenceController.getBool(SharedPref.isDark, defaultValue: true);
  static Color _cPrimaryColor = Colors.black;
  static Color _cWhite = const Color(0xFFFFFFFF);
  static Color _cBlack = Colors.black;
  static Color _cScaffoldColor = const Color(0xFFF8F7FA);
  static Color _cBorderColor = const Color(0xFFDBDADE);
  static Color _cHintColor = const Color(0xFFA8AAAE);
  static Color _cYellowDull = const Color(0xFFB8BF0D);
  static Color _cHintTextColor = const Color(0xFF808080);
  static Color _cGrey = Colors.grey;

  /// theme colors
  static Color _cAppLoginTheme = HexColor("#6A0053");
  static Color _cAppTheme = HexColor("#7367F0");
  static Color _cAppThemeShear = HexColor("#D5D1FB");
  static Color _cThemeCard = HexColor("#2F3349");
  static Color _cThemeBg = HexColor("#25293C");

  static Color _cMosque = HexColor("#00CEC9");
  static Color _cGreen = HexColor("#4CBF7F");
  static Color _cBlue = HexColor("#49A3E8");

  static Color _cLightBlack = HexColor("#3C3D42");
  static Color _cBrown = HexColor("#995A0C");
  static Color _cDeepRed = HexColor("#A41111");

  ///bg colors
  static Color _cBgBlack = HexColor("#1C1C1C");
  static Color _cBgBlue = HexColor("#5C667B");
  static Color _cBgMosque = HexColor("#265263");
  static Color _cBgRed = HexColor("#503244");
  static Color _cBgDarkPurple = HexColor("#3A3B64");
  static Color _cBgLightGreen = HexColor("#414C57");
  static Color _cBgAppTheme = HexColor("#514D9C");
  static Color _cBgWhite20 = HexColor("#FFFFFF").withOpacity(0.2);

  ///lead
  static Color _cLeadScore = HexColor("#37AD05");
  static Color _cButtonBg = HexColor("#515463");

  ///font colors
  static Color _cFontWhite = HexColor("#CFD3EC");
  static Color _cFontLightGreen = HexColor("#00AB41");
  static Color _cFontDark = HexColor("#25293C");

  static Color _cLineColor = HexColor("#42465D");
  static Color _cDisabled = HexColor("#353A4F");

  static Color _kRed = HexColor("#FF4243");

  ///bg gradient colors
  static Color _bgPink = HexColor("#792992");
  static Color _bgPurple = HexColor("#422390");
  static Color _bgDarkPurple = HexColor("#33218F");

  /// Getters for colors
  static bool get isDark => _isDark;

  static Color get cPrimaryColor => _cPrimaryColor;

  static Color get cWhite => _cWhite;

  static Color get cBlack => _cBlack;

  static Color get cScaffoldColor => _cScaffoldColor;

  static Color get cBorderColor => _cBorderColor;

  static Color get cHintColor => _cHintColor;

  static Color get cYellowDull => _cYellowDull;

  static Color get cHintTextColor => _cHintTextColor;

  static Color get cGrey => _cGrey;

  static Color get cTransparent => Colors.transparent;

  /// theme colors
  static Color get cAppLoginTheme => _cAppLoginTheme;

  static Color get cAppTheme => _cAppTheme;

  static Color get cAppThemeShear => _cAppThemeShear;

  static Color get cThemeCard => _cThemeCard;

  static Color get cThemeBg => _cThemeBg;

  static Color get cMosque => _cMosque;

  static Color get cGreen => _cGreen;

  static Color get cBlue => _cBlue;

  static Color get cLightBlack => _cLightBlack;

  static Color get cBrown => _cBrown;

  static Color get cDeepRed => _cDeepRed;

  ///bg colors
  static Color get cBgBlack => _cBgBlack;

  static Color get cBgBlue => _cBgBlue;

  static Color get cBgMosque => _cBgMosque;

  static Color get cBgRed => _cBgRed;

  static Color get cBgDarkPurple => _cBgDarkPurple;

  static Color get cBgLightGreen => _cBgLightGreen;

  static Color get cBgAppTheme => _cBgAppTheme;

  static Color get cBgWhite20 => (_cBgWhite20).withOpacity(0.2);

  ///lead
  static Color get cLeadScore => _cLeadScore;

  static Color get cButtonBg => _cButtonBg;

  ///font colors
  static Color get cFontWhite => _cFontWhite;

  static Color get cFontLightGreen => _cFontLightGreen;

  static Color get cFontDark => _cFontDark;

  static Color get cLineColor => _cLineColor;

  static Color get cDisabled => _cDisabled;

  static Color get kRed => _kRed;

  ///bg gradient colors
  static Color get bgPink => _bgPink;

  static Color get bgPurple => _bgPurple;

  static Color get bgDarkPurple => _bgDarkPurple;

  static void changeAppTheme({required bool isDark}) {
    PreferenceController.setBool(SharedPref.isDark, isDark);
    _isDark = isDark;
    _cPrimaryColor = isDark ? Colors.black : HexColor("#FFFFFF");
    _cWhite = isDark ? const Color(0xFFFFFFFF) : Colors.black;
    _cBlack = isDark ? Colors.black : HexColor("#FFFFFF");
    _cScaffoldColor = isDark ? const Color(0xFFF8F7FA) : HexColor("#F1F1F1");

    _cBorderColor = isDark ? const Color(0xFFDBDADE) : HexColor("#FFFFFF");
    _cHintColor = isDark ? const Color(0xFFA8AAAE) : HexColor("#FFFFFF");
    _cYellowDull = const Color(0xFFB8BF0D);
    _cHintTextColor = isDark ? const Color(0xFF808080) : HexColor("#FFFFFF");
    _cGrey = Colors.grey;
    _cAppLoginTheme = isDark ? HexColor("#6A0053") : HexColor("#FFFFFF");
    _cAppTheme = HexColor("#7367F0");
    _cAppThemeShear = HexColor("#D5D1FB");
    _cThemeCard = isDark ? HexColor("#2F3349") : HexColor("#FFFFFF");

    _cThemeBg = isDark ? HexColor("#25293C") : HexColor("#F1F1F1");
    _cMosque = isDark ? HexColor("#00CEC9") : HexColor("#01918E");
    _cGreen = isDark ? HexColor("#4CBF7F") : HexColor("#44BF77");
    _cBlue = HexColor("#49A3E8");
    _cLightBlack = isDark ? HexColor("#3C3D42") : HexColor("#FFFFFF");
    _cBrown = HexColor("#995A0C");
    _cDeepRed = HexColor("#A41111");

    _cBgBlack = isDark ? HexColor("#1C1C1C") : HexColor("#DFDFDF");
    _cBgBlue = isDark ? HexColor("#5C667B") : HexColor("#FFFFFF");
    _cBgMosque = isDark ? HexColor("#265263") : HexColor("#C7FCFB");
    _cBgRed = isDark ? HexColor("#503244") : HexColor("#FFFFFF");
    _cBgDarkPurple = isDark ? HexColor("#3A3B64") : HexColor("#FFFFFF");
    _cBgLightGreen = isDark ? HexColor("#414C57") : HexColor("#D2EFDE");
    _cBgAppTheme = HexColor("#514D9C");
    _cBgWhite20 = isDark
        ? HexColor("#FFFFFF").withOpacity(0.2)
        : HexColor("#000000").withOpacity(0.2);
    _cLeadScore = HexColor("#37AD05");
    _cButtonBg = isDark ? HexColor("#515463") : HexColor("#FFFFFF");
    _cFontWhite = isDark ? HexColor("#CFD3EC") : HexColor("#565656");
    _cFontLightGreen = isDark ? HexColor("#00AB41") : HexColor("#018533");
    _cFontDark = isDark ? HexColor("#25293C") : HexColor("#FFFFFF");
    _cLineColor = isDark ? HexColor("#42465D") : HexColor("#D7D7D7");
    _cDisabled = isDark ? HexColor("#353A4F") : HexColor("#e0e0e0");
    _kRed = isDark ? HexColor("#FF4243") : HexColor("#FFFFFF");
    _bgPink = HexColor("#792992");
    _bgPurple = HexColor("#422390");
    _bgDarkPurple = HexColor("#33218F");
  }
}
