import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/controller/DashboardController/dashboard_controller.dart';
import 'package:greapp/model/SiteVisitSourceWiseCountModel/sitevisit_sourecwise_count_model.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:greapp/widgets/Shimmer/box_shimmer.dart';
import 'package:greapp/widgets/web_tabbar.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/connectivity_service.dart';
import '../../config/utils/constant.dart';
import '../../model/ChartDataModel/chart_data_model.dart';
import '../../widgets/RotatingIconButton/rotating_icon_button.dart';
import '../../widgets/BottomBar/custom_bottombar.dart';
import '../../widgets/CommonDesigns/common_designs.dart';
import '../../widgets/Drawer/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common_bottomsheet.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/web_header.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

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

        if(isWeb){
          controller.space20.value = 20;
          controller.space25.value = 25;
        }else{
          controller.space20.value = 10;
          controller.space25.value = 20;

        }
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
                  onRefresh: controller.apiCalls,
                  backgroundColor: ColorTheme.cBgBlack,
                  color: ColorTheme.cAppTheme,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:   EdgeInsets.all(isWeb?20:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          webDashBoard(),
                            SizedBox(
                            height: controller.space20.value,
                          ),
                          getOverallSVChart(),
                            SizedBox(
                            height: controller.space20.value,
                          ),
                          getWaitingSVChart(),
                            SizedBox(
                            height: controller.space20.value,
                          ),
                          getSourceWiseCount(),
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
            child:   Icon(
              Icons.add,
              color: ColorTheme.cWhite,
              size:  controller.space25.value,
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
            child: SingleChildScrollView(
              child: Padding(
                padding:   EdgeInsets.all(controller.space20.value),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    webDashBoard(),
                      SizedBox(
                      height: controller.space20.value,
                    ),
                    getOverallSVChart(),
                      SizedBox(
                      height: controller.space20.value,
                    ),
                    getWaitingSVChart(),
                      SizedBox(
                      height: controller.space20.value,
                    ),
                    getSourceWiseCount(),
                      SizedBox(
                      height: controller.space20.value,
                    ),
                    getSVWaitList(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget webDashBoard() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding:   EdgeInsets.all(controller.space20.value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Summary",
                    style: semiBoldTextStyle(size: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: RotatingIconButton(
                      onPressed: () async {
                        await controller.retrieveSiteVisitCount();
                      }, // Your API function here
                    ),
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton(
                color: ColorTheme.cBgBlack,
                position: PopupMenuPosition.under,
                onSelected: (value) {
                  if (value != DateRangeSelection.custom) {
                    controller.svCountFromDate.value =
                        getDateRangeSelection(isFromDate: true, range: value);
                    controller.svCountToDate.value =
                        getDateRangeSelection(isFromDate: false, range: value);

                    controller.retrieveSiteVisitCount();
                  }else{
                    commonDialog(
                      child: customDateSelection(fromDate: controller.svCountFromDate,toDate: controller.svCountToDate) ,
                      onTapBottomButton: () {
                      }, mainHeadingText: "Custom Date Filter",
                    );
                  }
                },
                itemBuilder: controller.getPopupMenuDays,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    AssetsString.aDotsVertical,
                    height:  controller.space25.value,
                    colorFilter: const ColorFilter.mode(
                        ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
            SizedBox(

              height: isWeb ? controller.space25.value:10,
          ),
          Container(
            color: ColorTheme.cAppTheme,
            padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
            child: Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${formatDate(controller.svCountFromDate.value.toIso8601String(), 4)}-${formatDate(controller.svCountToDate.value.toIso8601String(), 4)}",
                      style: semiBoldTextStyle(size: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (!(checkIfToday(controller.svCountFromDate.value) &&
                        checkIfToday(controller.svCountToDate.value)))
                      GestureDetector(
                        onTap: () {
                          controller.svCountFromDate.value = DateTime.now();
                          controller.svCountToDate.value = DateTime.now();
                          controller.retrieveSiteVisitCount();
                        },
                        child: Container(
                            color: Colors.transparent,
                            child:   Icon(
                              Icons.close,
                              size: controller.space20.value,
                              color: ColorTheme.cWhite,
                            )),
                      )
                  ],
                )),
          ),
            SizedBox(
            height: controller.space20.value,
          ),
          Container(
            color: ColorTheme.cThemeBg,
            padding: EdgeInsets.all(isWeb ? 45 : controller.space20.value),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorTheme.cBgMosque,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AssetsString.aSiteVisit,
                    colorFilter:
                        ColorFilter.mode(ColorTheme.cMosque, BlendMode.srcIn),
                    height: isWeb ? 30 : controller.space20.value,
                  ),
                ),
                  SizedBox(
                  width: controller.space20.value,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => controller.isSVCountLoading.value?BoxShimmer(
                        height:  isWeb ? 45 : 30,
                        width:  isWeb ? 45 : 30,

                      ):Text(
                        controller.svCount.value.toString(),
                        style: semiBoldTextStyle(size: isWeb ? 45 : 30),
                      ),
                    ),
                    Text(
                      "SITE VISIT",
                      style: mediumTextStyle(size: isWeb ? 14 : 10),
                    ),
                  ],
                ),
                SizedBox(
                  width: isWeb ? 180 : 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getOverallSVChart() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding:   EdgeInsets.all(controller.space20.value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Overall SV per Hour",
                    style: semiBoldTextStyle(size: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: RotatingIconButton(
                      onPressed: () async {
                        await controller.getSVPerHourList();
                      }, // Your API function here
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  if (isWeb)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.showOverAllSVChart.value = true;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aChartBar,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showOverAllSVChart.value
                                          ? ColorTheme.cAppTheme
                                          : ColorTheme.cWhite,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showOverAllSVChart.value = false;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aTable,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showOverAllSVChart.value
                                          ? ColorTheme.cWhite
                                          : ColorTheme.cAppTheme,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                      ],
                    ),
                  PopupMenuButton(
                    color: ColorTheme.cBgBlack,
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      if (value != DateRangeSelection.custom) {
                        controller.svPerHourFromDate.value =
                            getDateRangeSelection(
                                isFromDate: true, range: value);
                        controller.svPerHourToDate.value =
                            getDateRangeSelection(
                                isFromDate: false, range: value);

                        controller.getSVPerHourList();
                      }
                    },
                    itemBuilder: controller.getPopupMenuDays,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        AssetsString.aDotsVertical,
                        height:  controller.space25.value,
                        colorFilter: const ColorFilter.mode(
                            ColorTheme.cWhite, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
            SizedBox(
            height:  controller.space25.value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: ColorTheme.cAppTheme,
                padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                child: Obx(() => Row(
                      children: [
                        Text(
                          "${formatDate(controller.svPerHourFromDate.value.toIso8601String(), 4)}-${formatDate(controller.svPerHourToDate.value.toIso8601String(), 4)}",
                          style: semiBoldTextStyle(size: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (!(checkIfToday(
                                controller.svPerHourFromDate.value) &&
                            checkIfToday(controller.svPerHourToDate.value)))
                          GestureDetector(
                            onTap: () {
                              controller.svPerHourFromDate.value =
                                  DateTime.now();
                              controller.svPerHourToDate.value = DateTime.now();
                              controller.getSVPerHourList();
                            },
                            child: Container(
                                color: Colors.transparent,
                                child:   Icon(
                                  Icons.close,
                                  size: controller.space20.value,
                                  color: ColorTheme.cWhite,
                                )),
                          )
                      ],
                    )),
              ),
              const Spacer(),
              isWeb
                  ? Container(
                      color: ColorTheme.cAppTheme,
                      padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                      child: Row(
                        children: [
                          Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                AssetsString.aDownload,
                                colorFilter: const ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Download",
                            style: semiBoldTextStyle(size: 12),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.showOverAllSVChart.value = true;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aChartBar,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showOverAllSVChart.value
                                          ? ColorTheme.cAppTheme
                                          : ColorTheme.cWhite,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showOverAllSVChart.value = false;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aTable,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showOverAllSVChart.value
                                          ? ColorTheme.cWhite
                                          : ColorTheme.cAppTheme,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              AssetsString.aDownload,
                              height:  controller.space25.value,
                              colorFilter: const ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
            SizedBox(
            height: controller.space20.value,
          ),
          // SingleChildScrollView(
          //   scrollDirection: isWeb ? Axis.vertical : Axis.horizontal,
          //   child: Obx(() => controller.showOverAllSVChart.value
          //       ? Container(
          //           padding: EdgeInsets.symmetric(horizontal: isWeb ? 250 : 0),
          //           height: isWeb ? 730 : 300,
          //           width: isWeb ? null : 1200,
          //           child: FutureBuilder(builder: (context, snapshot) {
          //             if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          //               if(controller.svList.isNotEmpty){
          //                 return SfCartesianChart(
          //                   plotAreaBorderWidth: 0,
          //                   tooltipBehavior: TooltipBehavior(
          //                     enable: true,
          //                     format: "point.y",
          //                   ),
          //                   primaryYAxis: NumericAxis(
          //                     majorTickLines: const MajorTickLines(
          //                       width: 0,
          //                     ),
          //                     axisLine: const AxisLine(width: 0),
          //                     labelStyle: mediumTextStyle(
          //                       size: 12,
          //                     ),
          //                     majorGridLines:
          //                     MajorGridLines(color: ColorTheme.cLineColor),
          //                     interval: 3,
          //                   ),
          //                   primaryXAxis: CategoryAxis(
          //                     borderColor: Colors.transparent,
          //                     axisLine: AxisLine(
          //                       color: ColorTheme.cLineColor,
          //                     ),
          //                     majorTickLines:
          //                     MajorTickLines(color: ColorTheme.cLineColor),
          //                     majorGridLines: const MajorGridLines(
          //                         color: Colors.transparent, width: 0),
          //                     labelStyle: mediumTextStyle(
          //                       size: 12,
          //                     ),
          //                   ),
          //                   axes: [
          //                     //todo check label on both side
          //                     /*const NumericAxis(isVisible: false,name: "xAxis",),
          //         NumericAxis(
          //           name: "yAxis",
          //         majorTickLines: const MajorTickLines(width: 0,),
          //         axisLine: const AxisLine(width: 0),
          //         labelStyle:  mediumTextStyle(size: 12, ),
          //         majorGridLines: MajorGridLines(color:  ColorTheme.cLineColor),
          //         interval: 3,
          //         opposedPosition: true,
          //       ),*/
          //                   ],
          //                   series: <ColumnSeries<SVChartDataModel, String>>[
          //                     ColumnSeries<SVChartDataModel, String>(
          //                       dataLabelMapper: (datum, index) {
          //                         return datum.count.toString();
          //                       },
          //                       dataLabelSettings: const DataLabelSettings(
          //                           isVisible: true,
          //                           alignment: ChartAlignment.center,
          //                           labelAlignment: ChartDataLabelAlignment
          //                               .middle),
          //                       color: ColorTheme.cAppTheme,
          //                       xValueMapper: (datum, index) => datum.time,
          //                       yValueMapper: (SVChartDataModel datum, index) =>
          //                       datum.count,
          //                       dataSource: List.generate(
          //                           controller.svList.first.lable.length,
          //                               (index) =>
          //                               SVChartDataModel(
          //                                   controller.svList.first
          //                                       .lable[index],
          //                                   controller.svList.first.count[index]
          //                                       .toDouble())),
          //                     )
          //                   ],
          //                 );
          //               }else{
          //               return Center(
          //                 child: Text("No Data",style: mediumTextStyle(),),
          //               );
          //             }
          //             }else{
          //               return Center(
          //                 child: Text("Loading",style: mediumTextStyle(),),
          //               );
          //             }
          //           },future: controller.getSVList(),),
          //         )
          //       : SizedBox(
          //           width: controller.sizingInformation.value.screenSize.width -
          //               80,
          //           child: Table(
          //             children: List.generate(
          //                 controller.svList.first.lable.length + 1, (index) {
          //               return index == 0
          //                   ? TableRow(
          //                       decoration: BoxDecoration(
          //                           border: Border(
          //                               bottom: BorderSide(
          //                                   color: ColorTheme.cLineColor))),
          //                       children: [
          //                           Padding(
          //                             padding: const EdgeInsets.only(
          //                                 top: 10, bottom: 5),
          //                             child: Text(
          //                               "Time".toUpperCase(),
          //                               style: semiBoldTextStyle(),
          //                             ),
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.only(
          //                                 top: 10, bottom: 5),
          //                             child: Text(
          //                               "Count".toUpperCase(),
          //                               style: semiBoldTextStyle(),
          //                             ),
          //                           ),
          //                         ])
          //                   : TableRow(
          //                       decoration: BoxDecoration(
          //                           border: Border(
          //                               bottom: BorderSide(
          //                                   color: ColorTheme.cLineColor))),
          //                       children: [
          //                           Padding(
          //                             padding: const EdgeInsets.only(
          //                                 top: 20, bottom: 10),
          //                             child: Text(
          //                               controller
          //                                   .svList.first.lable[index - 1],
          //                               style: mediumTextStyle(),
          //                             ),
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.only(
          //                                 top: 20, bottom: 10),
          //                             child: Text(
          //                               controller.svList.first.count[index - 1]
          //                                   .toString(),
          //                               style: mediumTextStyle(),
          //                             ),
          //                           ),
          //                         ]);
          //             }),
          //           ),
          //         )),
          // ),

          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (controller.svPerHourList.isNotEmpty) {
                  return SingleChildScrollView(
                      scrollDirection: isWeb ? Axis.vertical : Axis.horizontal,
                      child: Obx(
                        () => controller.svPerHourList.isNotEmpty
                            ? controller.showOverAllSVChart.value
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isWeb ? 250 : 0),
                                    height: isWeb ? 730 : 300,
                                    width: isWeb ? null : 1200,
                                    child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      tooltipBehavior: TooltipBehavior(
                                        enable: true,
                                        format: "point.y",
                                      ),
                                      primaryYAxis: NumericAxis(
                                        majorTickLines: const MajorTickLines(
                                          width: 0,
                                        ),
                                        axisLine: const AxisLine(width: 0),
                                        labelStyle: mediumTextStyle(
                                          size: 12,
                                        ),
                                        majorGridLines: MajorGridLines(
                                            color: ColorTheme.cLineColor),
                                        interval: 3,
                                      ),
                                      primaryXAxis: CategoryAxis(
                                        borderColor: Colors.transparent,
                                        axisLine: AxisLine(
                                          color: ColorTheme.cLineColor,
                                        ),
                                        majorTickLines: MajorTickLines(
                                            color: ColorTheme.cLineColor),
                                        majorGridLines: const MajorGridLines(
                                            color: Colors.transparent,
                                            width: 0),
                                        labelStyle: mediumTextStyle(
                                          size: 12,
                                        ),
                                      ),
                                      series: <ColumnSeries<SVChartDataModel,
                                          String>>[
                                        ColumnSeries<SVChartDataModel, String>(
                                          dataLabelMapper: (datum, index) {
                                            return datum.count.toString();
                                          },
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true,
                                                  alignment:
                                                      ChartAlignment.center,
                                                  labelAlignment:
                                                      ChartDataLabelAlignment
                                                          .middle),
                                          color: ColorTheme.cAppTheme,
                                          xValueMapper: (datum, index) =>
                                              datum.time,
                                          yValueMapper:
                                              (SVChartDataModel datum, index) =>
                                                  datum.count,
                                          dataSource: List.generate(
                                              controller.svPerHourList.first
                                                  .lable.length,
                                              (index) => SVChartDataModel(
                                                  controller.svPerHourList.first
                                                      .lable[index],
                                                  controller.svPerHourList.first
                                                      .count[index]
                                                      .toDouble())),
                                        )
                                      ],
                                    ))
                                : SizedBox(
                                    width: controller.sizingInformation.value
                                            .screenSize.width -
                                        80,
                                    child: Table(
                                      children: List.generate(
                                          controller.svPerHourList.first.lable
                                                  .length +
                                              1, (index) {
                                        return index == 0
                                            ? TableRow(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: ColorTheme
                                                                .cLineColor))),
                                                children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 5),
                                                      child: Text(
                                                        "Time".toUpperCase(),
                                                        style:
                                                            semiBoldTextStyle(),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 5),
                                                      child: Text(
                                                        "Count".toUpperCase(),
                                                        style:
                                                            semiBoldTextStyle(),
                                                      ),
                                                    ),
                                                  ])
                                            : TableRow(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: ColorTheme
                                                                .cLineColor))),
                                                children: [
                                                    Padding(
                                                      padding:
                                                            EdgeInsets.only(
                                                              top: controller.space20.value,
                                                              bottom: 10),
                                                      child: Text(
                                                        controller
                                                            .svPerHourList
                                                            .first
                                                            .lable[index - 1],
                                                        style:
                                                            mediumTextStyle(),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                            EdgeInsets.only(
                                                              top: controller.space20.value,
                                                              bottom: 10),
                                                      child: Text(
                                                        controller
                                                            .svPerHourList
                                                            .first
                                                            .count[index - 1]
                                                            .toString(),
                                                        style:
                                                            mediumTextStyle(),
                                                      ),
                                                    ),
                                                  ]);
                                      }),
                                    ),
                                  )
                            : Center(
                                child: Text(
                                "Loading",
                                style: mediumTextStyle(),
                              )),
                      ));
                } else {
                  return Center(
                    child: Text(
                      "No Data",
                      style: mediumTextStyle(),
                    ),
                  );
                }
              } else {
                return Center(
                  child: Text(
                    "Loading",
                    style: mediumTextStyle(),
                  ),
                );
              }
            },
            future: controller.getSVPerHourList(),
          ),
        ],
      ),
    );
  }

  Widget getWaitingSVChart() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding:   EdgeInsets.all(controller.space20.value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "SV Waiting",
                    style: semiBoldTextStyle(size: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: RotatingIconButton(
                      onPressed: () async {
                        await controller.getSVWaitList();
                      }, // Your API function here
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  if (isWeb)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.showSVWaitListChart.value = true;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aChartBar,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showSVWaitListChart.value
                                          ? ColorTheme.cAppTheme
                                          : ColorTheme.cWhite,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showSVWaitListChart.value = false;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aTable,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showSVWaitListChart.value
                                          ? ColorTheme.cWhite
                                          : ColorTheme.cAppTheme,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                      ],
                    ),
                  PopupMenuButton(
                    color: ColorTheme.cBgBlack,
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      if (value != DateRangeSelection.custom) {
                        controller.svWaitingFromDate.value =
                            getDateRangeSelection(
                                isFromDate: true, range: value);
                        controller.svWaitingToDate.value =
                            getDateRangeSelection(
                                isFromDate: false, range: value);

                        controller.getSVWaitList();
                      }
                    },
                    itemBuilder: controller.getPopupMenuDays,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        AssetsString.aDotsVertical,
                        height:  controller.space25.value,
                        colorFilter: const ColorFilter.mode(
                            ColorTheme.cWhite, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
            SizedBox(
            height:  controller.space25.value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: ColorTheme.cAppTheme,
                padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                child: Obx(() => Row(
                      children: [
                        Text(
                          "${formatDate(controller.svWaitingFromDate.value.toIso8601String(), 4)}-${formatDate(controller.svWaitingToDate.value.toIso8601String(), 4)}",
                          style: semiBoldTextStyle(size: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (!(checkIfToday(
                                controller.svPerHourFromDate.value) &&
                            checkIfToday(controller.svWaitingToDate.value)))
                          GestureDetector(
                            onTap: () {
                              controller.svWaitingFromDate.value =
                                  DateTime.now();
                              controller.svWaitingToDate.value = DateTime.now();
                              controller.getSVWaitList();
                            },
                            child: Container(
                                color: Colors.transparent,
                                child:   Icon(
                                  Icons.close,
                                  size: controller.space20.value,
                                  color: ColorTheme.cWhite,
                                )),
                          )
                      ],
                    )),
              ),
              const Spacer(),
              isWeb
                  ? Container(
                      color: ColorTheme.cAppTheme,
                      padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                      child: Row(
                        children: [
                          Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                AssetsString.aDownload,
                                colorFilter: const ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Download",
                            style: semiBoldTextStyle(size: 12),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.showSVWaitListChart.value = true;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aChartBar,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showSVWaitListChart.value
                                          ? ColorTheme.cAppTheme
                                          : ColorTheme.cWhite,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showSVWaitListChart.value = false;
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: Obx(() => SvgPicture.asset(
                                  AssetsString.aTable,
                                  height:  controller.space25.value,
                                  colorFilter: ColorFilter.mode(
                                      controller.showSVWaitListChart.value
                                          ? ColorTheme.cWhite
                                          : ColorTheme.cAppTheme,
                                      BlendMode.srcIn),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              AssetsString.aDownload,
                              height:  controller.space25.value,
                              colorFilter: const ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
            SizedBox(
            height: controller.space20.value,
          ),
          SingleChildScrollView(
            scrollDirection: isWeb ? Axis.vertical : Axis.horizontal,
            child: Obx(
              () => controller.svWaitlist.isNotEmpty
                  ? controller.showSVWaitListChart.value
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: isWeb ? 250 : 0),
                          height: isWeb ? 730 : 300,
                          width: isWeb ? null : 1200,
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            tooltipBehavior: TooltipBehavior(enable: true),
                            onTooltipRender: (tooltipArgs) {},
                            primaryYAxis: NumericAxis(
                              majorTickLines: const MajorTickLines(
                                width: 0,
                              ),
                              axisLine: const AxisLine(width: 0),
                              labelStyle: mediumTextStyle(
                                size: 12,
                              ),
                              majorGridLines:
                                  MajorGridLines(color: ColorTheme.cLineColor),
                            ),
                            primaryXAxis: CategoryAxis(
                              borderColor: Colors.transparent,
                              axisLine: AxisLine(color: ColorTheme.cLineColor),
                              labelRotation: 45,
                              majorTickLines:
                                  MajorTickLines(color: ColorTheme.cLineColor),
                              majorGridLines: const MajorGridLines(
                                  color: Colors.transparent, width: 0),
                              labelStyle: mediumTextStyle(
                                size: 12,
                              ),
                            ),
                            series: <ColumnSeries<SVChartDataModel, String>>[
                              ColumnSeries<SVChartDataModel, String>(
                                dataLabelMapper: (datum, index) {
                                  return datum.count.toString();
                                },
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    alignment: ChartAlignment.center,
                                    labelAlignment:
                                        ChartDataLabelAlignment.middle),
                                color: ColorTheme.cAppTheme,
                                xValueMapper: (datum, index) => datum.time,
                                yValueMapper: (SVChartDataModel datum, index) =>
                                    datum.count,
                                dataSource: List.generate(
                                    controller
                                        .svWaitlist.first.svownerdata.length,
                                    (index) => SVChartDataModel(
                                        controller.svWaitlist.first
                                            .svownerdata[index].name,
                                        controller.svWaitlist.first.count[index]
                                            .toDouble())),
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          width: controller
                                  .sizingInformation.value.screenSize.width -
                              80,
                          child: Table(
                            children: List.generate(
                                controller.svWaitlist.first.svownerdata.length +
                                    1, (index) {
                              return index == 0
                                  ? TableRow(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      ColorTheme.cLineColor))),
                                      children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              "Time".toUpperCase(),
                                              style: semiBoldTextStyle(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              "Count".toUpperCase(),
                                              style: semiBoldTextStyle(),
                                            ),
                                          ),
                                        ])
                                  : TableRow(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      ColorTheme.cLineColor))),
                                      children: [
                                          Padding(
                                            padding:   EdgeInsets.only(
                                                top: controller.space20.value, bottom: 10),
                                            child: Text(
                                              controller.svWaitlist.first
                                                  .svownerdata[index - 1].name,
                                              style: mediumTextStyle(),
                                            ),
                                          ),
                                          Padding(
                                            padding:   EdgeInsets.only(
                                                top: controller.space20.value, bottom: 10),
                                            child: Text(
                                              controller.svWaitlist.first
                                                  .count[index - 1]
                                                  .toString(),
                                              style: mediumTextStyle(),
                                            ),
                                          ),
                                        ]);
                            }),
                          ),
                        )
                  : Center(
                      child: Text(
                        "Loading",
                        style: mediumTextStyle(),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSourceWiseCount() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding:   EdgeInsets.all(controller.space20.value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Source Wise SV Count",
                    style: semiBoldTextStyle(size: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: RotatingIconButton(
                      onPressed: () async {
                        await controller.getSourceWiseSVCountList();
                      }, // Your API function here
                    ),
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton(
                color: ColorTheme.cBgBlack,
                position: PopupMenuPosition.under,
                onSelected: (value) {
                  if (value != DateRangeSelection.custom) {
                    controller.sourceWiseSvFromDate.value =
                        getDateRangeSelection(isFromDate: true, range: value);
                    controller.sourceWiseSvToDate.value =
                        getDateRangeSelection(isFromDate: false, range: value);

                    controller.getSourceWiseSVCountList();
                  }
                },
                itemBuilder: controller.getPopupMenuDays,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    AssetsString.aDotsVertical,
                    height:  controller.space25.value,
                    colorFilter: const ColorFilter.mode(
                        ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
            SizedBox(
            height:  controller.space25.value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: ColorTheme.cAppTheme,
                padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                child: Obx(() => Row(
                      children: [
                        Text(
                          "${formatDate(controller.sourceWiseSvFromDate.value.toIso8601String(), 4)}-${formatDate(controller.sourceWiseSvToDate.value.toIso8601String(), 4)}",
                          style: semiBoldTextStyle(size: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (!(checkIfToday(
                                controller.sourceWiseSvFromDate.value) &&
                            checkIfToday(controller.sourceWiseSvToDate.value)))
                          GestureDetector(
                            onTap: () {
                              controller.sourceWiseSvFromDate.value =
                                  DateTime.now();
                              controller.sourceWiseSvToDate.value =
                                  DateTime.now();
                              controller.getSourceWiseSVCountList();
                            },
                            child: Container(
                                color: Colors.transparent,
                                child:   Icon(
                                  Icons.close,
                                  size: controller.space20.value,
                                  color: ColorTheme.cWhite,
                                )),
                          )
                      ],
                    )),
              ),
              const Spacer(),
              isWeb
                  ? Container(
                      color: ColorTheme.cAppTheme,
                      padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                      child: Row(
                        children: [
                          Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                AssetsString.aDownload,
                                colorFilter: const ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Download",
                            style: semiBoldTextStyle(size: 12),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        AssetsString.aDownload,
                        height:  controller.space25.value,
                        colorFilter: const ColorFilter.mode(
                            ColorTheme.cWhite, BlendMode.srcIn),
                      ),
                    ),
            ],
          ),
            SizedBox(
            height: controller.space20.value,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Obx(() => controller.sourceWiseSVCountList.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection:
                            isWeb ? Axis.vertical : Axis.horizontal,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: isWeb ? 250 : 0),
                          width: isWeb ? null : 700,
                          child: Table(
                            children: List.generate(
                                controller.sourceWiseSVCountList.length + 1,
                                (index) {
                              return index == 0
                                  ? TableRow(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      ColorTheme.cLineColor))),
                                      children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              "Source".toUpperCase(),
                                              style: semiBoldTextStyle(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              "Count".toUpperCase(),
                                              style: semiBoldTextStyle(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              "Percentage".toUpperCase(),
                                              style: semiBoldTextStyle(),
                                            ),
                                          ),
                                        ])
                                  : TableRow(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color:
                                                      ColorTheme.cLineColor))),
                                      children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              controller
                                                  .sourceWiseSVCountList[
                                                      index - 1]
                                                  .source,
                                              style: mediumTextStyle(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              controller
                                                  .sourceWiseSVCountList[
                                                      index - 1]
                                                  .count
                                                  .toString(),
                                              style: mediumTextStyle(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Text(
                                              "${controller.sourceWiseSVCountList[index - 1].percentage.toString()} %",
                                              style: mediumTextStyle(),
                                            ),
                                          ),
                                        ]);
                            }),
                          ),
                        ))
                    : Center(
                        child: Text(
                          "No Data",
                          style: mediumTextStyle(),
                        ),
                      ));
              } else {
                return Center(
                  child: Text(
                    "Loading",
                    style: mediumTextStyle(),
                  ),
                );
              }
            },
            future: controller.getSourceWiseSVCountList(),
          ),
        ],
      ),
    );
  }

  Widget getSVWaitList() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding:   EdgeInsets.all(controller.space20.value),
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
                    child: Obx(() => Container(
                          padding:   EdgeInsets.symmetric(
                              vertical: 10, horizontal: controller.space20.value),
                          color: controller.homeController.showAssigned.value
                              ? ColorTheme.cThemeBg
                              : ColorTheme.cAppTheme,
                          child: Text(
                            "Unassigned",
                            style: mediumTextStyle(),
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.homeController
                          .toggleShowAssigned(newVal: true);
                    },
                    child: Obx(() => Container(
                          padding:   EdgeInsets.symmetric(
                              vertical: 10, horizontal: controller.space20.value),
                          color: controller.homeController.showAssigned.value
                              ? ColorTheme.cAppTheme
                              : ColorTheme.cThemeBg,
                          child: Text(
                            "Assigned",
                            style: mediumTextStyle(),
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 260,
                    height: 40,
                    child: TextFormField(
                      cursorColor: ColorTheme.cWhite,
                      style: mediumTextStyle(size: 12),
                      textAlignVertical: TextAlignVertical.center,
                      expands: true,
                      maxLines: null,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorTheme.cWhite.withOpacity(0.2),
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(8),
                            height: 30,
                            width: 30,
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              AssetsString.aSearch,
                              height: controller.space20.value,
                              colorFilter: const ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1800,
              child: Obx(() => Table(
                    columnWidths: const {
                      5: FlexColumnWidth(2.0),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List.generate(
                        controller.homeController.filteredLeadList.length + 1,
                        (index) {
                      return index == 0
                          ? TableRow(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorTheme.cLineColor))),
                              children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "Order".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "Token".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "Owner".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "Details".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "Status".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "Project".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "Source".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      "sourcing Manager".toUpperCase(),
                                      style: semiBoldTextStyle(),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: Text(
                                        "Date".toUpperCase(),
                                        style: semiBoldTextStyle(),
                                      ),
                                    ),
                                  ),
                                ])
                          : TableRow(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorTheme.cLineColor))),
                              children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      controller
                                          .homeController
                                          .filteredLeadList[index - 1]
                                          .scanVisitLocationData[0]
                                          .svWaitListNumber
                                          .toString(),
                                      style: mediumTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      controller
                                          .homeController
                                          .filteredLeadList[index - 1]
                                          .scanVisitLocationData[0]
                                          .currentVisitToken
                                          .toString(),
                                      style: mediumTextStyle(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: /*controller
                                          .homeController
                                          .filteredLeadList[index - 1]
                                          .isClaim == "0"
                                      ? Container(
                                          height: 40,
                                          width: 40,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorTheme.cBgBlue),
                                          child: Center(
                                            child: Text(
                                              "CLAIM",
                                              style: semiBoldTextStyle(
                                                  size: 8,
                                                  color: ColorTheme.cMosque),
                                            ),
                                          ),
                                        )
                                      :
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: ColorTheme.cBgBlue,
                                      child: Text(
                                        controller
                                            .homeController
                                            .filteredLeadList[index - 1]
                                            .svOwnerName,
                                      ),
                                    ),
                                  ),*/
                                            Text(
                                          controller
                                              .homeController
                                              .filteredLeadList[index - 1]
                                              .svOwnerName,
                                          style: semiBoldTextStyle(
                                            size: 14,
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: controller
                                                      .getRandomColor()),
                                              child: Center(
                                                child: Text(
                                                  controller
                                                      .homeController
                                                      .filteredLeadList[
                                                          index - 1]
                                                      .leadData[0]
                                                      .firstName
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: mediumTextStyle(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${controller.homeController.filteredLeadList[index - 1].leadData[0].firstName} ${controller.homeController.filteredLeadList[index - 1].leadData[0].lastName}",
                                                  style:
                                                      boldTextStyle(size: 16),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Container(
                                                  color: ColorTheme.cAppTheme,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Text(
                                                    "#${controller.homeController.filteredLeadList[index - 1].leadData[0].leadId}",
                                                    style: semiBoldTextStyle(
                                                        size: 12),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     controller
                                        //             .homeController
                                        //             .filteredLeadList[index - 1]
                                        //             .details
                                        //             .cp
                                        //         ? Container(
                                        //             color: ColorTheme.cAppTheme
                                        //                 .withOpacity(0.08),
                                        //             padding:
                                        //                 const EdgeInsets.symmetric(
                                        //                     horizontal: 8,
                                        //                     vertical: 4),
                                        //             child: Text(
                                        //               "CP",
                                        //               style: semiBoldTextStyle(
                                        //                   size: 12),
                                        //             ),
                                        //           )
                                        //         : Container(
                                        //             color: ColorTheme.cBgMosque,
                                        //             padding:
                                        //                 const EdgeInsets.symmetric(
                                        //                     horizontal: 8,
                                        //                     vertical: 2),
                                        //             child: SvgPicture.asset(
                                        //               AssetsString.aUser,
                                        //               height: controller.space20.value,
                                        //               colorFilter: ColorFilter.mode(
                                        //                   ColorTheme.cMosque,
                                        //                   BlendMode.srcIn),
                                        //             ),
                                        //           ),
                                        //     const SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     controller
                                        //             .homeController
                                        //             .filteredLeadList[index - 1]
                                        //             .details
                                        //             .missedCall
                                        //         ? Container(
                                        //             color: ColorTheme.cBgRed
                                        //                 .withOpacity(0.2),
                                        //             padding:
                                        //                 const EdgeInsets.symmetric(
                                        //                     horizontal: 8,
                                        //                     vertical: 4),
                                        //             child: Text(
                                        //               "Missed Call",
                                        //               style: semiBoldTextStyle(
                                        //                   size: 12,
                                        //                   color:
                                        //                       ColorTheme.cFontRed),
                                        //             ),
                                        //           )
                                        //         : const SizedBox()
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Text(
                                      controller
                                          .homeController
                                          .filteredLeadList[index - 1]
                                          .siteVisitStatus,
                                      style: semiBoldTextStyle(
                                          size: 12, color: ColorTheme.cMosque),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AssetsString.aSiteVisit,
                                              height: controller.space20.value,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      ColorTheme.cWhite,
                                                      BlendMode.srcIn),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              controller
                                                  .homeController
                                                  .filteredLeadList[index - 1]
                                                  .leadData[0]
                                                  .projectLocationDescription,
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
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          ColorTheme.cWhite,
                                                          BlendMode.srcIn),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  controller
                                                      .homeController
                                                      .filteredLeadList[
                                                          index - 1]
                                                      .leadData[0]
                                                      .projectName,
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
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          ColorTheme.cWhite,
                                                          BlendMode.srcIn),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  controller
                                                      .homeController
                                                      .filteredLeadList[
                                                          index - 1]
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
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          ColorTheme.cWhite,
                                                          BlendMode.srcIn),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  controller
                                                      .homeController
                                                      .filteredLeadList[
                                                          index - 1]
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
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: Text(
                                        controller
                                            .homeController
                                            .filteredLeadList[index - 1]
                                            .leadSourceDescription,
                                        style: semiBoldTextStyle(
                                            size: 12,
                                            color: ColorTheme.cMosque),
                                      ))),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: controller
                                            .homeController
                                            .filteredLeadList[index - 1]
                                            .sourcingManagerList
                                            .isNotEmpty
                                        ? Column(
                                            children: List.generate(
                                                controller
                                                    .homeController
                                                    .filteredLeadList[index - 1]
                                                    .sourcingManagerList
                                                    .length,
                                                (managerIndex) => Container(
                                                      color:
                                                          ColorTheme.cThemeBg,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            color: ColorTheme
                                                                .cBgBlue,
                                                            height: 30,
                                                            width: 30,
                                                            child: Center(
                                                              child: Text(
                                                                controller
                                                                    .homeController
                                                                    .filteredLeadList[
                                                                        index -
                                                                            1]
                                                                    .sourcingManagerList[
                                                                        managerIndex]
                                                                    .ownerEmpName
                                                                    .substring(
                                                                        0, 1)
                                                                    .toUpperCase(),
                                                                style:
                                                                    boldTextStyle(
                                                                        size:
                                                                            14),
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
                                                                  .filteredLeadList[
                                                                      index - 1]
                                                                  .sourcingManagerList[
                                                                      managerIndex]
                                                                  .ownerEmpName,
                                                              style:
                                                                  mediumTextStyle(),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                          )
                                        : const SizedBox(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            color: ColorTheme.cWhite
                                                .withOpacity(0.2),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                              convertDate(controller
                                                  .homeController
                                                  .filteredLeadList[index - 1]
                                                  .createdAt),
                                              style: mediumTextStyle(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Container(
                                            color: ColorTheme.cWhite
                                                .withOpacity(0.2),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                              convertDate(controller
                                                  .homeController
                                                  .filteredLeadList[index - 1]
                                                  .updatedAt),
                                              style: mediumTextStyle(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]);
                    }),
                  )),
            ),
          )
        ],
      ),
    );
  }
  Widget customDateSelection({required Rx<DateTime> fromDate,required Rx<DateTime> toDate}){

    TextEditingController txtFromDate = TextEditingController();
    fromDate.value = toDate.value;
    fromDate.refresh();
    return Container(
      color: ColorTheme.cThemeBg,
padding: EdgeInsets.all(controller.space20.value),
child:Column(
  children: [
    customTextField(
        readOnly: true,
        labelText: 'Start Date*',
        validator: (value) {
          if (value!.trim().isEmpty) {
            return "Please select start date";
          } else {
            return null;
          }
        },
        controller: txtFromDate,
        onTap: () {
          selectDate(txtFromDate, DateFormat('dd-MM-yyyy'),
              DateTime(DateTime.now().year, 01, 01), DateTime.now());
        },
        onChange: (value) {
          txtFromDate.text = value;
        },
        suffixWidget: calenderView()),
    const SizedBox(height: 60,)
  ],
),
    );
  }
}

class SiteVisitSourceCount extends DataGridSource {
  SiteVisitSourceCount(
      {required List<SiteVisitSourceWiseCountModel> dataList}) {
    data = dataList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Cp Name', value: e.source ?? ''),
              DataGridCell<String>(
                  columnName: 'Cp Count', value: e.count.toString()),
            ]))
        .toList();
  }

  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        color: e.columnName == 'Cp Name'
            ? ColorTheme.cThemeBg
            : ColorTheme.cThemeBg,
        child: Text(
          e.value.toString(),
          style: regularTextStyle(
              color: e.columnName == 'count' ? Colors.white : Colors.white,
              size: 13),
        ),
      );
    }).toList());
  }


}
