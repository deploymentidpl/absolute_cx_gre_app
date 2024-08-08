import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/model/LeadModel/lead_model.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/widgets/SideBarMenuWidget/sidebar_menu_widget.dart';
import 'package:greapp/widgets/app_loader.dart';
import 'package:greapp/widgets/common_bottomsheet.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/constant.dart';
import '../../controller/HomeController/home_controller.dart';
import '../../routes/route_name.dart';
import '../../style/theme_color.dart';
import '../../widgets/BottomBar/custom_bottombar.dart';
import '../../widgets/Drawer/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../../widgets/comon_type_ahead_field.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();

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
                              controller.toggleShowAssigned(newVal: false);
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
                            controller.toggleShowAssigned(newVal: true);

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
    return Obx(() => controller.filteredLeadList.isNotEmpty? ListView.builder(
          itemCount: controller.filteredLeadList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            LeadModel obj = controller.filteredLeadList[index];
            return  leadCard(obj, context);
          },
        ):Center(
      child: Text("No Data",style: mediumTextStyle(),),
    ));
  }

  Widget leadCard(LeadModel obj, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      color: ColorTheme.cThemeCard,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorTheme.cBlue, width: 1.5),
                color: ColorTheme.cThemeCard),
            child: Row(
              children: [
                Container(
                  color: ColorTheme.cBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "SV\nWaitlist",
                        textAlign: TextAlign.right,
                        style: semiBoldTextStyle(
                            size: 10, color: ColorTheme.cFontDark),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        obj.greEmpId,
                        textAlign: TextAlign.right,
                        style: boldTextStyle(
                            size: 30, height: 1, color: ColorTheme.cFontDark),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    DateTime.parse(obj.siteVisitDateTime)
                            .isAfter(DateTime.now())
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorTheme.cThemeCard, width: 3),
                              color: ColorTheme.cBgRed,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              "Early by ${DateTime.parse(obj.siteVisitDateTime).difference(DateTime.now()).inMinutes} Min",
                              style: semiBoldTextStyle(
                                  size: 9, color: ColorTheme.kRed),
                            ),
                          )
                        : const SizedBox(),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: ColorTheme.cAppTheme,
                    child: Text(
                      "${obj.leadData[0].leadId} | ${obj.leadData[0].leadRequirements[0].sourceDescription}",
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
                        "${obj.leadData[0].firstName.substring(0, 1)}${obj.leadData[0].lastName.substring(0, 1)}",
                        style: boldTextStyle(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${obj.leadData[0].firstName} ${obj.leadData[0].lastName}",
                            style: boldTextStyle(size: 16),
                          ),
                          Text(
                            "${obj.siteVisitStatus} | ${convertDateInDDMMM(obj.siteVisitDateTime)} ",
                            style: boldTextStyle(
                                size: 12, color: ColorTheme.cBlue),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                obj.leadData[0].leadCreatedFrom.trim() != ""
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          color: ColorTheme.cBgBlue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            obj.leadData[0].leadCreatedFrom,
                            style: semiBoldTextStyle(
                                size: 12, color: ColorTheme.cBlue),
                          ),
                        ),
                      )
                    : const SizedBox(),
                obj.leadData[0].projectLocationDescription != ""
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
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
                              obj.leadData[0].projectLocationDescription,
                              style: semiBoldTextStyle(size: 12),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 65,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: ColorTheme.cLineColor))),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                obj.projectName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: semiBoldTextStyle(size: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: ColorTheme.cLineColor))),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SvgPicture.asset(
                                AssetsString.aCoinRupee,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                obj.leadData[0].leadRequirements[0]
                                    .budgetDescription,
                                style: semiBoldTextStyle(size: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AssetsString.aBHK,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                obj.leadData[0].leadRequirements[0]
                                    .configurationDescription,
                                style: semiBoldTextStyle(size: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            utcTime: obj.createdAt,
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
                            utcTime: obj.updatedAt,
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

         if(!controller.showAssigned.value)
          Column(
            children: [
              GestureDetector(
                onTap: () async {
                  appLoader(context);
                  controller.getEmployeeList().then((value) {
                    removeAppLoader(context);
                    openAssignMenu(context, obj);
                  });
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
                      style: semiBoldTextStyle(size: 16, color: ColorTheme.cBlue),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          Container(
            color: ColorTheme.cLineColor,
            padding: const EdgeInsets.only(right: 5),
            child: controller.showAssigned.value?Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: ColorTheme.cGreen,
                child:  Text(
                  obj.svOwnerName,style: semiBoldTextStyle(),
                ),
              ),
            ):Align(
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
    );
  }

  void openAssignMenu(BuildContext context, LeadModel obj) {
    if (isWeb) {
      showDialog(
        context: context,
        builder: (context) {
          return SideBarMenuWidget(
            sideBarWidget: assignOwnerContent(obj),
          );
        },
      );
    } else {
      commonDialog(
          child: assignOwnerContent(obj),
        onTapBottomButton: (){
            appLoader(context);
if(formKey.currentState!.validate()){

  controller.assignedLead(obj: obj,  ).whenComplete(() {
    removeAppLoader(context);
    Get.back();
    controller.getLeadsList();
  });
}
        },
        showBottomStickyButton: true,
        bottomButtonMainText:"Assign",

        mainHeadingText: "Lead Assign",);
      // showModalBottomSheet(
      //   constraints: BoxConstraints(minHeight:Get.height*0.5,maxHeight:   Get.height * 0.934),
      //   barrierColor: ColorTheme.cBlack.withOpacity(0.7),
      //   isDismissible: true,
      //   enableDrag: true,
      //   context: Get.context!,
      //   isScrollControlled: true,
      //   backgroundColor:  ColorTheme.cBgBlack,
      //
      //   builder: (context) {
      //     return assignOwnerContent(obj);
      //   },
      // );
    }
  }

  Widget assignOwnerContent(LeadModel obj) {
    return Container(
      color: ColorTheme.cThemeBg,
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customTypeAheadField(
                hintStyle: TextStyle(color: Colors.grey[600]),
                labelText: 'Select*',
                textController: controller.txtEmployeeId,
                dataList: controller.arrEmployee,
                suggestion: (e) => "${e.employeeId} ${e.empFormattedName}",
                onSelected: (t) async {
                  controller.txtEmployeeId.text =
                      "${t.employeeId} ${t.empFormattedName}";
                  controller.selectedEmployee.value = t;
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please select employee id";
                  } else {
                    return null;
                  }
                },
                fillColor: ColorTheme.cThemeCard),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
