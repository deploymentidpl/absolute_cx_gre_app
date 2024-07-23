import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/routes/route_name.dart';

import '../../config/Helper/function.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/preference_controller.dart';
import '../../controller/MenuController/menu_controller.dart';
import '../../model/MenuModel/menu_model.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../CommonDesigns/common_designs.dart';

class AppDrawer extends GetView<MenusController> {
  const AppDrawer({
    super.key,
    this.scaffoldState,
    required this.alias,
  });

  final String alias;
  final ScaffoldState? scaffoldState;

  @override
  Widget build(BuildContext context) {
    controller.selectCurrentScreen(alias);
    return Drawer(
      child: Container(
        color: ColorTheme.cBgAppTheme,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      color: ColorTheme.cGreen,
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text(
                          controller.checkInModel.empFormattedName
                              .trim()
                              .substring(0, 1),
                          style: mediumTextStyle(size: 45),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Text(
                            controller.checkInModel.empFormattedName,
                            style: boldTextStyle(size: 20),
                          ),
                        ),
                        Text(
                          controller.checkInModel.occupationDescription,
                          style: mediumTextStyle(size: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: ColorTheme.cThemeBg,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: List.generate(controller.arrMenu.length, (index) {
                      MenuModel obj = controller.arrMenu[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.arrMenu.map((e) {
                                e.isCurrent =
                                    e.alias == obj.alias ? true : false;
                              }).toSet();
                              if (scaffoldState != null &&
                                  scaffoldState!.hasDrawer &&
                                  scaffoldState!.isDrawerOpen) {
                                scaffoldState!.closeDrawer();
                              }
                              if (obj.alias != null && obj.alias == "logout") {
                                logOutView(obj);
                              } else {
                                navigateOnAlias(obj);
                              }
                            },
                            child: Container(
                              color: ColorTheme.cTransparent,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  obj.menuIcon != null
                                      ? SvgPicture.asset(
                                          obj.menuIcon ?? "",
                                          width: 25,
                                          colorFilter: ColorFilter.mode(
                                              obj.isCurrent != null &&
                                                      obj.isCurrent!
                                                  ? ColorTheme.cAppTheme
                                                  : ColorTheme.cWhite,
                                              BlendMode.srcIn),
                                        )
                                      : const SizedBox(
                                          width: 25,
                                        ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      obj.menu ?? "",
                                      style: mediumTextStyle(
                                        color: obj.isCurrent != null &&
                                                obj.isCurrent!
                                            ? ColorTheme.cAppTheme
                                            : ColorTheme.cWhite,
                                      ),
                                    ),
                                  ),
                                  if (obj.count != null &&
                                      obj.count!.value != 0)
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: obj.isCurrent != null &&
                                                  obj.isCurrent!
                                              ? ColorTheme.cWhite
                                              : ColorTheme.cAppTheme),
                                      child: Text(
                                        controller.arrMenu[index].count
                                            .toString(),
                                        style: semiBoldTextStyle(
                                            size: 9,
                                            color: obj.isCurrent != null &&
                                                    obj.isCurrent!
                                                ? ColorTheme.cAppTheme
                                                : ColorTheme.cWhite),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: ColorTheme.cLineColor,
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                controller.getTime(),
                                style: const TextStyle(
                                    color: ColorTheme.cWhite,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            convertDate(
                                controller.checkInModel.checkInTime ?? ""),
                            style: mediumTextStyle(size: 11),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      PreferenceController.setBool(
                          SharedPref.isUserLocked, true);
                      Get.toNamed(RouteNames.kLogin);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorTheme.cWhite)),
                      child: Text(
                        "Check-Out",
                        style: mediumTextStyle(size: 12),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
