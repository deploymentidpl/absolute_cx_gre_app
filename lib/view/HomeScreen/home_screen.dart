import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/model/LeadModel/lead_model.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/widgets/SideBarMenuWidget/sidebar_menu_widget.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/constant.dart';
import '../../controller/HomeController/home_controller.dart';
import '../../routes/route_name.dart';
import '../../style/theme_color.dart';
import '../../widgets/BottomBar/custom_bottombar.dart';
import '../../widgets/Drawer/app_drawer.dart';
import '../../widgets/app_header.dart';

class HomeScreen extends GetView<HomeController> {
    HomeScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.cThemeBg,
      key: scaffoldKey,
      drawer: AppDrawer(
        alias: "",
        scaffoldState: scaffoldKey.currentState,
      ),
      body: SafeArea(
        child: Column(
          children: [
              AppHeader(
                scaffoldState: scaffoldKey,
                showSearch: true,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.showAssigned.value = false;
                              controller.filterList();
                            },
                            child: Obx(
                              () => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                color: controller.showAssigned.value
                                    ? ColorTheme.cThemeCard
                                    : ColorTheme.cAppTheme,
                                child: Text(
                                  "Unassigned",
                                  style: mediumTextStyle(),
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showAssigned.value = true;
                            controller.filterList();
                          },
                          child: Obx(() => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                color: controller.showAssigned.value
                                    ? ColorTheme.cAppTheme
                                    : ColorTheme.cThemeCard,
                                child: Text(
                                  "Assigned",
                                  style: mediumTextStyle(),
                                ),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(child: getLeadCards())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(RouteNames.kSVForm);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: ColorTheme.cAppTheme, shape: BoxShape.circle),
          child: const Icon(
            Icons.add,
            color: ColorTheme.cWhite,
            size: 25,
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomBar(
        currentScreen: CurrentScreen.home,
      ),
    );
  }

  Widget getLeadCards() {
    return Obx(() => ListView.builder(
          itemCount: controller.filteredLeadList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            LeadModel obj = controller.filteredLeadList[index];
            return Obx(() => controller.showAssigned.value && obj.isAssigned
                ? const SizedBox()
                : Container(
              margin: const EdgeInsets.only(bottom: 15),
                    color: ColorTheme.cThemeCard,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorTheme.cBlue, width: 1.5),
                              color: ColorTheme.cThemeCard),
                          child: Row(
                            children: [
                              Container(
                                color: ColorTheme.cBlue,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "SV\nWaitlist",
                                      textAlign: TextAlign.right,
                                      style: semiBoldTextStyle(
                                          size: 10,
                                          color: ColorTheme.cFontDark),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      obj.waitlistNumber.toString(),
                                      textAlign: TextAlign.right,
                                      style: boldTextStyle(
                                          size: 30,
                                          height: 1,
                                          color: ColorTheme.cFontDark),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorTheme.cThemeCard,
                                          width: 3),
                                      color: ColorTheme.cBgRed,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      DateTime.parse(obj.scheduleTime)
                                              .isAfter(DateTime.now())
                                          ? "Early by ${DateTime.parse(obj.scheduleTime).difference(DateTime.now()).inMinutes} Min"
                                          : "",
                                      style: semiBoldTextStyle(
                                          size: 9, color: ColorTheme.kRed),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  color: ColorTheme.cAppTheme,
                                  child: Text(
                                    "${obj.exam} | ${obj.source}",
                                    style: semiBoldTextStyle(size: 12),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorTheme.cYellowDull),
                                    child: Text(
                                      obj.age.toString(),
                                      style: boldTextStyle(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          obj.name,
                                          style: boldTextStyle(size: 16),
                                        ),
                                        Text(
                                          "${obj.status} | ${convertDateInDDMMM(obj.updated)}",
                                          style: boldTextStyle(
                                              size: 12,
                                              color: ColorTheme.cBlue),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                color: ColorTheme.cBgBlue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  "GRE",
                                  style: semiBoldTextStyle(
                                      size: 12, color: ColorTheme.cBlue),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AssetsString.aSiteVisit,
                                    height: 20,
                                    colorFilter: const ColorFilter.mode(
                                        ColorTheme.cWhite, BlendMode.srcIn),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    obj.location,
                                    style: semiBoldTextStyle(size: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        AssetsString.aBuilding,
                                        height: 20,
                                        colorFilter: const ColorFilter.mode(
                                            ColorTheme.cWhite, BlendMode.srcIn),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        obj.company,
                                        style: semiBoldTextStyle(size: 12),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: VerticalDivider(
                                      color: ColorTheme.cLineColor,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        AssetsString.aBuilding,
                                        height: 20,
                                        colorFilter: const ColorFilter.mode(
                                            ColorTheme.cWhite, BlendMode.srcIn),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        obj.company,
                                        style: semiBoldTextStyle(size: 12),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: VerticalDivider(
                                      color: ColorTheme.cLineColor,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        AssetsString.aBuilding,
                                        height: 20,
                                        colorFilter: const ColorFilter.mode(
                                            ColorTheme.cWhite, BlendMode.srcIn),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        obj.company,
                                        style: semiBoldTextStyle(size: 12),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: ColorTheme.cLineColor,
                                height: 26,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Created: ",
                                        style: semiBoldTextStyle(size: 8),
                                      ),
                                      Text(
                                        formatLocalTime(
                                          utcTime: obj.created,
                                        ),
                                        style: semiBoldTextStyle(size: 8),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    " | ",
                                    style: mediumTextStyle(size: 8),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Update: ",
                                        style: semiBoldTextStyle(size: 8),
                                      ),
                                      Text(
                                        formatLocalTime(
                                          utcTime: obj.updated,
                                        ),
                                        style: mediumTextStyle(size: 8),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            openAssignMenu(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ColorTheme.cTransparent,
                              border: Border.all(
                                color: ColorTheme.cBlue,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "ASSIGN",
                                style: semiBoldTextStyle(
                                    size: 16, color: ColorTheme.cBlue),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: ColorTheme.cLineColor,
                          padding: const EdgeInsets.only(right: 5),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                CupertinoIcons.add,
                                color: ColorTheme.cBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
          },
        ));
  }

  void openAssignMenu(BuildContext context){
    if(isWeb){
      showDialog(context:context , builder: (context) {
        return SideBarMenuWidget(
          sideBarWidget: assignOwnerContent(),
        );
      },);
    }else{
      showModalBottomSheet(context: context, builder: (context) {
        return assignOwnerContent();
      },);
    }
  }

  Widget assignOwnerContent(){
    return Column(
      children: [

      ],
    );
  }

}
