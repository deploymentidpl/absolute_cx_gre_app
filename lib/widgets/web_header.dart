import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

import '../config/Helper/function.dart';
import '../config/utils/constant.dart';
import '../controller/WebHeaderController/web_header_controller.dart';

class WebHeader extends GetView<WebHeaderController> {
  const WebHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                width: 130,
              ),
              const SizedBox(
                width: 20,
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
                                  controller.projectsList[index].projectName,
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
                                  controller.selectedProject.value.projectName,
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
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: SvgPicture.asset(
                  AssetsString.aNotes,
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              PopupMenuButton(
                color: ColorTheme.cBgBlack,
                padding: const EdgeInsets.all(25),
                position: PopupMenuPosition.under,
                surfaceTintColor: ColorTheme.cTransparent,
                itemBuilder: (context) =>
                    [PopupMenuItem(enabled: false, child: profilePopup())],
                child: Image.asset(
                  AssetsString.aDummyProfile,
                  height: 32,
                  width: 32,
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget profilePopup() {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              AssetsString.aDummyProfile,
              height: 35,
              width: 35,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Charlie Adams",
                  style: semiBoldTextStyle(color: ColorTheme.cAppTheme),
                ),
                Text(
                  "Pre-Sales Executive",
                  style: mediumTextStyle(size: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          color: ColorTheme.cLightBlack,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatDate(controller.time, 0),
                    style: boldText8Style(size: 18),
                  ),
                  Text(
                    formatDate(controller.time, 2),
                    style: mediumTextStyle(size: 11),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              PopupMenuButton(
                color: ColorTheme.cBgBlack,
                padding: const EdgeInsets.all(25),
                position: PopupMenuPosition.over,
                surfaceTintColor: ColorTheme.cTransparent,
                onOpened: controller.getCheckInHistory,
                constraints: isWeb ? const BoxConstraints(maxWidth: 800) : null,
                itemBuilder: (context) =>
                    [PopupMenuItem(enabled: false, child: checkInPopup())],
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "Check-Out",
                      style: mediumTextStyle(size: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            SvgPicture.asset(
              AssetsString.aUser,
              height: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "My Profile",
              style: mediumTextStyle(size: 16),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SvgPicture.asset(
              AssetsString.aSettings,
              height: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Settings",
              style: mediumTextStyle(size: 16),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SvgPicture.asset(
              AssetsString.aLogout,
              height: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Logout",
              style: mediumTextStyle(size: 16),
            )
          ],
        ),
      ],
    );
  }

  Widget checkInPopup() {
    return Container(
      padding: const EdgeInsets.all( 10),
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Check-in Summary",
            style: mediumTextStyle(size: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    controller.checkInHistory.length,
                    (index) => Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Check-in",
                                        style: regularTextStyle(size: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        controller
                                            .checkInHistory[index].checkIn,
                                        style: semiBoldTextStyle(size: 16),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      controller.checkInHistory[index]
                                                  .checkOut ==
                                              ""
                                          ? Row(
                                              children: [
                                                Text(
                                                  "Current",
                                                  style: regularTextStyle(
                                                      size: 14),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: ColorTheme.cGreen,
                                                  size: 10,
                                                )
                                              ],
                                            )
                                          : Text(
                                              "Check-out",
                                              style: regularTextStyle(size: 14),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        controller.checkInHistory[index]
                                                    .checkOut ==
                                                ""
                                            ? formatDate(
                                                DateTime.now()
                                                    .toIso8601String(),
                                                1)
                                            : controller
                                                .checkInHistory[index].checkOut,
                                        style: semiBoldTextStyle(size: 16),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Time",
                                        style: regularTextStyle(size: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        controller.checkInHistory[index].time,
                                        style: semiBoldTextStyle(size: 16),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: ColorTheme.cLineColor,
                            )
                          ],
                        )),
              )),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
                "Check-Out",
                style: semiBoldTextStyle(size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
