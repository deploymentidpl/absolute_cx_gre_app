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
      colorScheme:   ColorScheme.light(
        onPrimary: ColorTheme.cBorderColor,
        onSurfaceVariant: ColorTheme.cWhite,
        onSurface: Colors.black, // default text color
        primary: ColorTheme.cPrimaryColor,
      ),
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      primaryColor: ColorTheme.cPrimaryColor,
      dialogTheme:   DialogTheme(surfaceTintColor: ColorTheme.cWhite),
      drawerTheme:   DrawerThemeData(surfaceTintColor: ColorTheme.cWhite),
      disabledColor: Colors.grey,
      cardTheme:   CardTheme(surfaceTintColor: ColorTheme.cWhite),
      popupMenuTheme:
            PopupMenuThemeData(surfaceTintColor: ColorTheme.cWhite),
      iconTheme:   IconThemeData(color: ColorTheme.cBlack),
      checkboxTheme:   CheckboxThemeData(
          side: BorderSide(color: ColorTheme.cBlack, width: 1)),
      primaryIconTheme:   IconThemeData(color: ColorTheme.cBlack),
      datePickerTheme: DatePickerThemeData(
        surfaceTintColor: ColorTheme.cWhite,
        dividerColor: ColorTheme.cBorderColor,
        headerBackgroundColor: ColorTheme.cPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        headerHeadlineStyle:
              TextStyle(color: ColorTheme.cWhite, fontSize: 25),
        rangePickerHeaderBackgroundColor: ColorTheme.cPrimaryColor,
        rangePickerShadowColor: ColorTheme.cPrimaryColor.withOpacity(0.3),
        rangeSelectionBackgroundColor:
            ColorTheme.cPrimaryColor.withOpacity(0.3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ?   TextStyle(color: ColorTheme.cPrimaryColor)
                :   TextStyle(color: ColorTheme.cBlack)),
        labelStyle: WidgetStateTextStyle.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ?   TextStyle(color: ColorTheme.cPrimaryColor)
                :   TextStyle(color: ColorTheme.cBlack)),
        focusedBorder:   OutlineInputBorder(
            borderSide: BorderSide(color: ColorTheme.cPrimaryColor, width: 2)),
        disabledBorder:   OutlineInputBorder(
            borderSide: BorderSide(color: ColorTheme.cBorderColor, width: 1)),
      ),
      // timePickerTheme: TimePickerThemeData(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //   dayPeriodShape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(5),
      //   ),
      //   dayPeriodBorderSide:  BorderSide(color: kBorderColor, width: 2),
      //   hourMinuteColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? kPrimaryColor : kBorderColor),
      //   hourMinuteTextColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? kWhite : kGrey),
      //   dayPeriodTextColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? kWhite : kGrey),
      //   dayPeriodColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected) ? kPrimaryColor : kWhite),
      // ),
      dialogBackgroundColor: ColorTheme.cWhite,
    );
  }
}
