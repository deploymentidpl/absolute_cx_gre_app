import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/Helper/function.dart';
import '../../../config/utils/constant.dart';
import '../../../controller/DashboardController/dashboard_controller.dart';
import '../../../style/assets_string.dart';
import '../../../style/text_style.dart';
import '../../../style/theme_color.dart';
import '../../../widgets/RotatingIconButton/rotating_icon_button.dart';
import '../../../widgets/Shimmer/box_shimmer.dart';
import '../../../widgets/common_bottomsheet.dart';
import 'custome_date_selection.dart';

class GetSumaryCount extends StatefulWidget {
  const GetSumaryCount({super.key});

  @override
  State<GetSumaryCount> createState() => _GetSumaryCountState();
}

class _GetSumaryCountState extends State<GetSumaryCount> {
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Summary",
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
                  } else {
                    commonDialog(
                      child: customDateSelection(
                          fromDate: controller.svCountFromDate,
                          toDate: controller.svCountToDate),
                      onTapBottomButton: () {},
                      mainHeadingText: "Custom Date Filter",
                    );
                  }
                },
                itemBuilder: controller.getPopupMenuDays,
                child: Container(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    AssetsString.aDotsVertical,
                    height: controller.iconSizeLarge.value,
                    colorFilter:   ColorFilter.mode(
                        ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: controller.spaceSmall.value,
          ),
          Container(
            color: ColorTheme.cAppTheme,
            padding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
            child: Obx(() =>
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${formatDate(
                          controller.svCountFromDate.value.toIso8601String(),
                          4)}-${formatDate(
                          controller.svCountToDate.value.toIso8601String(),
                          4)}",
                      style:
                      semiBoldTextStyle(size: controller.textSmall.value,color: Colors.white,),
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
          SizedBox(
            height: controller.spaceMedium.value,
          ),
          Container(
            color: ColorTheme.cThemeBg,
            padding: EdgeInsets.all(controller.spaceMedium.value),
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
                    height: controller.iconSizeLarge.value,
                  ),
                ),
                SizedBox(
                  width: controller.spaceMedium.value,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    FutureBuilder(future: controller.retrieveSiteVisitCount(),
                      builder: (context, snapshot) =>   Obx(
                            () =>
                        controller.isSVCountLoading.value
                            ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: BoxShimmer(
                            height: isWeb ? 45 : 30,
                            width: isWeb ? 45 : 30,
                          ),
                        )
                            : Text(
                          controller.svCount.value.toString(),
                          style: semiBoldTextStyle(size: isWeb ? 45 : 30),
                        ),
                      ),),
                    Text(
                      "SITE VISIT",
                      style: mediumTextStyle(size: controller.textSmall.value),
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
}
