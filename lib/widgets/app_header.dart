import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

import '../config/Helper/function.dart';
import '../controller/WebHeaderController/web_header_controller.dart';
import '../main.dart';
import 'custom_text_field.dart';

class AppHeader extends GetView<WebHeaderController> {
  const AppHeader({super.key, this.scaffoldState, this.showSearch = false});

  final bool showSearch;
  final GlobalKey<ScaffoldState>? scaffoldState;

  @override
  Widget build(BuildContext context) {
    return newDesign();
  }

  Widget newDesign() {
    return Obx(
      () => Container(
          width: Get.width,
          padding: controller.isSearch.value
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              color: ColorTheme.cThemeCard,
              border: Border.all(
                color: ColorTheme.cLineColor,
              )),
          child: controller.isSearch.value
              ? customTextField(
                  controller: controller.txtSearch.value,
                  maxLine: 1,
                  showLabel: false,
                  focusNode: controller.searchFocus,
                  suffixWidget: GestureDetector(
                    onTap: () {
                      controller.isSearch.value = false;
                      controller.txtSearch.value.text = "";
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.close,
                        color: ColorTheme.cWhite,
                        size: 25,
                      ),
                    ),
                  ))
              : Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        devPrint(scaffoldState != null &&
                            scaffoldState!.currentState!.hasDrawer);
                        if (scaffoldState != null &&
                            scaffoldState!.currentState!.hasDrawer) {
                        if(kSelectedProject.value.projectDescription != ""){
                          scaffoldState!.currentState!.openDrawer();
                        }
                        }
                      },
                      child: Container(
                        color: ColorTheme.cTransparent,
                        child: SvgPicture.asset(
                          AssetsString.aMenu,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                              ColorTheme.cWhite, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      AssetsString.aLogoApp,
                      width: 30,
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 30,
                      child: PopupMenuButton(
                          color: ColorTheme.cBgBlack,
                          position: PopupMenuPosition.under,
                          onSelected: (value) {
                            controller.selectedProject.value = value;
                            kSelectedProject.value = value;
                          },
                          itemBuilder: (context) {
                            return List.generate(
                                controller.projectsList.length,
                                (index) => PopupMenuItem(
                                    value: controller.projectsList[index],
                                    child: Obx(
                                      () => Text(
                                        controller.projectsList[index]
                                            .projectDescription,
                                        style: mediumTextStyle(
                                            color: controller
                                                        .projectsList[index] ==
                                                    controller
                                                        .selectedProject.value
                                                ? ColorTheme.cAppTheme
                                                : ColorTheme.cFontWhite),
                                      ),
                                    )));
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: ColorTheme.cAppTheme,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(
                                      () => Text(
                                        controller.selectedProject.value
                                            .projectDescription,
                                        style: semiBoldTextStyle(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SvgPicture.asset(
                                      AssetsString.aDropDown,
                                      height: 12,
                                      colorFilter: const ColorFilter.mode(
                                          ColorTheme.cWhite, BlendMode.srcIn),
                                    )
                                  ],
                                ),
                              ))),
                    ),
                    if (showSearch)
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.isSearch.value = true;
                              controller.searchFocus.requestFocus();
                              // Get.until((route) => Get.currentRoute == RouteNames.kDashboard);
                            },
                            child: Container(
                              color: ColorTheme.cTransparent,
                              child: SvgPicture.asset(
                                AssetsString.aSearch,
                                width: 24,
                                colorFilter: const ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                )),
    );
  }
}
