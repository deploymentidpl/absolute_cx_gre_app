import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../config/Helper/function.dart';
import '../../../config/utils/constant.dart';
import '../../../controller/DashboardController/dashboard_controller.dart';
import '../../../model/DataGridModels/source_wise_sv_data_grid.dart';
import '../../../style/assets_string.dart';
import '../../../style/text_style.dart';
import '../../../style/theme_color.dart';
import '../../../widgets/RotatingIconButton/rotating_icon_button.dart';
import '../../../widgets/Shimmer/box_shimmer.dart';

class GetSourceWiseSVCount extends StatefulWidget {
  const GetSourceWiseSVCount({super.key});

  @override
  State<GetSourceWiseSVCount> createState() => _GetSourceWiseSVCountState();
}

class _GetSourceWiseSVCountState extends State<GetSourceWiseSVCount> {
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
                    "Source Wise SV Count",
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
                        controller.sourceWiseSVCountList.value = [];
                        setState(() {});
                      },
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

                    controller.sourceWiseSVCountList.value = [];
                    setState(() {});
                  }
                },
                itemBuilder: controller.getPopupMenuDays,
                child: Container(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    AssetsString.aDotsVertical,
                    height: controller.iconSizeSmall.value,
                    colorFilter:
                        ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ),
              ),
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
                          "${formatDate(controller.sourceWiseSvFromDate.value.toIso8601String(), 4)}-${formatDate(controller.sourceWiseSvToDate.value.toIso8601String(), 4)}",
                          style: semiBoldTextStyle(
                              size: controller.textSmall.value,
                              color: Colors.white),
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
                              controller.sourceWiseSVCountList.value = [];
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
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        AssetsString.aDownload,
                        height: controller.iconSizeSmall.value,
                        colorFilter: ColorFilter.mode(
                            ColorTheme.cWhite, BlendMode.srcIn),
                      ),
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
                return Obx(() => controller.sourceWiseSVCountList.isNotEmpty
                    ? Center(
                      child: SingleChildScrollView(
                          scrollDirection:
                              isWeb ? Axis.vertical : Axis.horizontal,
                          child: SfDataGridTheme(
                            data: SfDataGridThemeData(
                                headerColor: Colors.transparent,
                                sortIconColor: ColorTheme.cWhite),
                            child: SfDataGrid(
                              allowSwiping: false,

                              columnWidthMode: ColumnWidthMode.fitByColumnName,
                              source: SourceWiseSVDataGrid(
                                  dataList: controller.sourceWiseSVCountList),
                              gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                              allowSorting: true,
                              frozenColumnsCount: 0,

                              shrinkWrapRows: true,
                              shrinkWrapColumns: true,
                              verticalScrollPhysics:
                              const NeverScrollableScrollPhysics(),
                              horizontalScrollPhysics:
                              const NeverScrollableScrollPhysics(),
                              columnSizer: CustomColumnSizer(),
                              columns: <GridColumn>[
                                GridColumn(
                                    // width:  (Get.width -20) / 3,
                                    columnName: 'source',
                                    label: Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Source',
                                        style: regularTextStyle(
                                            size: 13,
                                            color: ColorTheme.cWhite),
                                      ),
                                    )),
                                GridColumn(
                                    // width:  (Get.width -20) / 3,
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
                                GridColumn(
                                    // width:   (Get.width -20) / 3,
                                    columnName: 'percentage',
                                    label: Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Percentage',
                                        style: regularTextStyle(
                                            size: 13,
                                            color: ColorTheme.cWhite),
                                      ),
                                    )),
                              ],
                            ),
                          )),
                    )
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
            future: controller.getSourceWiseSVCountList(),
          ),
        ],
      ),
    );
  }
}
