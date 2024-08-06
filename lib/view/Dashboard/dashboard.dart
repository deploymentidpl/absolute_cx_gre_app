import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/controller/DashboardController/dashboard_controller.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:greapp/widgets/web_tabbar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/connectivity_service.dart';
import '../../config/utils/constant.dart';
import '../../model/ChartDataModel/chart_data_model.dart';
import '../../widgets/BottomBar/custom_bottombar.dart';
import '../../widgets/CommonDesigns/common_designs.dart';
import '../../widgets/Drawer/app_drawer.dart';
import '../../widgets/app_header.dart';
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
        print("isWeb---${isWeb}");

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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        webDashBoard(),
                        const SizedBox(
                          height: 20,
                        ),
                        getOverallSVChart(),
                        const SizedBox(
                          height: 20,
                        ),
                        getWaitingSVChart(),
                        const SizedBox(
                          height: 20,
                        ),
                        getSourceWiseCount(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: (){
            Get.toNamed(RouteNames.kSVForm);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorTheme.cAppTheme,
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.add,color: ColorTheme.cWhite,size: 25,),
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    webDashBoard(),
                    const SizedBox(
                      height: 20,
                    ),
                    getOverallSVChart(),
                    const SizedBox(
                      height: 20,
                    ),
                    getWaitingSVChart(),
                    const SizedBox(
                      height: 20,
                    ),
                    getSourceWiseCount(),
                    const SizedBox(
                      height: 20,
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
      padding: const EdgeInsets.all(20),
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
                  SvgPicture.asset(
                    AssetsString.aRefresh,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                        ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  AssetsString.aDotsVertical,
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            color: ColorTheme.cAppTheme,
            padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "18 Mar-24 Mar",
                  style: semiBoldTextStyle(size: 12),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    color: Colors.transparent,
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: ColorTheme.cWhite,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: ColorTheme.cThemeBg,
            padding: EdgeInsets.all(isWeb ? 45 : 20),
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
                    height: isWeb ? 30 : 20,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.svCount.value.toString(),
                      style: semiBoldTextStyle(size: isWeb ? 45 : 30),
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
      padding: const EdgeInsets.all(20),
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
                  SvgPicture.asset(
                    AssetsString.aRefresh,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                        ColorTheme.cWhite, BlendMode.srcIn),
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
                                  height: 25,
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
                                  height: 25,
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
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      AssetsString.aDotsVertical,
                      height: 25,
                      colorFilter: const ColorFilter.mode(
                          ColorTheme.cWhite, BlendMode.srcIn),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: ColorTheme.cAppTheme,
                padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                child: Row(
                  children: [
                    Text(
                      "1 Feb-7Feb",
                      style: semiBoldTextStyle(size: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        color: Colors.transparent,
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: ColorTheme.cWhite,
                        ))
                  ],
                ),
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
                                  height: 25,
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
                                  height: 25,
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
                              height: 25,
                              colorFilter: const ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          const SizedBox(
            height: 20,
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
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                if(controller.svList.isNotEmpty){
                  return SingleChildScrollView(
                    scrollDirection: isWeb ? Axis.vertical : Axis.horizontal,
                    child: Obx(() => controller.showOverAllSVChart.value
                        ? Container(
                        padding: EdgeInsets.symmetric(horizontal: isWeb ? 250 : 0),
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
                            majorGridLines:
                            MajorGridLines(color: ColorTheme.cLineColor),
                            interval: 3,
                          ),
                          primaryXAxis: CategoryAxis(
                            borderColor: Colors.transparent,
                            axisLine: AxisLine(
                              color: ColorTheme.cLineColor,
                            ),
                            majorTickLines:
                            MajorTickLines(color: ColorTheme.cLineColor),
                            majorGridLines: const MajorGridLines(
                                color: Colors.transparent, width: 0),
                            labelStyle: mediumTextStyle(
                              size: 12,
                            ),
                          ),
                          axes: [
                            //todo check label on both side
                            /*const NumericAxis(isVisible: false,name: "xAxis",),
                    NumericAxis(
                      name: "yAxis",
                    majorTickLines: const MajorTickLines(width: 0,),
                    axisLine: const AxisLine(width: 0),
                    labelStyle:  mediumTextStyle(size: 12, ),
                    majorGridLines: MajorGridLines(color:  ColorTheme.cLineColor),
                    interval: 3,
                    opposedPosition: true,
                  ),*/
                          ],
                          series: <ColumnSeries<SVChartDataModel, String>>[
                            ColumnSeries<SVChartDataModel, String>(
                              dataLabelMapper: (datum, index) {
                                return datum.count.toString();
                              },
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  alignment: ChartAlignment.center,
                                  labelAlignment: ChartDataLabelAlignment
                                      .middle),
                              color: ColorTheme.cAppTheme,
                              xValueMapper: (datum, index) => datum.time,
                              yValueMapper: (SVChartDataModel datum, index) =>
                              datum.count,
                              dataSource: List.generate(
                                  controller.svList.first.lable.length,
                                      (index) =>
                                      SVChartDataModel(
                                          controller.svList.first
                                              .lable[index],
                                          controller.svList.first.count[index]
                                              .toDouble())),
                            )
                          ],
                        )
                    )
                        : SizedBox(
                      width: controller.sizingInformation.value.screenSize.width -
                          80,
                      child: Table(
                        children: List.generate(
                            controller.svList.first.lable.length + 1, (index) {
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
                                          color: ColorTheme.cLineColor))),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Text(
                                    controller
                                        .svList.first.lable[index - 1],
                                    style: mediumTextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: Text(
                                    controller.svList.first.count[index - 1]
                                        .toString(),
                                    style: mediumTextStyle(),
                                  ),
                                ),
                              ]);
                        }),
                      ),
                    )),
                  );
                }else{
                  return Center(
                    child: Text("No Data",style: mediumTextStyle(),),
                  );
                }
              }else{
                return Center(
                  child: Text("Loading",style: mediumTextStyle(),),
                );
              }
            },future: controller.getSVList(),
          ),
        ],
      ),
    );
  }

  Widget getWaitingSVChart() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding: const EdgeInsets.all(20),
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
                  SvgPicture.asset(
                    AssetsString.aRefresh,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                        ColorTheme.cWhite, BlendMode.srcIn),
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
                                  height: 25,
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
                                  height: 25,
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
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      AssetsString.aDotsVertical,
                      height: 25,
                      colorFilter: const ColorFilter.mode(
                          ColorTheme.cWhite, BlendMode.srcIn),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: ColorTheme.cAppTheme,
                padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                child: Row(
                  children: [
                    Text(
                      "1 Feb-7Feb",
                      style: semiBoldTextStyle(size: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        color: Colors.transparent,
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: ColorTheme.cWhite,
                        ))
                  ],
                ),
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
                                  height: 25,
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
                                  height: 25,
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
                              height: 25,
                              colorFilter: const ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: isWeb ? Axis.vertical : Axis.horizontal,
            child: Obx(()=> controller.showSVWaitListChart.value
                                          ?Container(
                padding: EdgeInsets.symmetric(horizontal: isWeb ? 250 : 0),
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
                    majorGridLines: MajorGridLines(color: ColorTheme.cLineColor),
                  ),
                  primaryXAxis: CategoryAxis(
                    borderColor: Colors.transparent,
                    axisLine: AxisLine(color: ColorTheme.cLineColor),
                    labelRotation: 45,
                    majorTickLines: MajorTickLines(color: ColorTheme.cLineColor),
                    majorGridLines:
                        const MajorGridLines(color: Colors.transparent, width: 0),
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
                          labelAlignment: ChartDataLabelAlignment.middle),
                      color: ColorTheme.cAppTheme,
                      xValueMapper: (datum, index) => datum.time,
                      yValueMapper: (SVChartDataModel datum, index) =>
                          datum.count,
                      dataSource: List.generate(
                          controller.ownerDataList.first.ownerData.length,
                          (index) => SVChartDataModel(
                              controller
                                  .ownerDataList.first.ownerData[index].name,
                              controller.ownerDataList.first.count[index]
                                  .toDouble())),
                    )
                  ],
                ),
              ):SizedBox(
              width: controller.sizingInformation.value.screenSize.width -
                  80,
              child: Table(
                children: List.generate(
                    controller.ownerDataList.first.ownerData.length + 1, (index) {
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
                                  color: ColorTheme.cLineColor))),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10),
                          child: Text(
                            controller.ownerDataList.first.ownerData[index - 1].name,
                            style: mediumTextStyle(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10),
                          child: Text(
                            controller.ownerDataList.first.count[index-1].toString(),
                            style: mediumTextStyle(),
                          ),
                        ),
                      ]);
                }),
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
      padding: const EdgeInsets.all(20),
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
                  SvgPicture.asset(
                    AssetsString.aRefresh,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                        ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  AssetsString.aDotsVertical,
                  height: 25,
                  colorFilter: const ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: ColorTheme.cAppTheme,
                padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
                child: Row(
                  children: [
                    Text(
                      "1 Feb-7Feb",
                      style: semiBoldTextStyle(size: 12),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        color: Colors.transparent,
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: ColorTheme.cWhite,
                        ))
                  ],
                ),
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
                        height: 25,
                        colorFilter: const ColorFilter.mode(
                            ColorTheme.cWhite, BlendMode.srcIn),
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          FutureBuilder(
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                if(controller.svList.isNotEmpty){
                  return
                    SingleChildScrollView(
                        scrollDirection: isWeb ? Axis.vertical : Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: isWeb ? 250 : 0),
                          width: isWeb ? null : 700,
                          child: Table(
                            children: List.generate(
                                controller.sourceWiseSVCountList.length + 1, (index) {
                              return index == 0
                                  ? TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: ColorTheme.cLineColor))),
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text(
                                        "Source".toUpperCase(),
                                        style: semiBoldTextStyle(),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text(
                                        "Count".toUpperCase(),
                                        style: semiBoldTextStyle(),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
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
                                              color: ColorTheme.cLineColor))),
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text(
                                        controller.sourceWiseSVCountList[index - 1]
                                            .sourceName,
                                        style: mediumTextStyle(),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text(
                                        controller
                                            .sourceWiseSVCountList[index - 1].count
                                            .toString(),
                                        style: mediumTextStyle(),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text(
                                        controller.sourceWiseSVCountList[index - 1]
                                            .sourceCode
                                            .toString(),
                                        style: mediumTextStyle(),
                                      ),
                                    ),
                                  ]);
                            }),
                          ),
                        ));
                }else{
                  return Center(
                    child: Text("No Data",style: mediumTextStyle(),),
                  );
                }
              }else{
                return Center(
                  child: Text("Loading",style: mediumTextStyle(),),
                );
              }
            },future: controller.getSVList(),
          ),
        ],
      ),
    );
  }

  Widget getSVWaitList() {
    return Container(
      color: ColorTheme.cThemeCard,
      padding: const EdgeInsets.all(20),
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
                      controller.assignedSV.value = false;
                    },
                    child: Obx(() => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: controller.assignedSV.value
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
                      controller.assignedSV.value = true;
                    },
                    child: Obx(() => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          color: controller.assignedSV.value
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
                              height: 20,
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
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1800,
              child: Table(
                columnWidths: const {
                  5: FlexColumnWidth(2.0),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children:
                    List.generate(controller.svWaitList.length + 1, (index) {
                  return index == 0
                      ? TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ColorTheme.cLineColor))),
                          children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "Order".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "Token".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "Owner".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "Details".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "Status".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "Project".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "Source".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  "sourcing Manager".toUpperCase(),
                                  style: semiBoldTextStyle(),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
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
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  controller.svWaitList[index - 1].order
                                      .toString(),
                                  style: mediumTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  controller.svWaitList[index - 1].token,
                                  style: mediumTextStyle(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: controller
                                          .svWaitList[index - 1].owner.claim
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
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Image.asset(
                                            controller.svWaitList[index - 1]
                                                .owner.image,
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
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
                                              color:
                                                  controller.getRandomColor()),
                                          child: Center(
                                            child: Text(
                                              controller.svWaitList[index - 1]
                                                  .details.priority
                                                  .toString(),
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
                                              controller.svWaitList[index - 1]
                                                  .owner.name,
                                              style: boldTextStyle(size: 16),
                                            ),
                                            Container(
                                              color: ColorTheme.cAppTheme,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Text(
                                                controller.svWaitList[index - 1]
                                                    .details.id,
                                                style:
                                                    semiBoldTextStyle(size: 12),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        controller.svWaitList[index - 1].details
                                                .cp
                                            ? Container(
                                                color: ColorTheme.cAppTheme
                                                    .withOpacity(0.08),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child: Text(
                                                  "CP",
                                                  style: semiBoldTextStyle(
                                                      size: 12),
                                                ),
                                              )
                                            : Container(
                                                color: ColorTheme.cBgMosque,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                child: SvgPicture.asset(
                                                  AssetsString.aUser,
                                                  height: 20,
                                                  colorFilter: ColorFilter.mode(
                                                      ColorTheme.cMosque,
                                                      BlendMode.srcIn),
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        controller.svWaitList[index - 1].details
                                                .missedCall
                                            ? Container(
                                                color: ColorTheme.cBgRed
                                                    .withOpacity(0.2),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                child: Text(
                                                  "Missed Call",
                                                  style: semiBoldTextStyle(
                                                      size: 12,
                                                      color:
                                                          ColorTheme.cFontRed),
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  controller.svWaitList[index - 1].status,
                                  style: semiBoldTextStyle(
                                      size: 12, color: ColorTheme.cMosque),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AssetsString.aSiteVisit,
                                          height: 20,
                                          colorFilter: const ColorFilter.mode(
                                              ColorTheme.cWhite,
                                              BlendMode.srcIn),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          controller.svWaitList[index - 1]
                                              .project.location,
                                          style: mediumTextStyle(),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AssetsString.aBuilding,
                                              height: 20,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      ColorTheme.cWhite,
                                                      BlendMode.srcIn),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              controller.svWaitList[index - 1]
                                                  .project.projectName,
                                              style: mediumTextStyle(),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AssetsString.aBHK,
                                              height: 20,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      ColorTheme.cWhite,
                                                      BlendMode.srcIn),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              controller.svWaitList[index - 1]
                                                  .project.bhk,
                                              style: mediumTextStyle(),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AssetsString.aCoinRupee,
                                              height: 20,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      ColorTheme.cWhite,
                                                      BlendMode.srcIn),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              controller.svWaitList[index - 1]
                                                  .project.price,
                                              style: mediumTextStyle(),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Image.asset(
                                        controller
                                            .svWaitList[index - 1].source.icon,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Container(
                                  color: ColorTheme.cThemeBg,
                                  padding: const EdgeInsets.all(2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        controller.svWaitList[index - 1]
                                            .sourcingManager.image,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        controller.svWaitList[index - 1]
                                            .sourcingManager.name,
                                        style: mediumTextStyle(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        color:
                                            ColorTheme.cWhite.withOpacity(0.2),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Text(
                                          convertDate(controller
                                              .svWaitList[index - 1]
                                              .date
                                              .startDate),
                                          style: mediumTextStyle(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        color:
                                            ColorTheme.cWhite.withOpacity(0.2),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: Text(
                                          convertDate(controller
                                              .svWaitList[index - 1]
                                              .date
                                              .endDate),
                                          style: mediumTextStyle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
