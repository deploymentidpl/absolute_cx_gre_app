import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/controller/DashboardController/dashboard_controller.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:greapp/view/Dashboard/DashboardWidgets/get_sumary_count.dart';
import 'package:greapp/view/Dashboard/DashboardWidgets/get_waiting_sv_chart.dart';
import 'package:greapp/widgets/Shimmer/box_shimmer.dart';
import 'package:greapp/widgets/web_tabbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/Helper/event_bus.dart';
import '../../config/Helper/function.dart';
import '../../config/utils/connectivity_service.dart';
import '../../config/utils/constant.dart';
import '../../model/EventModel/project_event_model.dart';
import '../../widgets/BottomBar/custom_bottombar.dart';
import '../../widgets/CommonDesigns/common_designs.dart';
import '../../widgets/Drawer/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../../widgets/web_header.dart';
import 'DashboardWidgets/get_overall_sv_chart.dart';
import 'DashboardWidgets/get_source_wise_sv_count.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController controller = Get.find<DashboardController>();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    controller.streamSubscription = eventBus.on<ProjectEvent>().listen((event) {
      if (event.isProjectAvailable) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            controller.apiCalls().whenComplete(
              () {
                setState(() {});
              },
            );
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ConnectivityService>().initializeConnectivity();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        setAppType(sizingInformation);
        controller.sizingInformation = sizingInformation.obs;

        isMobile = sizingInformation.isMobile;
        isTablet = sizingInformation.isTablet;
        isWeb = sizingInformation.isDesktop || sizingInformation.isExtraLarge;
        controller.setSizing();

        return isWeb ? webDesign() : mobileDesign();
      },
    );
  }

  Widget mobileDesign() {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        exitAppDialog();
      },
      child: Scaffold(
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
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.apiCalls();
                    setState(() {});
                  },
                  backgroundColor: ColorTheme.cBgBlack,
                  color: ColorTheme.cAppTheme,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(isWeb ? 20 : 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GetSumaryCount(),
                          SizedBox(
                            height: controller.space20.value,
                          ),
                          const GetOverallSvChart(),
                          SizedBox(
                            height: controller.space20.value,
                          ),
                          const GetWaitingSvChart(),
                          SizedBox(
                            height: controller.space20.value,
                          ),
                          const GetSourceWiseSVCount(),
                          SizedBox(
                            height: controller.space20.value,
                          ),
                        ],
                      ),
                    ),
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
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        bottomNavigationBar: const AppBottomBar(
          currentScreen: CurrentScreen.dashboard,
        ),
      ),
    );
  }

  Widget webDesign() {
    return Scaffold(
      backgroundColor: ColorTheme.cThemeBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WebHeader(),
          const WebTabBar(
            currentScreen: CurrentScreen.dashboard,
          ),
          Expanded(
            child: Scrollbar(
              controller: controller.scrollController,
              thickness: 10,
              trackVisibility: true,
              interactive: true,
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Padding(
                  padding: EdgeInsets.all(controller.space20.value),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GetSumaryCount(),
                      SizedBox(
                        height: controller.space20.value,
                      ),
                      const GetOverallSvChart(),
                      SizedBox(
                        height: controller.space20.value,
                      ),
                      const GetWaitingSvChart(),
                      SizedBox(
                        height: controller.space20.value,
                      ),
                      const GetSourceWiseSVCount(),
                      SizedBox(
                        height: controller.space20.value,
                      ),
                      getSVWaitList(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getSVWaitList() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding: EdgeInsets.all(controller.space20.value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SV Waitlist",
                style: semiBoldTextStyle(size: 16),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.homeController
                          .toggleShowAssigned(newVal: false);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Obx(() => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: controller.space20.value),
                            color: controller.homeController.showAssigned.value
                                ? ColorTheme.cThemeBg
                                : ColorTheme.cAppTheme,
                            child: Text(
                              "Unassigned",
                              style: mediumTextStyle(
                                  color: controller
                                          .homeController.showAssigned.value
                                      ? null
                                      : Colors.white),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.homeController
                          .toggleShowAssigned(newVal: true);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Obx(() => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: controller.space20.value),
                            color: controller.homeController.showAssigned.value
                                ? ColorTheme.cAppTheme
                                : ColorTheme.cThemeBg,
                            child: Text(
                              "Assigned",
                              style: mediumTextStyle(
                                  color: controller
                                          .homeController.showAssigned.value
                                      ? Colors.white
                                      : null),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 260,
                    height: 40,
                    child: TextFormField(
                      cursorColor: ColorTheme.cWhite,
                      controller: controller.leadSearchTxt,
                      style: mediumTextStyle(size: 12),
                      textAlignVertical: TextAlignVertical.center,
                      expands: true,
                      maxLines: null,
                      onChanged: (value) {
                        if (value != "") {
                          controller.homeController
                              .getLeadsList(searchText: value);
                        }

                        controller.leadSearchText.value = value;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorTheme.cWhite.withOpacity(0.2),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (controller.leadSearchText.value != "") {
                                controller.leadSearchText.value = "";
                                controller.leadSearchTxt.clear();

                                controller.homeController.getLeadsList();
                              }
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 30,
                                width: 30,
                                color: Colors.transparent,
                                child: Obx(() => SvgPicture.asset(
                                      controller.leadSearchText.value != ""
                                          ? AssetsString.aClose
                                          : AssetsString.aSearch,
                                      height: controller.space20.value,
                                      colorFilter: ColorFilter.mode(
                                          ColorTheme.cWhite, BlendMode.srcIn),
                                    )),
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: controller.space20.value,
          ),
          Obx(() => controller.homeController.isLeadLoading.value
              ? BoxShimmer(
                  height: 200,
                  width: Get.width,
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 1800,
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.5),
                        1: FlexColumnWidth(0.5),
                        5: FlexColumnWidth(2.0),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children:
                          controller.homeController.filteredLeadList.isNotEmpty
                              ? List.generate(
                                  controller.homeController.filteredLeadList
                                          .length +
                                      1, (index) {
                                  int newIndex = index - 1;
                                  return newIndex < 0
                                      ? getTableHeader()
                                      : getTableContent(newIndex);
                                })
                              : [],
                    ),
                  ),
                ))
        ],
      ),
    );
  }

  TableRow getTableHeader() {
    return TableRow(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ColorTheme.cLineColor))),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Order".toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Token".toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              (controller.homeController.showAssigned.value
                      ? "Owner"
                      : "Assign")
                  .toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Details".toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Status".toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Project".toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "Source".toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              "sourcing Manager".toUpperCase(),
              style: semiBoldTextStyle(),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                "Date".toUpperCase(),
                style: semiBoldTextStyle(),
              ),
            ),
          ),
        ]);
  }

  TableRow getTableContent(int newIndex) {
    return TableRow(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ColorTheme.cLineColor))),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: controller.homeController.filteredLeadList[newIndex]
                    .scanVisitLocationData.isNotEmpty
                ? Text(
                    controller.homeController.filteredLeadList[newIndex]
                        .scanVisitLocationData[0].svWaitListNumber
                        .toString(),
                    style: mediumTextStyle(),
                  )
                : const SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: controller.homeController.filteredLeadList[newIndex]
                    .scanVisitLocationData.isNotEmpty
                ? Text(
                    controller.homeController.filteredLeadList[newIndex]
                        .scanVisitLocationData[0].currentVisitToken
                        .toString(),
                    style: mediumTextStyle(),
                  )
                : const SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: controller.homeController.showAssigned.value
                    ? Text(
                        controller.homeController.filteredLeadList[newIndex]
                            .svOwnerName,
                        style: semiBoldTextStyle(
                          size: 14,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.homeController.openAssignMenu(
                              context,
                              controller
                                  .homeController.filteredLeadList[newIndex],
                              formKey);
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Obx(() => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: controller.space20.value),
                                color: ColorTheme.cAppTheme,
                                child: Text(
                                  "Assign",
                                  style: mediumTextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: getRandomColor()),
                      child: Center(
                        child: Text(
                          controller.homeController.filteredLeadList[newIndex]
                              .leadData[0].firstName
                              .substring(0, 1)
                              .toUpperCase(),
                          style: mediumTextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.homeController.filteredLeadList[newIndex].leadData[0].firstName} ${controller.homeController.filteredLeadList[newIndex].leadData[0].lastName}",
                          style: boldTextStyle(size: 16),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          color: ColorTheme.cAppTheme,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            "#${controller.homeController.filteredLeadList[newIndex].leadData[0].leadId}",
                            style: semiBoldTextStyle(
                                size: 12, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              controller
                  .homeController.filteredLeadList[newIndex].siteVisitStatus,
              style: semiBoldTextStyle(size: 12, color: ColorTheme.cMosque),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetsString.aSiteVisit,
                      height: controller.space20.value,
                      colorFilter:
                          ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.homeController.filteredLeadList[newIndex]
                          .leadData[0].projectLocationDescription,
                      style: mediumTextStyle(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AssetsString.aBuilding,
                          height: controller.space20.value,
                          colorFilter: ColorFilter.mode(
                              ColorTheme.cWhite, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          controller.homeController.filteredLeadList[newIndex]
                              .leadData[0].projectName,
                          style: mediumTextStyle(),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AssetsString.aBHK,
                          height: controller.space20.value,
                          colorFilter: ColorFilter.mode(
                              ColorTheme.cWhite, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          controller
                              .homeController
                              .filteredLeadList[newIndex]
                              .leadData[0]
                              .leadRequirements[0]
                              .configurationDescription,
                          style: mediumTextStyle(),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AssetsString.aCoinRupee,
                          height: controller.space20.value,
                          colorFilter: ColorFilter.mode(
                              ColorTheme.cWhite, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          controller
                              .homeController
                              .filteredLeadList[newIndex]
                              .leadData[0]
                              .leadRequirements[0]
                              .budgetDescription,
                          style: mediumTextStyle(),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Obx(() => Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                controller.homeController.filteredLeadList[newIndex]
                    .leadSourceDescription,
                style: semiBoldTextStyle(size: 12, color: ColorTheme.cMosque),
              ))),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: controller.homeController.filteredLeadList[newIndex]
                    .sourcingManagerList.isNotEmpty
                ? Column(
                    children: List.generate(
                        controller.homeController.filteredLeadList[newIndex]
                            .sourcingManagerList.length,
                        (managerIndex) => Container(
                              color: ColorTheme.cThemeBg,
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: ColorTheme.cBgBlue,
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                      child: Text(
                                        controller
                                            .homeController
                                            .filteredLeadList[newIndex]
                                            .sourcingManagerList[managerIndex]
                                            .ownerEmpName
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: boldTextStyle(size: 14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller
                                          .homeController
                                          .filteredLeadList[newIndex]
                                          .sourcingManagerList[managerIndex]
                                          .ownerEmpName,
                                      style: mediumTextStyle(),
                                    ),
                                  )
                                ],
                              ),
                            )),
                  )
                : const SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Column(
              children: [
                Center(
                  child: Container(
                    color: ColorTheme.cWhite.withOpacity(0.2),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      convertDate(controller
                          .homeController.filteredLeadList[newIndex].createdAt),
                      style: mediumTextStyle(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    color: ColorTheme.cWhite.withOpacity(0.2),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      convertDate(controller
                          .homeController.filteredLeadList[newIndex].updatedAt),
                      style: mediumTextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
