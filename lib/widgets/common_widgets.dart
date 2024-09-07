import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../config/Helper/function.dart';
import '../config/utils/constant.dart';
import '../model/LeadModel/lead_model.dart';
import '../style/assets_string.dart';
import '../style/text_style.dart';
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

Widget leadCard(LeadModel obj, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    color: ColorTheme.cThemeCard,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: ColorTheme.cBlue, width: 1.5),
              color: ColorTheme.cThemeCard),
          child: Row(
            children: [
              Container(
                color: ColorTheme.cBlue,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "SV\nWaitlist",
                      textAlign: TextAlign.right,
                      style: semiBoldTextStyle(
                          size: 10, color: ColorTheme.cFontDark),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      obj.scanVisitLocationData.isNotEmpty
                          ? obj.scanVisitLocationData[0].svWaitListNumber
                          .toString()
                          : "",
                      textAlign: TextAlign.right,
                      style: boldTextStyle(
                          size: 30, height: 1, color: ColorTheme.cFontDark),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(),
                      DateTime.parse(obj.siteVisitDateTime)
                          .isAfter(DateTime.now())
                          ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorTheme.cThemeCard, width: 3),
                          color: ColorTheme.cBgRed,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          "Early by ${DateTime.parse(obj.siteVisitDateTime).difference(DateTime.now()).inMinutes} Min",
                          style: semiBoldTextStyle(
                              size: 9, color: ColorTheme.kRed),
                        ),
                      )
                          : const SizedBox(),
                    ],
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: ColorTheme.cAppTheme,
                  child: Text(
                    "${obj.leadData.isNotEmpty?obj.leadData[0].leadId:""} | ${obj.leadData.isNotEmpty && obj.leadData[0].leadRequirements.isNotEmpty?obj.leadData[0].leadRequirements[0].sourceDescription:""}",
                    style: semiBoldTextStyle(size: 12, color: Colors.white),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorTheme.cYellowDull),
                    child: obj.leadData.isNotEmpty
                        ? Text(
                      "${getFirstCharacterFromString(str: obj.leadData[0].firstName)}${getFirstCharacterFromString(str: obj.leadData[0].lastName)}"
                          .toUpperCase(),
                      style: boldTextStyle(color: Colors.white),
                    )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${obj.leadData[0].firstName} ${obj.leadData[0].lastName}",
                          style: boldTextStyle(size: 16),
                        ),
                        Text(
                          "${obj.siteVisitStatus} | ${convertDateInDDMMM(obj.siteVisitDateTime)} ",
                          style: boldTextStyle(
                              size: 12, color: ColorTheme.cBlue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              obj.leadData[0].leadCreatedFrom.trim() != ""
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  color: ColorTheme.cBgBlue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: Text(
                    obj.leadData[0].leadCreatedFrom,
                    style: semiBoldTextStyle(
                        size: 12, color: ColorTheme.cBlue),
                  ),
                ),
              )
                  : const SizedBox(),
              obj.leadData[0].projectLocationDescription != ""
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AssetsString.aSiteVisit,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          ColorTheme.cWhite, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      obj.leadData[0].projectLocationDescription,
                      style: semiBoldTextStyle(size: 12),
                    )
                  ],
                ),
              )
                  : const SizedBox(),
              SizedBox(
                height: 65,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: ColorTheme.cLineColor))),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsString.aBuilding,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              obj.projectName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: semiBoldTextStyle(size: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: ColorTheme.cLineColor))),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SvgPicture.asset(
                              AssetsString.aCoinRupee,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            obj.leadData.isNotEmpty &&
                                obj.leadData[0].leadRequirements
                                    .isNotEmpty
                                ? Text(
                              obj.leadData[0].leadRequirements[0]
                                  .budgetDescription,
                              style: semiBoldTextStyle(size: 12),
                            )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsString.aBHK,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            obj.leadData.isNotEmpty &&
                                obj.leadData[0].leadRequirements
                                    .isNotEmpty
                                ? Text(
                              obj.leadData[0].leadRequirements[0]
                                  .configurationDescription,
                              style: semiBoldTextStyle(size: 12),
                            )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: ColorTheme.cLineColor,
                height: 26,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Created: ",
                        style: boldTextStyle(size: 10),
                      ),
                      Text(
                        formatLocalTime(
                          utcTime: obj.createdAt,
                        ),
                        style: semiBoldTextStyle(size: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Update: ",
                        style: boldTextStyle(size: 10),
                      ),
                      Text(
                        formatLocalTime(
                          utcTime: obj.updatedAt,
                        ),
                        style: mediumTextStyle(size: 10),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
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
