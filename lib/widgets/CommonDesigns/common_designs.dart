import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../config/Helper/function.dart";
import "../../style/assets_string.dart";
import "../../style/text_style.dart";
import "../../style/theme_color.dart";
import "../common_bottomsheet.dart";

Widget appBgWithBuilding({required double height}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.topLeft,
            colors: [
          ColorTheme.bgPink,
          ColorTheme.bgPurple,
          ColorTheme.bgDarkPurple
        ])),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              AssetsString.aBuildings,
              height: height / 2,
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> exitAppDialog() async {
  return commonDialog(
      showBottomStickyButton: false,
      mainHeadingText: "Exit",
      mainColor: ColorTheme.cThemeBg,
      onTapBottomButton: () {},
      isDismissible: false,
      message: '',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Text("Are you sure you want to exit App?",
              style: mediumTextStyle(size: 16)),
        ),
        GestureDetector(
          onTap: () {
            exitApp();
          },
          child: Container(
              color: ColorTheme.cPurple,
              alignment: Alignment.center,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              child: Text("YES",
                  style:
                      semiBoldTextStyle(size: 16, color: ColorTheme.cWhite))),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
              color: ColorTheme.cBgWhite20,
              alignment: Alignment.center,
              width: Get.width,
              padding: const EdgeInsets.all(10),
              child: Text("NO",
                  style:
                      semiBoldTextStyle(size: 16, color: ColorTheme.cWhite))),
        ),
      ]));
}
