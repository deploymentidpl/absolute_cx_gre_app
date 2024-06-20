import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/utils/constant.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

import '../controller/WebTabBarController/web_tab_bar_controller.dart';

class WebTabBar extends GetView<WebTabBarController> {
  const WebTabBar({
    super.key,
    required this.currentScreen,
  });

  final CurrentScreen currentScreen;

  void init(){
   SchedulerBinding.instance.addPostFrameCallback((timeStamp) { controller.currentScreen.value = currentScreen;
   controller.navigation();});
  }
  @override
  Widget build(BuildContext context) {init();
    return isWeb?Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: ColorTheme.cThemeCard,
          border: Border.all(
            color: ColorTheme.cLineColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            GestureDetector(
              onTap: () {
                controller.currentScreen.value = CurrentScreen.dashboard;
                controller.navigation();
              },
              child: Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color:
                      controller.currentScreen.value == CurrentScreen.dashboard
                          ? ColorTheme.cAppTheme
                          : ColorTheme.cThemeCard,
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetsString.aHome,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            controller.currentScreen.value ==
                                    CurrentScreen.dashboard
                                ? ColorTheme.cWhite
                                : ColorTheme.cFontWhite,
                            BlendMode.srcIn,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Dashboard",
                        style: mediumTextStyle(
                            color: controller.currentScreen.value ==
                                    CurrentScreen.dashboard
                                ? ColorTheme.cWhite
                                : ColorTheme.cFontWhite),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.currentScreen.value = CurrentScreen.siteVisit;
                controller.navigation();
              },
              child: Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color:
                      controller.currentScreen.value == CurrentScreen.siteVisit
                          ? ColorTheme.cAppTheme
                          : ColorTheme.cThemeCard,
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetsString.aSiteVisit,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            controller.currentScreen.value ==
                                    CurrentScreen.siteVisit
                                ? ColorTheme.cWhite
                                : ColorTheme.cFontWhite,
                            BlendMode.srcIn,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Site Visit Form",
                        style: mediumTextStyle(
                            color: controller.currentScreen.value ==
                                    CurrentScreen.siteVisit
                                ? ColorTheme.cWhite
                                : ColorTheme.cFontWhite),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.currentScreen.value = CurrentScreen.knowledgeBase;
                controller.navigation();
              },
              child: Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color: controller.currentScreen.value ==
                          CurrentScreen.knowledgeBase
                      ? ColorTheme.cAppTheme
                      : ColorTheme.cThemeCard,
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetsString.aFileDetail,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            controller.currentScreen.value ==
                                    CurrentScreen.knowledgeBase
                                ? ColorTheme.cWhite
                                : ColorTheme.cFontWhite,
                            BlendMode.srcIn,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Knowledgebase",
                        style: mediumTextStyle(
                            color: controller.currentScreen.value ==
                                    CurrentScreen.knowledgeBase
                                ? ColorTheme.cWhite
                                : ColorTheme.cFontWhite),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
          Row(
            children: [
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  color: ColorTheme.cTransparent,
                  child: SvgPicture.asset(
                    AssetsString.aBuilding,
                    height: 20,
                    colorFilter:
                        const ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: ColorTheme.cAppTheme,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.add,
                      size: 20,
                      color: ColorTheme.cFontWhite,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Add a New SV",
                      style: mediumTextStyle(color: ColorTheme.cFontWhite),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ):const SizedBox();
  }


}
