import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/controller/WebHeaderController/web_header_controller.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/widgets/Shimmer/box_shimmer.dart';
import 'package:greapp/widgets/app_loader.dart';

import '../../config/Helper/common_api.dart';
import '../../config/Helper/function.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/constant.dart';
import '../../config/utils/preference_controller.dart';
import '../../controller/MenuController/menu_controller.dart';
import '../../model/CheckInSummaryModel/check_in_summary_model.dart';
import '../../model/MenuModel/menu_model.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../CommonDesigns/common_designs.dart';
import '../common_bottomsheet.dart';

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
    WebHeaderController webController = Get.find<WebHeaderController>();
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
                          getFirstCharacterFromString(str:  controller.checkInModel.empFormattedName
                              .trim()),
                          style: mediumTextStyle(size: 45, color: Colors.white),
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
                            style: boldTextStyle(size: 20,color: Colors.white),
                          ),
                        ),
                        Text(
                          controller.checkInModel.roleDescription,
                          style: mediumTextStyle(size: 12,color: Colors.white),
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
                    children: [
                      Column(
                        children:
                            List.generate(controller.arrMenu.length, (index) {
                          MenuModel obj = controller.arrMenu[index];
                           return obj.alias != Get.currentRoute?Column(
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
                                  if (obj.alias != null &&
                                      obj.alias == "logout") {
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
                          ):const SizedBox();
                        }),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: ColorTheme.cTransparent,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 25,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  "Theme",
                                  style: mediumTextStyle(
                                    color: ColorTheme.cWhite,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                width: 40,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Obx(() => DayNightSwitch(
                                        value: webController.isDarkTheme.value,
                                        onChanged: (value) {
                                          webController.isDarkTheme.value =
                                              value;

                                          ColorTheme.changeAppTheme(
                                              isDark: value);
                                          Get.offAllNamed(
                                              RouteNames.kDashboard);
                                        },
                                        // size: Size.fromWidth(2),
                                      )),
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
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: FutureBuilder(
                          future: webController.getCheckInHistory(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    webController.getTime(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    convertDate(webController
                                        .checkInHistory[0].checkInTime),
                                    style: mediumTextStyle(size: 11,
                                      color: Colors.white,),
                                  )
                                ],
                              );
                            } else {
                              return BoxShimmer(
                                height: 50,
                                width: Get.width * 0.2,
                              );
                            }
                          },
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      commonDialog(
                        child: checkInPopup(),
                        onTapBottomButton: () {
                          //to close bottom sheet
                          Get.back();
                          appLoader(context);
                          checkInCheckout(isCheckIn: false).then(
                            (value) {
                              removeAppLoader(context);

                              PreferenceController.setBool(
                                  SharedPref.isUserLocked, true);
                              Get.toNamed(RouteNames.kLogin);
                            },
                          );
                        },
                        showBottomStickyButton: true,
                        bottomButtonMainText: "Check-Out",
                        mainHeadingText: "Check-In History",
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,)),
                      child: Text(
                        "Check-Out",
                        style: mediumTextStyle(size: 12,
                          color: Colors.white,),
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

  Widget checkInPopup() {
    WebHeaderController controller = Get.find<WebHeaderController>();
    controller.getCheckInHistory();
    return Container(
      padding: const EdgeInsets.all(10),
      color: isWeb ? null : ColorTheme.cThemeBg,
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => controller.checkInHistory.isNotEmpty
              ? ListView.builder(
                  itemCount: controller
                      .checkInHistory[0].checkinCheckoutHistory.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    CheckinCheckoutHistoryModel obj = controller
                        .checkInHistory[0].checkinCheckoutHistory[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Check-in",
                                      style: regularTextStyle(size: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      formatDate(obj.checkInTime, 1),
                                      style: semiBoldTextStyle(size: 16),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    obj.checkOutTime == null ||
                                            obj.checkOutTime == ""
                                        ? Row(
                                            children: [
                                              Text(
                                                "Current",
                                                style:
                                                    regularTextStyle(size: 14),
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
                                      obj.checkOutTime == null ||
                                              obj.checkOutTime == ""
                                          ? formatDate(
                                              DateTime.now().toIso8601String(),
                                              1)
                                          : formatDate(
                                              obj.checkOutTime ?? "", 1),
                                      style: semiBoldTextStyle(size: 16),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Time",
                                      style: regularTextStyle(size: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${formatDuration(Duration(seconds: obj.totalTime), 0)} Hr",
                                        style: semiBoldTextStyle(size: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: ColorTheme.cLineColor,
                        )
                      ],
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Loading",
                    style: mediumTextStyle(),
                  ),
                )),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
