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

class AppTabBar extends StatefulWidget {
  const AppTabBar({
    super.key,
    required this.currentScreen,
  });

  final CurrentScreen currentScreen;

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  final WebTabBarController controller = Get.find<WebTabBarController>();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.currentScreen.value = widget.currentScreen;
      controller.navigation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: kAppBarHeight,
      decoration: BoxDecoration(
          color: ColorTheme.cThemeCard,
          border: Border.all(
            color: ColorTheme.cLineColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    controller.currentScreen.value = CurrentScreen.dashboard;
                    controller.navigation();
                  },
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: controller.currentScreen.value ==
                              CurrentScreen.dashboard
                          ? ColorTheme.cAppTheme
                          : ColorTheme.cThemeCard,
                      child: Center(
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
                ),
                GestureDetector(
                  onTap: () {
                    controller.currentScreen.value = CurrentScreen.siteVisit;
                    controller.navigation();
                  },
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: controller.currentScreen.value ==
                              CurrentScreen.siteVisit
                          ? ColorTheme.cAppTheme
                          : ColorTheme.cThemeCard,
                      child: Center(
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
                ),
                GestureDetector(
                  onTap: () {
                    controller.currentScreen.value =
                        CurrentScreen.knowledgeBase;
                    controller.navigation();
                  },
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      color: controller.currentScreen.value ==
                              CurrentScreen.knowledgeBase
                          ? ColorTheme.cAppTheme
                          : ColorTheme.cThemeCard,
                      child: Center(
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
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Image.asset(
              AssetsString.aDummyNews,
              height: kAppBarHeight,
            ),
          )
        ],
      ),
    );
  }
}
