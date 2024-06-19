import 'package:flutter/material.dart';

import '../config/Helper/hex_to_color.dart';

class ColorTheme {
  ColorTheme._privateConstructor();

  static final ColorTheme _instance = ColorTheme._privateConstructor();

  factory ColorTheme() {
    return _instance;
  }

//static
  static const Color cPrimaryColor = Colors.black;
  static const Color cWhite = Color(0xFFFFFFFF);
  static const Color cBlack = Colors.black;
  static const Color cScaffoldColor = Color(0xFFF8F7FA);
  static const Color cBorderColor = Color(0xFFDBDADE);
  static const Color cFocusedBorderColor = Color(0xFF6e6d6f);
  static const Color cHintColor = Color(0xFFA8AAAE);
  static const Color cBackGroundGrey = Color(0xfff1f1f2);
  static const Color cRed = Colors.red;
  static const Color cYellow = Colors.yellow;
  static const Color cYellowDull = Color(0xFFB8BF0D);
  static const Color cIconColor = cBlack;
  static const Color cTextColor = Color(0xFF808080);
  static const Color cHintTextColor = Color(0xFF808080);
  static const Color cBackgroundColor = Color(0xFFf1f1f2);
  static const Color cMicrosoftText = Color(0xFF5E5E5E);
  static const Color cNameTextBG = Color(0xFFDBDADE);
  static const Color cTableHeader = Color(0xFFeeeeef);
  static const Color cGrey = Colors.grey;
  static const Color cCherryRed = Color(0xFFEA5455);

  static const cErrorColor = Color(0xFFE55E5E);
  static const cSuccessColor = Color(0xFF32BA7C);
  static const cWarnColor = Color(0xFFE8B63C);
  static Color cTransparent = HexColor("#00FFFFFF");


  //Shimmer
  static const cShimmerBaseColor = Color(0xFFEEEEEE);
  static const cShimmerHighlightColor = Color(0xFFFAFAFA);

  /// theme colors
  static Color cAppTheme = HexColor("#7367F0");
  static Color cThemeCard = HexColor("#2F3349");
  static Color cThemeBg = HexColor("#25293C");


  static Color cPurple = HexColor("#7367F0");
  static Color cOrange = HexColor("#FFB326");
  static Color cMosque= HexColor("#00CEC9");
  static Color cGreen= HexColor("#4CBF7F");
  static Color cBlue= HexColor("#49A3E8");

  static Color cLightBlack= HexColor("#3C3D42");
  static Color cBrown= HexColor("#995A0C");
  static Color cDeepRed= HexColor("#A41111");

  ///bg colors
  static Color cBgOrange = HexColor("#575763");
  static Color cBgBlack = HexColor("#1C1C1C");
  static Color cBgBlue = HexColor("#5C667B");
  static Color cBgMosque= HexColor("#265263");
  static Color cBgRed= HexColor("#503244");
  static Color cBgLightRed= HexColor("#F1DAD5").withOpacity(0.2);
  static Color cBgDarkPurple= HexColor("#3A3B64");
  static Color cBgGreen= HexColor("#264246");
  static Color cBgLightGreen= HexColor("#414C57");
  static Color cBgDarkGreen= HexColor("#025F2C");
  static Color cBgProject= HexColor("#9B59B6");
  static Color cBgAppTheme= HexColor("#514D9C");
  static Color cBgWhite20= HexColor("#FFFFFF").withOpacity(0.2);

  ///lead
  static Color cLeadScore= HexColor("#37AD05");
  static Color cButtonBg= HexColor("#515463");

  ///font colors
  static Color cFontWhite = HexColor("#CFD3EC");
  static Color cFontLightGreen = HexColor("#00AB41");
  static Color cFontDark = HexColor("#25293C");
  static Color cFontRed = HexColor("#E7785E");


  static Color cLineColor = HexColor("#42465D");
  static Color cDisabled = HexColor("##353A4F");


  static Color appStatusbar=HexColor("#2E3349");
  static Color appCardColour=HexColor("#514C9C");
  static Color appProfileCricle=HexColor("#585B6E");
  static Color appBackground=HexColor("#252A3D");
  static Color kUnderButton=HexColor("#7367F0");
  static Color kLogoutDialog=HexColor("#25293C");
  static Color kGreen=HexColor("#00AB41");
  static Color kRed=HexColor("#FF4243");
  static Color kGreenIncoming=HexColor("#264246");
  static Color kRedMissed=HexColor("#503244");
  static Color callColor=HexColor("#F1DAD533");



}

