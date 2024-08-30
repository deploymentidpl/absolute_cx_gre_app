import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config/Helper/function.dart';
import '../../../config/utils/constant.dart';
import '../../../controller/DashboardController/dashboard_controller.dart';
import '../../../model/ChartDataModel/chart_data_model.dart';
import '../../../style/assets_string.dart';
import '../../../style/text_style.dart';
import '../../../style/theme_color.dart';
import '../../../widgets/RotatingIconButton/rotating_icon_button.dart';
import '../../../widgets/Shimmer/box_shimmer.dart';

class GetWaitingSvChart extends StatefulWidget {
  const GetWaitingSvChart({super.key});

  @override
  State<GetWaitingSvChart> createState() => _GetWaitingSvChartState();
}

class _GetWaitingSvChartState extends State<GetWaitingSvChart> {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme.cThemeCard,
      padding: EdgeInsets.all(controller.spaceMedium.value),
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
                    style: semiBoldTextStyle(size: controller.textLarge.value),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: RotatingIconButton(
                      iconSize: controller.iconSizeSmall.value,
                      onPressed: () async {
                        controller.svWaitlist.value = [];
                        setState(() {});
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
                                  height: controller.iconSizeSmall.value,
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
                                  height: controller.iconSizeSmall.value,
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

                        controller.svWaitlist.value = [];
                        setState(() {});
                      }
                    },
                    itemBuilder: controller.getPopupMenuDays,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        AssetsString.aDotsVertical,
                        height: controller.iconSizeLarge.value,
                        colorFilter:   ColorFilter.mode(
                            ColorTheme.cWhite, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: controller.spaceSmall.value,
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
                          style: semiBoldTextStyle(
                              size: controller.textSmall.value),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (!(checkIfToday(
                                controller.svWaitingFromDate.value) &&
                            checkIfToday(controller.svWaitingToDate.value)))
                          GestureDetector(
                            onTap: () {
                              controller.svWaitingFromDate.value =
                                  DateTime.now();
                              controller.svWaitingToDate.value = DateTime.now();

                              controller.svWaitlist.value = [];
                              setState(() {});
                            },
                            child: Container(
                                color: Colors.transparent,
                                child: Icon(
                                  Icons.close,
                                  size: controller.iconSizeSmall.value,
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
                                height: controller.iconSizeSmall.value,
                                colorFilter:   ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Download",
                            style: semiBoldTextStyle(
                                size: controller.textSmall.value),
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
                                  height: controller.iconSizeSmall.value,
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
                                  height: controller.iconSizeSmall.value,
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
                              height: controller.iconSizeSmall.value,
                              colorFilter:   ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          SizedBox(
            height: controller.spaceMedium.value,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Obx(() => controller.svWaitlist.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection:
                            isWeb ? Axis.vertical : Axis.horizontal,
                        child: controller.showSVWaitListChart.value
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isWeb ? 250 : 0),
                                height: isWeb ? 730 : 300,
                                width: isWeb ? null : 1200,
                                child: SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  onTooltipRender: (tooltipArgs) {},
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
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    borderColor: Colors.transparent,
                                    axisLine:
                                        AxisLine(color: ColorTheme.cLineColor),
                                    labelRotation: 45,
                                    majorTickLines: MajorTickLines(
                                        color: ColorTheme.cLineColor),
                                    majorGridLines: const MajorGridLines(
                                        color: Colors.transparent, width: 0),
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
                                              alignment: ChartAlignment.center,
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
                                          controller.svWaitlist.first
                                              .svownerdata.length,
                                          (index) => SVChartDataModel(
                                              controller.svWaitlist.first
                                                  .svownerdata[index].name,
                                              controller
                                                  .svWaitlist.first.count[index]
                                                  .toDouble())),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(
                                width: controller.sizingInformation.value
                                        .screenSize.width -
                                    80,
                                child: Table(
                                  children: List.generate(
                                      controller.svWaitlist.first.svownerdata
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
                                                          top: 10, bottom: 5),
                                                  child: Text(
                                                    "Time".toUpperCase(),
                                                    style: semiBoldTextStyle(
                                                        size: controller
                                                            .textLarge.value),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, bottom: 5),
                                                  child: Text(
                                                    "Count".toUpperCase(),
                                                    style: semiBoldTextStyle(
                                                        size: controller
                                                            .textLarge.value),
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
                                                  padding: EdgeInsets.only(
                                                      top: controller
                                                          .space20.value,
                                                      bottom: 10),
                                                  child: Text(
                                                    controller
                                                        .svWaitlist
                                                        .first
                                                        .svownerdata[index - 1]
                                                        .name,
                                                    style: mediumTextStyle(
                                                        size: controller
                                                            .textMedium.value),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: controller
                                                          .space20.value,
                                                      bottom: 10),
                                                  child: Text(
                                                    controller.svWaitlist.first
                                                        .count[index - 1]
                                                        .toString(),
                                                    style: mediumTextStyle(
                                                        size: controller
                                                            .textMedium.value),
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
                return BoxShimmer(
                  height: 300,
                  width: Get.width,
                );
              }
            },
            future: controller.getSVWaitList(),
          ),
        ],
      ),
    );
  }
}
