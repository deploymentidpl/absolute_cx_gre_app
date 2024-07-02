import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

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
    return Obx(()=>Container(
      width: Get.width,
      padding:controller.isSearch.value?EdgeInsets.zero: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
            onTap: (){
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
              print(scaffoldState != null &&
                  scaffoldState!.currentState!.hasDrawer);
              if (scaffoldState != null &&
                  scaffoldState!.currentState!.hasDrawer) {
                scaffoldState!.currentState!.openDrawer();
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
                              controller
                                  .projectsList[index].projectDescription,
                              style: mediumTextStyle(
                                  color: controller.projectsList[index] ==
                                      controller.selectedProject.value
                                      ? ColorTheme.cAppTheme
                                      : ColorTheme.cFontWhite),
                            ),
                          )));
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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

  Widget oldDesign() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          color: ColorTheme.cThemeCard,
          border: Border.all(
            color: ColorTheme.cLineColor,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AssetsString.aLogoWhite,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 30,
                child: PopupMenuButton(
                    color: ColorTheme.cBgBlack,
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      controller.selectedProject.value = value;
                    },
                    itemBuilder: (context) {
                      return List.generate(
                          controller.projectsList.length,
                          (index) => PopupMenuItem(
                              value: controller.projectsList[index],
                              child: Obx(
                                () => Text(
                                  controller
                                      .projectsList[index].projectDescription,
                                  style: mediumTextStyle(
                                      color: controller.projectsList[index] ==
                                              controller.selectedProject.value
                                          ? ColorTheme.cAppTheme
                                          : ColorTheme.cFontWhite),
                                ),
                              )));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: ColorTheme.cBgLightGreen,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            controller.projectsList.length.toString(),
                            style: semiBoldTextStyle(
                                size: 16, color: ColorTheme.cFontLightGreen),
                          ),
                        ),
                        Container(
                            color: ColorTheme.cLineColor.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  controller
                                      .selectedProject.value.projectDescription,
                                  style: mediumTextStyle(),
                                ),
                              ),
                            )),
                      ],
                    )),
              ),
            ],
          ),
          Row(
            children: [
              // PopupMenuButton(
              //     color: ColorTheme.cBgBlack,
              //     position: PopupMenuPosition.under,
              //     onSelected: (value) {
              //       controller.selectedAvailability.value = value;
              //       Get.back();
              //     },
              //     itemBuilder: (context) {
              //       return List.generate(
              //           controller.availableList.length,
              //           (index) => PopupMenuItem(
              //               value: controller.availableList[index],
              //               child: Obx(
              //                 () => Text(
              //                   controller.availableList[index],
              //                   style: mediumTextStyle(
              //                       color: controller.availableList[index] ==
              //                               controller
              //                                   .selectedAvailability.value
              //                           ? ColorTheme.cAppTheme
              //                           : ColorTheme.cFontWhite),
              //                 ),
              //               )));
              //     },
              //     child: Container(
              //       color: Colors.transparent,
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Obx(
              //             () => Text(
              //               controller.selectedAvailability.value,
              //               style: semiBoldTextStyle(),
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 20,
              //           ),
              //           const Icon(
              //             CupertinoIcons.chevron_down,
              //             color: ColorTheme.cWhite,
              //             size: 20,
              //           ),
              //         ],
              //       ),
              //     )),
              // const SizedBox(
              //   width: 30,
              // ),
              // Obx(
              //   () => Stack(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(top: 5, right: 5),
              //         child: SvgPicture.asset(
              //           AssetsString.aBell,
              //           height: 25,
              //           colorFilter: const ColorFilter.mode(
              //               ColorTheme.cWhite, BlendMode.srcIn),
              //         ),
              //       ),
              //       if (controller.notificationCount.value != 0)
              //         Positioned(
              //             right: 0,
              //             top: 0,
              //             child: Container(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 5, vertical: 2),
              //               decoration: BoxDecoration(
              //                   color: ColorTheme.cFontLightGreen,
              //                   borderRadius: BorderRadius.circular(50)),
              //               child: Text(
              //                 controller.notificationCount.value.toString(),
              //                 style: semiBoldTextStyle(size: 8),
              //               ),
              //             ))
              //     ],
              //   ),
              // ),
              Container(
                color: ColorTheme.cAppTheme,
                height: 32,
                width: 32,
                child: Center(
                  child: Icon(
                    CupertinoIcons.add,
                    size: 20,
                    color: ColorTheme.cFontWhite,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Image.asset(
                AssetsString.aDummyProfile,
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              )
            ],
          )
        ],
      ),
    );
  }
}
