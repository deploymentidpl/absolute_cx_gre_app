import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/common_api.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/main.dart';
import 'package:greapp/model/SiteVisitCountModel/site_visit_count.dart';
import 'package:greapp/model/SiteVisitSourceWiseCountModel/sitevisit_sourecwise_count_model.dart';

import 'package:greapp/style/theme_color.dart';
import 'package:greapp/view/Dashboard/dashboard.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../config/Helper/api_response.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/preference_controller.dart';
import '../../model/SVCountsModel/sv_counts_model.dart';
import '../../model/SVWaitListModel/sv_wait_list_model.dart';
import '../../model/SourceWiseSVCountModel/source_wise_sv_count_model.dart';
import '../../style/text_style.dart';
import '../../widgets/custom_dialogs.dart';
import '../HomeController/home_controller.dart';

class DashboardController extends GetxController {
  ///summary
  RxInt svCount = 0.obs;

  ///overall sv per hour
  RxList<SVCountsModel> svPerHourList = RxList([]);


  ///sv waiting
  RxBool showSVWaitListChart = true.obs;
  RxList<SVWaitListModel> svWaitlist = RxList([]);
  Rx<DateTime> svWaitingFromDate = DateTime.now().obs;
  Rx<DateTime> svWaitingToDate = DateTime.now().obs;

  ///Source WIse SV Count
  RxList<SourceWiseDataModel> sourceWiseSVCountList = RxList([]);
  Rx<DateTime> sourceWiseSvFromDate = DateTime.now().obs;
  Rx<DateTime>  sourceWiseSvToDate = DateTime.now().obs;

  // GlobalKey<SfCartesianChartState> overAllSvPerHourChartKey = GlobalKey();

  RxList<SiteVisitSourceWiseCountModel> arrDashBoardCountLead =
      RxList<SiteVisitSourceWiseCountModel>([]);
  RxList<SiteVisitCountModel> arrSiteVisitCount =
      RxList<SiteVisitCountModel>([]);
  SiteVisitSourceCount? siteVisitSourceCount;

  // RxList<SVWaitListModel> svWaitList = RxList([]);
  RxBool showOverAllSVChart = true.obs;

  // RxBool assignedSV = true.obs;
  late Rx<SizingInformation> sizingInformation;
  final HomeController homeController = HomeController();

  DashboardController() {
    retrieveSiteVisitCount();
    getSVList();
    getSVWaitList();
    getSourceWiseSVCountList();
  }

  List<PopupMenuEntry<DateRangeSelection>> getPopupMenuDays(BuildContext context) {
    return [
      PopupMenuItem(
          enabled: false,
          child: Text("Select Date Range",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.today,
          child: Text("Today",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.yesterday,
          child: Text("Yesterday",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.thisWeek,
          child: Text("This Week",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.last7Days,
          child: Text("Last 7 Days",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.lastWeek,
          child: Text("Last Week",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.thisMonth,
          child: Text("This Month",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.last28Days,
          child: Text("Last 28 Days",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.lastMonth,
          child: Text("Last Month",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.thisYear,
          child: Text("This Year",style: mediumTextStyle(),)),
      PopupMenuItem(
          value: DateRangeSelection.custom,
          child: Text("Custom",style: mediumTextStyle(),)),
    ];
  }

  Future<void> retrieveSiteVisitCount() async {
    String fromDate = '';
    String toDate = '';

    var data = {
      // "fromdate": "2024-08-09",
      // "todate": "2024-08-15",
      "project_code": kSelectedProject.value.projectCode,
      "gre_emp_id":
      PreferenceController.getString(SharedPref.employeeID)
    };

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.siteVisitCount,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    try {
      if (responseData!['success'] == true) {
        var count = responseData['data'][0]['svcount'];

        svCount.value = count;
      }
    } catch (e, x) {
      devPrint('log e-----$e-----------$x');
    }
  }

  Future<RxList<SiteVisitSourceWiseCountModel>> retrieveDashBoardSvCountLead(
      [int isRefresh = 0]) async {
    var data = {
      "fromdate": "2024-08-01",
      "todate": "2024-08-31",
      "project_code": ["101"]
    };

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.siteVisitSourceCount,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    try {
      if (responseData!['success'] == true) {
        List result = responseData['data'];

        arrDashBoardCountLead.value = List.from(
            result.map((e) => SiteVisitSourceWiseCountModel.fromJson(e)));

        arrDashBoardCountLead.refresh();
        siteVisitSourceCount =
            SiteVisitSourceCount(dataList: arrDashBoardCountLead);
      }
    } catch (e, x) {
      devPrint('log e-----$e-----------$x');
    }

    return arrDashBoardCountLead;
  }

  Future<bool> getSVList() async {
    try {
      svPerHourList.clear();
      Map<String, dynamic> data = {
        "formdate":"2024-08-14",
        "todate":"2024-08-14", "ProjectCode":[kSelectedProject.value.projectCode],
        "employee_id":  [
          PreferenceController.getString(SharedPref.employeeID)
        ]

      };

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.siteVisitPerHourCount,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData =
          await response.getResponse() ?? { };
      log("responseData.toString()--getSVList--${data}-----${responseData}");
      log(responseData.toString());
      log(PreferenceController.getString(
        SharedPref.loginToken,
      ));
      if (responseData['success'] == true) {
        //todo: check
        svPerHourList.value = SVCountsBaseModel.fromJson(responseData).data;
      } else {
        return false;
      }
      return true;
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }

  Future<bool> getSVWaitList() async {
    try {
      svWaitlist.clear();
      Map<String, dynamic> data = {
        "project_code": kSelectedProject.value.projectCode,
        "fromdate": formatDate(svWaitingFromDate.value.toIso8601String(), 3),
        "todate": formatDate(svWaitingToDate.value.toIso8601String(), 3)
      };

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.sVWaitListCount,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData =
          await response.getResponse() ?? { };

      log(responseData.toString());
      log(PreferenceController.getString(
        SharedPref.loginToken,
      ));
      if (responseData['success'] == true) {
        svWaitlist.value = SVWaitListBaseModel.fromJson(responseData).data;
      } else {
        return false;
      }
      return true;
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }

  Future<bool> getSourceWiseSVCountList() async {
    try {
      sourceWiseSVCountList.clear();
      Map<String, dynamic> data = {
        "from_date": getAPIFormattedDate(date: sourceWiseSvFromDate.value),
        "to_date": getAPIFormattedDate(date: sourceWiseSvToDate.value),
        "project_code":[kSelectedProject.value.projectCode],
        "gre_emp_id": [
         PreferenceController.getString(SharedPref.employeeID)
        ]
      };

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.sourceWiseSVCount,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData =
          await response.getResponse() ?? { };
      log(data.toString());
      log(responseData.toString());
      log(PreferenceController.getString(
        SharedPref.loginToken,
      ));
      if (responseData['success'] == true) {
        sourceWiseSVCountList.value =
            SourceWiseDataBaseModel.fromJson(responseData).data;
        print("sourceWiseSVCountList.length");
        print(sourceWiseSVCountList.length);
      } else {
        return false;
      }
      return true;
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }

  Color getRandomColor() {
    List<Color> colors = [
      ColorTheme.cLeadScore,
      ColorTheme.cBrown,
      ColorTheme.cDeepRed
    ];

    final random = m.Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }
}
