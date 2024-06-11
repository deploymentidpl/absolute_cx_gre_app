import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../config/Helper/function.dart';
import '../config/utils/constant.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';

Widget showCountCircle(
    {required int count,
    Color? textColor,
    Color? bgColor,
    double fontSize = 9,
    double size = 25}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: bgColor ?? Colors.red,
      borderRadius: BorderRadius.circular(size),
    ),
    child: Center(
      child: Text(
        count.toString(),
        style: TextStyle(
            fontSize: fontSize, color: textColor ?? ColorTheme.cFontWhite),
      ),
    ),
  );
}

Widget showCount(
    {required int count,
    Color? textColor,
    Color? bgColor,
    double fontSize = 9,
    double height = 25,
    double width = 0}) {
  if (width == 0) {
    if (count < 10) {
      width = height;
    } else if (count < 100) {
      width = height + 6;
    } else if (count < 1000) {
      width = height + 12;
    } else {
      width = height + 18;
    }
  }
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: bgColor ?? Colors.red,
      borderRadius: BorderRadius.circular(height),
    ),
    child: Center(
      child: Text(
        count.toString(),
        style: semiBoldTextStyle(
            size: fontSize, color: textColor ?? ColorTheme.cFontWhite),
      ),
    ),
  );
}

String dateFormate(d) {
  var inputFormat = DateFormat('dd MMMM, yyyy');
  var inputDate = inputFormat.parse(d);
  var outputFormat = DateFormat('yyyy-MM-dd');
  return outputFormat.format(inputDate);
}

Widget commonTooltip({required String msg, required Widget child}) {
  return Tooltip(
    margin: const EdgeInsets.all(10),
    message: msg,
    triggerMode: TooltipTriggerMode.tap,
    decoration: BoxDecoration(
        color: ColorTheme.cAppTheme, borderRadius: BorderRadius.circular(5)),
    textStyle: semiBoldTextStyle(
      color: ColorTheme.cWhite,
    ),
    child: child,
  );
}

selectDate(TextEditingController textEditingController,
    [DateFormat? dateFormat, bool isBirthDate = false]) async {
  DateTime? datePicker = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: isBirthDate ? DateTime(1900, 01, 01) : DateTime.now(),
    lastDate: isBirthDate ? DateTime.now() : DateTime(DateTime.now().year + 10),
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

Future<(String, String)> dateTimeRangePicker(
    {required TextEditingController textEditingController,
    DateFormat? dateFormat}) async {
  String startDate = "";
  String endDate = "";
  DateTimeRange? picked = await showDateRangePicker(
    context: Get.context!,
    firstDate: DateTime(DateTime.now().year - 50),
    lastDate: DateTime.now(),
    initialDateRange: DateTimeRange(
      start: startDate.isNotEmpty
          ? (dateFormat ?? DateFormat('yyyy-MM-dd')).parse(startDate)
          : DateTime.now(),
      end: endDate.isNotEmpty
          ? (dateFormat ?? DateFormat('yyyy-MM-dd')).parse(endDate)
          : DateTime.now(),
    ),
    builder: (context, Widget? child) => Theme(
      data: Theme.of(context).copyWith(
          dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                iconTheme:
                    IconThemeData(color: Theme.of(context).primaryColorLight),
              ),
          datePickerTheme: Theme.of(context).datePickerTheme.copyWith(
                backgroundColor: ColorTheme.cAppTheme,
                dividerColor: ColorTheme.cAppTheme,
              ),
          colorScheme: Theme.of(context).colorScheme.copyWith(
              onPrimary: Theme.of(context).primaryColorLight,
              primary: Theme.of(context).colorScheme.primary)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 800,
            ),
            child: child,
          ),
        ],
      ),
    ),
  );
  if (picked != null) {
    startDate = (dateFormat ?? DateFormat('yyyy-MM-dd')).format(picked.start);
    endDate = (dateFormat ?? DateFormat('yyyy-MM-dd')).format(picked.end);

    textEditingController.text = "$startDate to $endDate";
  }
  return (startDate, endDate);
}

Widget responsiveRowColumn({required Widget widget1, required Widget widget2}) {
  return ResponsiveRowColumn(
    columnMainAxisSize: MainAxisSize.min,
    rowCrossAxisAlignment: CrossAxisAlignment.start,
    layout: isMobile //ResponsiveWrapper.of(context).isLargerThan(TABLET)
        ? ResponsiveRowColumnType.COLUMN
        : ResponsiveRowColumnType.ROW,
    rowSpacing: 20,
    children: [
      ResponsiveRowColumnItem(rowFlex: 1, columnFlex: 1, child: widget1),
      ResponsiveRowColumnItem(rowFlex: 1, columnFlex: 1, child: widget2)
    ],
  );
}

Widget iconTitle({iconName, title, containerColor, txtColor}) {
  return Container(
    height: 20,
    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
    color: containerColor ?? ColorTheme.cWhite,
    child: IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconName,
              height: 15,
              colorFilter: ColorFilter.mode(
                  txtColor ?? ColorTheme.cGrey, BlendMode.srcIn)),
          VerticalDivider(
            width: 13,
            thickness: 1,
            color: txtColor ?? ColorTheme.cWhite,
          ),
          Flexible(
            child: Text(
              title,
              style: semiBoldTextStyle(
                size: 12,
                color: txtColor ?? ColorTheme.cWhite,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
