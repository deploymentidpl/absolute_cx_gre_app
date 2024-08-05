import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/main.dart';
import 'package:greapp/model/CheckInModel/check_in_model.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

import '../config/Helper/function.dart';
import '../config/utils/constant.dart';
import '../controller/WebHeaderController/web_header_controller.dart';
import '../model/ProjectListModel/nearby_projct_list_model.dart';
import 'custom_buttons.dart';
import 'custom_text_field.dart';

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
                      controller.txtSearchProject.clear();
                      controller.searchList.value = [];

                      return [
                        PopupMenuItem(
                            padding: const EdgeInsets.all(5),
                            enabled: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: customTextField(
                                    hintText: "Search",
                                    showLabel: false,
                                    controller: controller.txtSearchProject,
                                    onChange: (value) {
                                      controller.searchList.value =
                                          controller.projectsList.where((e) {
                                        return e.projectDescription
                                            .toLowerCase()
                                            .contains(controller
                                                .txtSearchProject.text
                                                .toLowerCase());
                                      }).toList();
                                      controller.searchList.refresh();
                                    },
                                    suffixWidget: GestureDetector(
                                        onTap: () {
                                          controller.txtSearchProject.clear();
                                          controller.searchList.clear();
                                          controller.searchList.refresh();
                                        },
                                        child: const Icon(Icons.clear)),
                                  ),
                                ),
                                SizedBox(
                                  height: 200,
                                  width: 300,
                                  child: Obx(
                                    () => controller.searchList.isEmpty &&
                                            controller.txtSearchProject.text
                                                .isNotEmpty
                                        ? Container(
                                            alignment:
                                                AlignmentDirectional.topCenter,
                                            child: Text(
                                              "No data Found",
                                              style: semiBoldTextStyle(),
                                            ))
                                        : Scrollbar(
                                            controller:
                                                controller.scrollController,
                                            thumbVisibility: true,
                                            child: ListView.builder(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              controller:
                                                  controller.scrollController,
                                              itemCount: controller
                                                      .searchList.isNotEmpty
                                                  ? controller.searchList.length
                                                  : controller
                                                      .projectsList.length,
                                              itemBuilder: (context, i) {
                                                NearbyProjectModel obj =
                                                    controller.searchList
                                                            .isNotEmpty
                                                        ? controller
                                                            .searchList[i]
                                                        : controller
                                                            .projectsList[i];
                                                return Obx(
                                                  () => RadioListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    visualDensity:
                                                        const VisualDensity(
                                                            horizontal: -4.0,
                                                            vertical: -4),
                                                    title: Text(
                                                      obj.projectDescription,
                                                      style: mediumTextStyle(),
                                                    ),
                                                    value: obj,
                                                    groupValue:
                                                        kSelectedProject.value,
                                                    onChanged: (value) {
                                                      kSelectedProject.value =
                                                          value!;
                                                      kSelectedProject
                                                          .refresh();
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButtons.borderWidgetButton(
                                          radius: 0,
                                          borderWidth: 1,
                                          width: 120,
                                          borderColor: ColorTheme.cFontWhite,
                                          bgColor: ColorTheme.cBlack,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          onTap: () => Get.back(),
                                          child: Text(
                                            "Cancel",
                                            style: semiBoldTextStyle(),
                                          )),
                                      CustomButtons.appThemeButton(
                                        width: 120,
                                        height: 33,
                                        onTap: () {
                                          Get.back();
                                        },
                                        text: "OK",
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ];
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: ColorTheme.cBgLightGreen,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Obx(() => Text(
                                controller.projectsList.length.toString(),
                                style: semiBoldTextStyle(
                                    size: 16,
                                    color: ColorTheme.cFontLightGreen),
                              )),
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
                child: Container(
                  color: ColorTheme.cGreen,
                  height: 32,
                  width: 32,
                  child: Center(
                    child: Text(
                      CheckInModel.fromJson(jsonDecode(
                              PreferenceController.getString(
                                  SharedPref.employeeDetails)))
                          .empFormattedName
                          .trim()
                          .substring(0, 1),
                      style: mediumTextStyle(size: 16),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget profilePopup() {
    CheckInModel obj = CheckInModel.fromJson(
        jsonDecode(PreferenceController.getString(SharedPref.employeeDetails)));
    return Column(
      children: [
        Row(
          children: [
            Container(
              color: ColorTheme.cGreen,
              height: 35,
              width: 35,
              child: Center(
                child: Text(
                  obj.empFormattedName.trim().substring(0, 1),
                  style: mediumTextStyle(size: 16),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  obj.empFormattedName,
                  style: semiBoldTextStyle(color: ColorTheme.cAppTheme),
                ),
                Text(
              obj.roleDescription,
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
                    formatDate(obj.checkInTime??"", 0),
                    style: boldText8Style(size: 18),
                  ),
                  Text(
                    formatDate(obj.checkInTime??"", 2),
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
      padding: const EdgeInsets.all(10),
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
                                        formatDate(controller
                                            .checkInHistory[index].checkInTime, 1),
                                        style: semiBoldTextStyle(size: 16),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      controller.checkInHistory[index]
                                                  .checkOutTime ==
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
                                            .checkOutTime ==
                                            null || controller.checkInHistory[index]
                                                    .checkOutTime ==
                                                ""
                                            ? formatDate(
                                                DateTime.now()
                                                    .toIso8601String(),
                                                1)
                                            :
                                        formatDate(controller
                                            .checkInHistory[index].checkOutTime??"", 1),
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
                                        formatDuration( DateTime.parse(controller.checkInHistory[index].checkInTime).difference(DateTime.now()), 0),
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
          const SizedBox(
            height: 10,
          ),
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
