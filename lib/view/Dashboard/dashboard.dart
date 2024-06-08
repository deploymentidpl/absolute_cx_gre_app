import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/controller/DashboardController/dashboard_controller.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:greapp/widgets/web_tabbar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/ChartDataModel/chart_data_model.dart';
import '../../widgets/web_header.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return webDesign();
      },
    );
  }

  Widget webDesign() {
    return Scaffold(
      backgroundColor: ColorTheme.cThemeBg,
      body: Column(
        children: [
          const WebHeader(),
          const WebTabBar(),
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
                    getSourceWiseCount()
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
      padding: EdgeInsets.all(20),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   color: Colors.transparent,
                  //   padding: const EdgeInsets.all(5),
                  //   child: SvgPicture.asset(
                  //     AssetsString.aUser,
                  //     height: 25,
                  //     colorFilter: const ColorFilter.mode(
                  //         ColorTheme.cWhite, BlendMode.srcIn),
                  //   ),
                  // ),
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
            padding: const EdgeInsets.all(45),
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
                    height: 30,
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
                      style: semiBoldTextStyle(size: 45),
                    ),
                    Text(
                      "SITE VISIT",
                      style: mediumTextStyle(size: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 180,
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
              Container(
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
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 250),
            height: 730,
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
                majorGridLines: MajorGridLines(color: ColorTheme.cLineColor),
                interval: 3,
              ),
              primaryXAxis: CategoryAxis(
                borderColor: Colors.transparent,
                axisLine: AxisLine(
                  color: ColorTheme.cLineColor,
                ),
                majorTickLines: MajorTickLines(color: ColorTheme.cLineColor),
                majorGridLines:
                    const MajorGridLines(color: Colors.transparent, width: 0),
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
                      labelAlignment: ChartDataLabelAlignment.middle),
                  color: ColorTheme.cAppTheme,
                  xValueMapper: (datum, index) => datum.time,
                  yValueMapper: (SVChartDataModel datum, index) => datum.count,
                  dataSource: List.generate(
                      controller.svList.first.lable.length,
                      (index) => SVChartDataModel(
                          controller.svList.first.lable[index],
                          controller.svList.first.count[index].toDouble())),
                )
              ],
            ),
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
              Container(
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
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            height: 730,
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
                  yValueMapper: (SVChartDataModel datum, index) => datum.count,
                  dataSource: List.generate(
                      controller.ownerDataList.first.ownerData.length,
                      (index) => SVChartDataModel(
                          controller.ownerDataList.first.ownerData[index].name,
                          controller.ownerDataList.first.count[index]
                              .toDouble())),
                )
              ],
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
              Container(
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
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Table(
            children: List.generate(controller.sourceWiseSVCountList.length + 1,
                (index) {
              return index == 0
                  ? TableRow(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorTheme.cLineColor)),
                      children: [
                          Text(
                            "Source",
                            style: semiBoldTextStyle(),
                          ),
                          Text(
                            "Count",
                            style: semiBoldTextStyle(),
                          ),
                          Text(
                            "Percentage",
                            style: semiBoldTextStyle(),
                          ),
                        ])
                  : TableRow(children: [
                      Text(
                        controller.sourceWiseSVCountList[index - 1].source,
                        style: semiBoldTextStyle(),
                      ),
                      Text(
                        controller.sourceWiseSVCountList[index - 1].count
                            .toString(),
                        style: semiBoldTextStyle(),
                      ),
                      Text(
                        controller.sourceWiseSVCountList[index - 1].percentage
                            .toString(),
                        style: semiBoldTextStyle(),
                      ),
                    ]);
            }),
          )
        ],
      ),
    );
  }
}
