import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../config/Helper/function.dart';
import '../config/utils/constant.dart';
import '../style/theme_color.dart';

Widget responsiveRowColumn({required Widget widget1, required Widget widget2}) {
  return ResponsiveRowColumn(
    columnMainAxisSize: MainAxisSize.min,
    columnMainAxisAlignment: MainAxisAlignment.start,
    rowCrossAxisAlignment: CrossAxisAlignment.start,
    layout:
        isMobile ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
    rowSpacing: 20,
    children: [
      ResponsiveRowColumnItem(rowFlex: 1, columnFlex: 1, child: widget1),
      ResponsiveRowColumnItem(rowFlex: 1, columnFlex: 1, child: widget2)
    ],
  );
}

Future<void> selectDate(TextEditingController textEditingController,
    [DateFormat? dateFormat, DateTime? firstDate, DateTime? lastDate]) async {
  DateTime? datePicker = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: firstDate ?? DateTime.now(),
    lastDate: lastDate ?? DateTime(DateTime.now().year + 10),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: ColorTheme.cFontWhite,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: ColorTheme.cAppTheme,
          ),
          colorScheme: ColorScheme.dark(
            primary: ColorTheme.cAppTheme,
            onPrimary: ColorTheme.cFontWhite,
            surface: ColorTheme.cThemeCard,
            onSurface: ColorTheme.cFontWhite,
          ),
        ),
        child: child!,
      );
    },
  );
  if (datePicker != null) {
    if (dateFormat != null) {
      textEditingController.text = dateFormat.format(datePicker);
    } else {
      textEditingController.text = dateDecode(datePicker);
    }
  }
}
