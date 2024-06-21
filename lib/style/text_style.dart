import 'package:flutter/material.dart';
import 'package:greapp/style/theme_color.dart';

class FontTheme {
  FontTheme._privateConstructor();

  static final FontTheme _instance = FontTheme._privateConstructor();

  factory FontTheme() {
    return _instance;
  }

  static String themeFontFamily = "Montserrat";
  static String themeFontFamilyImpact = "Impact";

  static const FontWeight fontRegular = FontWeight.w400;
  static const FontWeight fontMedium = FontWeight.w500;
  static const FontWeight fontSemiBold = FontWeight.w600;
  static const FontWeight fontBold = FontWeight.w700;
  static const FontWeight fontBold8 = FontWeight.w700;
  static const FontWeight fontFullBold = FontWeight.w900;
}

TextStyle regularTextStyle({double size = 14, Color? color}) => TextStyle(
    fontSize: size,
    color: color??ColorTheme.cFontWhite,
    fontWeight: FontTheme.fontRegular,
    fontFamily: FontTheme.themeFontFamily);

TextStyle mediumTextStyle({double size = 14, Color? color}) => TextStyle(
    fontSize: size,
    color: color??ColorTheme.cFontWhite,
    fontWeight: FontTheme.fontMedium,
    fontFamily: FontTheme.themeFontFamily);

TextStyle semiBoldTextStyle({double size = 14, Color? color}) => TextStyle(
    fontSize: size,
    color: color??ColorTheme.cFontWhite,
    fontWeight: FontTheme.fontSemiBold,
    fontFamily: FontTheme.themeFontFamily);

TextStyle boldTextStyle({double size = 14, Color? color,double? height}) => TextStyle(
    fontSize: size,
    height:height ,
    color: color??ColorTheme.cFontWhite,
    fontWeight: FontTheme.fontBold,
    fontFamily: FontTheme.themeFontFamily);
TextStyle boldText8Style({double size = 14, Color? color,double? height}) => TextStyle(
    fontSize: size,
    height:height ,
    color: color??ColorTheme.cFontWhite,
    fontWeight: FontTheme.fontBold8,
    fontFamily: FontTheme.themeFontFamily);

TextStyle fullBoldTextStyle({double size = 14, Color? color}) => TextStyle(
    fontSize: size,
    color: color??ColorTheme.cFontWhite,
    fontWeight: FontTheme.fontFullBold,
    fontFamily: FontTheme.themeFontFamily);
