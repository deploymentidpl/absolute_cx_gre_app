import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../config/Helper/function.dart';
import '../../../config/utils/constant.dart';
import '../../../controller/DashboardController/dashboard_controller.dart';
import '../../../model/ChartDataModel/chart_data_model.dart';
import '../../../model/DataGridModels/overall_sv_per_hour_data_grid.dart';
import '../../../style/assets_string.dart';
import '../../../style/text_style.dart';
import '../../../style/theme_color.dart';
import '../../../widgets/CustomLeadSidebar/custom_lead_sidebar.dart';
import '../../../widgets/RotatingIconButton/rotating_icon_button.dart';
import '../../../widgets/Shimmer/box_shimmer.dart';
import '../../../widgets/SideBarMenuWidget/sidebar_menu_widget.dart';
import '../../../widgets/app_loader.dart';

class GetOverallSvChart extends StatefulWidget {
  const GetOverallSvChart({super.key});

  @override
  State<GetOverallSvChart> createState() => _GetOverallSvChartState();
}

class _GetOverallSvChartState extends State<GetOverallSvChart> {
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
                    "Overall SV per Hour",
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
                        controller.svPerHourList.value = [];
                        setState(() {});
                      },
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
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(5),
                              child: Obx(() => SvgPicture.asset(
                                    AssetsString.aChartBar,
                                    height: controller.iconSizeSmall.value,
                                    colorFilter: ColorFilter.mode(
                                        controller.showOverAllSVChart.value
                                            ? ColorTheme.cAppTheme
                                            : ColorTheme.cWhite,
                                        BlendMode.srcIn),
                                  )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showOverAllSVChart.value = false;
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(5),
                              child: Obx(() => SvgPicture.asset(
                                    AssetsString.aTable,
                                    height: controller.iconSizeSmall.value,
                                    colorFilter: ColorFilter.mode(
                                        controller.showOverAllSVChart.value
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cAppTheme,
                                        BlendMode.srcIn),
                                  )),
                            ),
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

                        controller.svPerHourList.value = [];
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
                        colorFilter: ColorFilter.mode(
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
                          "${formatDate(controller.svPerHourFromDate.value.toIso8601String(), 4)}-${formatDate(controller.svPerHourToDate.value.toIso8601String(), 4)}",
                          style: semiBoldTextStyle(
                            size: controller.textSmall.value,
                            color: Colors.white,
                          ),
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

                              controller.svPerHourList.value = [];
                              setState(() {});
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  color: Colors.transparent,
                                  child: Icon(
                                    Icons.close,
                                    size: controller.iconSizeSmall.value,
                                    color: Colors.white,
                                  )),
                            ),
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
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Download",
                            style: semiBoldTextStyle(
                              size: controller.textSmall.value,
                              color: Colors.white,
                            ),
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
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(5),
                              child: Obx(() => SvgPicture.asset(
                                    AssetsString.aChartBar,
                                    height: controller.iconSizeSmall.value,
                                    colorFilter: ColorFilter.mode(
                                        controller.showOverAllSVChart.value
                                            ? ColorTheme.cAppTheme
                                            : ColorTheme.cWhite,
                                        BlendMode.srcIn),
                                  )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showOverAllSVChart.value = false;
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(5),
                              child: Obx(() => SvgPicture.asset(
                                    AssetsString.aTable,
                                    height: controller.iconSizeSmall.value,
                                    colorFilter: ColorFilter.mode(
                                        controller.showOverAllSVChart.value
                                            ? ColorTheme.cWhite
                                            : ColorTheme.cAppTheme,
                                        BlendMode.srcIn),
                                  )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                AssetsString.aDownload,
                                height: controller.iconSizeSmall.value,
                                colorFilter: ColorFilter.mode(
                                    ColorTheme.cWhite, BlendMode.srcIn),
                              ),
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
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (controller.svPerHourList.isNotEmpty) {
                    return Obx(
                      () => controller.svPerHourList.isNotEmpty
                          ? controller.showOverAllSVChart.value
                              ? SizedBox(
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: isWeb ? 250 : 0),
                                  height: isWeb ? 530 : 300,
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
                                        onPointTap:
                                            (pointInteractionDetails) {
                                          CartesianChartPoint point =
                                              pointInteractionDetails
                                                      .dataPoints?[
                                                  pointInteractionDetails
                                                          .pointIndex ??
                                                      0];

                                          appLoader(context);
                                          controller
                                              .getSVPerHourClick(
                                                  label: point.x)
                                              .whenComplete(
                                            () {
                                              removeAppLoader(context);
                                              if (controller
                                                  .commonLeads.isNotEmpty) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return SideBarMenuWidget(
                                                        //show sidebar for 1000 or more screen size
                                                        width: Get.width *
                                                                    0.8 >=
                                                                1000
                                                            ? Get.width * 0.8
                                                            : 1000,
                                                        sideBarWidget:
                                                            CustomLeadSidebar(
                                                                leadsList:
                                                                    controller
                                                                        .commonLeads));
                                                  },
                                                );
                                              }
                                            },
                                          );
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
                                      60,
                                  child:   Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Center(
                                        child: SfDataGridTheme(
                                          data: SfDataGridThemeData(
                                              headerColor: Colors.transparent,
                                              sortIconColor: ColorTheme.cWhite),
                                          child: SfDataGrid(
                                            allowSwiping: false,
                                footerFrozenRowsCount: 1,
                                            columnWidthMode: ColumnWidthMode.auto,
                                            source: OverAllSvPerHourDataGrid(
                                                dataList: controller.svPerHourList),
                                            gridLinesVisibility: GridLinesVisibility.both,
                                            headerGridLinesVisibility:
                                            GridLinesVisibility.both,
                                            allowSorting: true,
                                            frozenColumnsCount: 0,
                                            shrinkWrapRows: true,
                                            shrinkWrapColumns: true,
                                           horizontalScrollPhysics:
                                            const NeverScrollableScrollPhysics(),
                                            columnSizer: CustomColumnSizer(),
                                            columns: <GridColumn>[
                                              GridColumn(
                                                  width:  (Get.width -20) / 4,
                                                  columnName: 'time',
                                                  label: Container(
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Time',
                                                      style: regularTextStyle(
                                                          size: 13,
                                                          color: ColorTheme.cWhite),
                                                    ),
                                                  )),
                                              GridColumn(
                                                  width:  (Get.width -20) / 4,
                                                  columnName: 'count',
                                                  label: Container(
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Count',
                                                      style: regularTextStyle(
                                                          size: 13,
                                                          color: ColorTheme.cWhite),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ) /*Table(
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
                                                    padding: EdgeInsets.only(
                                                        top: controller
                                                            .space20.value,
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
                                                    padding: EdgeInsets.only(
                                                        top: controller
                                                            .space20.value,
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
                                  )*/,
                                )
                          : Center(
                              child: Text(
                              "Loading",
                              style: mediumTextStyle(),
                            )),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Data",
                        style: mediumTextStyle(),
                      ),
                    );
                  }
                } else {
                  return BoxShimmer(
                    height: 300,
                    width: Get.width,
                  );
                }
              },
              future: controller.getSVPerHourList(),
            ),
          ),
        ],
      ),
    );
  }
}
