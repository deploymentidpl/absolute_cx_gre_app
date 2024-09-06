import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/utils/constant.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

import '../controller/SVFormController/sv_form_controller.dart';
import '../controller/WebTabBarController/web_tab_bar_controller.dart';

class WebTabBar extends GetView<WebTabBarController> {
  const WebTabBar({
    super.key,
    required this.currentScreen,
    this.onNewSVTap,
  });

  final CurrentScreen currentScreen;
  final void Function()? onNewSVTap;

  void init() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.currentScreen.value = currentScreen;
      controller.navigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return isWeb
        ? Container(
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          color: controller.currentScreen.value ==
                                  CurrentScreen.dashboard
                              ? ColorTheme.cAppTheme
                              : ColorTheme.cThemeCard,
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetsString.aHome,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    controller.currentScreen.value ==
                                            CurrentScreen.dashboard
                                        ? ColorTheme.isDark
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cFontDark
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
                                        ? ColorTheme.isDark
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cFontDark
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          color: controller.currentScreen.value ==
                                  CurrentScreen.siteVisit
                              ? ColorTheme.cAppTheme
                              : ColorTheme.cThemeCard,
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetsString.aSiteVisit,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    controller.currentScreen.value ==
                                            CurrentScreen.siteVisit
                                        ? ColorTheme.isDark
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cFontDark
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
                                        ? ColorTheme.isDark
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cFontDark
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
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
                                        ? ColorTheme.isDark
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cFontDark
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
                                        ? ColorTheme.isDark
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cFontDark
                                        : ColorTheme.cFontWhite),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: onNewSVTap ??
                          () {
                            Get.delete<SiteVisitFormController>();
                            Get.put(SiteVisitFormController());
                            Get.toNamed(RouteNames.kSVForm);
                          },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          color: ColorTheme.cAppTheme,
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Add a New SV",
                                style: mediumTextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
