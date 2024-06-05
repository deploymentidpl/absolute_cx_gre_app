import 'package:flutter/material.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

class Style {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: ColorTheme.cScaffoldColor,
      fontFamily: FontTheme.themeFontFamily,
      primaryColorDark: ColorTheme.cBlack,
      primaryColorLight: ColorTheme.cWhite,
      useMaterial3: false,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: FontTheme.themeFontFamily,
          fontSize: 12.0,
        ),
        bodySmall: TextStyle(
          fontFamily: FontTheme.themeFontFamily,
          fontSize: 10.0,
        ),
        bodyLarge: TextStyle(
          fontFamily: FontTheme.themeFontFamily,
          fontSize: 14.0,
        ),
      ),
      hintColor: ColorTheme.cHintColor,
      colorScheme: const ColorScheme.light(
        onPrimary: ColorTheme.cBorderColor,
        onSurfaceVariant: ColorTheme.cWhite,
        onSurface: Colors.black, // default text color
        primary: ColorTheme.cPrimaryColor,
      ),
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      primaryColor: ColorTheme.cPrimaryColor,
      dialogTheme: const DialogTheme(surfaceTintColor: ColorTheme.cWhite),
      drawerTheme: const DrawerThemeData(surfaceTintColor: ColorTheme.cWhite),
      disabledColor: Colors.grey,
      cardTheme: const CardTheme(surfaceTintColor: ColorTheme.cWhite),
      popupMenuTheme:
          const PopupMenuThemeData(surfaceTintColor: ColorTheme.cWhite),
      iconTheme: const IconThemeData(color: ColorTheme.cBlack),
      checkboxTheme: const CheckboxThemeData(
          side: BorderSide(color: ColorTheme.cBlack, width: 1)),
      primaryIconTheme: const IconThemeData(color: ColorTheme.cBlack),
      datePickerTheme: DatePickerThemeData(
        surfaceTintColor: ColorTheme.cWhite,
        dividerColor: ColorTheme.cBorderColor,
        headerBackgroundColor: ColorTheme.cPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        headerHeadlineStyle:
            const TextStyle(color: ColorTheme.cWhite, fontSize: 25),
        rangePickerHeaderBackgroundColor: ColorTheme.cPrimaryColor,
        rangePickerShadowColor: ColorTheme.cPrimaryColor.withOpacity(0.3),
        rangeSelectionBackgroundColor:
            ColorTheme.cPrimaryColor.withOpacity(0.3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? const TextStyle(color: ColorTheme.cPrimaryColor)
                : const TextStyle(color: ColorTheme.cBlack)),
        labelStyle: MaterialStateTextStyle.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? const TextStyle(color: ColorTheme.cPrimaryColor)
                : const TextStyle(color: ColorTheme.cBlack)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorTheme.cPrimaryColor, width: 2)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorTheme.cBorderColor, width: 1)),
      ),
      // timePickerTheme: TimePickerThemeData(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //   dayPeriodShape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(5),
      //   ),
      //   dayPeriodBorderSide:  BorderSide(color: kBorderColor, width: 2),
      //   hourMinuteColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? kPrimaryColor : kBorderColor),
      //   hourMinuteTextColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? kWhite : kGrey),
      //   dayPeriodTextColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? kWhite : kGrey),
      //   dayPeriodColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? kPrimaryColor : kWhite),
      // ),
      dialogBackgroundColor: ColorTheme.cWhite,
    );
  }
}
