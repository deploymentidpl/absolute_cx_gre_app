import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../../config/utils/constant.dart';
import '../../controller/SVFormController/sv_form_controller.dart';
import '../../style/assets_string.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';

class SVToken extends GetView<SiteVisitFormController> {
  const SVToken({super.key});

  @override
  Widget build(BuildContext context) {
    controller.update();

    return isWeb ? success() : mobileView();
  }

  Widget success() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          width: 480,
          color: ColorTheme.cThemeCard,
          padding: const EdgeInsets.all(70),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsString.aToken),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Token",
                      style: TextStyle(
                          color: ColorTheme.cFontWhite,
                          fontSize: 18,
                          fontWeight: FontTheme.fontSemiBold),
                    ),
                    Obx(() => Text(
                          "#${controller.token.value}",
                          style: TextStyle(
                              color: ColorTheme.cFontWhite,
                              fontSize: 50,
                              fontWeight: FontTheme.fontSemiBold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Container(
          height: 250,
          width: 480,
          color: ColorTheme.cThemeCard,
          padding: const EdgeInsets.all(70),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsString.aWaitList),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Waitlist Number",
                      style: TextStyle(
                          color: ColorTheme.cFontWhite,
                          fontSize: 18,
                          fontWeight: FontTheme.fontSemiBold),
                    ),
                    Obx(() => Text(
                          "#${controller.waitListNumber.value}",
                          style: TextStyle(
                              color: ColorTheme.cFontWhite,
                              fontSize: 50,
                              fontWeight: FontTheme.fontSemiBold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 250,
            color: ColorTheme.cThemeCard,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsString.aToken),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Token",
                      style: TextStyle(
                          color: ColorTheme.cFontWhite,
                          fontSize: 18,
                          fontWeight: FontTheme.fontSemiBold),
                    ),
                    Obx(() => Text(
                          "#${controller.token.value}",
                          style: TextStyle(
                              color: ColorTheme.cFontWhite,
                              fontSize: 50,
                              fontWeight: FontTheme.fontSemiBold),
                        )),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
            color: ColorTheme.cThemeCard,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsString.aWaitList),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Waitlist Number",
                      style: TextStyle(
                          color: ColorTheme.cFontWhite,
                          fontSize: 18,
                          fontWeight: FontTheme.fontSemiBold),
                    ),
                    Obx(() => Text(
                          "#${controller.waitListNumber.value}",
                          style: TextStyle(
                              color: ColorTheme.cFontWhite,
                              fontSize: 50,
                              fontWeight: FontTheme.fontSemiBold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
