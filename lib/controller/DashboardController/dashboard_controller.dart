import 'dart:async';
import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/main.dart';
import 'package:greapp/model/EventModel/project_event_model.dart';

import 'package:greapp/style/theme_color.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/Helper/api_response.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/preference_controller.dart';
import '../../model/SVCountsModel/sv_counts_model.dart';
import '../../model/SVWaitListModel/sv_wait_list_model.dart';
import '../../model/SourceWiseSVCountModel/source_wise_sv_count_model.dart';
import '../../style/text_style.dart';
import '../HomeController/home_controller.dart';

class DashboardController extends GetxController {

  ///spacings
  Rx<double> space20 = (20.0).obs;
  Rx<double> space25 = (25.0).obs;



  ///summary
  RxInt svCount = 0.obs;
  RxBool isSVCountLoading = true.obs;
  Rx<DateTime> svCountFromDate = DateTime.now().obs;
  Rx<DateTime> svCountToDate = DateTime.now().obs;


  ///overall sv per hour
  RxBool showOverAllSVChart = true.obs;
  RxList<SVCountsModel> svPerHourList = RxList([]);
  Rx<DateTime> svPerHourFromDate = DateTime.now().obs;
  Rx<DateTime> svPerHourToDate = DateTime.now().obs;

  ///sv waiting
  RxBool showSVWaitListChart = true.obs;
  RxList<SVWaitListModel> svWaitlist = RxList([]);
  Rx<DateTime> svWaitingFromDate = DateTime.now().obs;
  Rx<DateTime> svWaitingToDate = DateTime.now().obs;

  ///Source WIse SV Count
  RxList<SourceWiseDataModel> sourceWiseSVCountList = RxList([]);
  Rx<DateTime> sourceWiseSvFromDate = DateTime.now().obs;
  Rx<DateTime> sourceWiseSvToDate = DateTime.now().obs;

  late Rx<SizingInformation> sizingInformation;

  /// for web view
  final HomeController homeController = HomeController();

  ///eventbus subscription
  StreamSubscription? streamSubscription;

  DashboardController() { apiCalls();
    streamSubscription = eventBus.on<ProjectEvent>().listen((event) {
      if (event.isProjectAvailable) {
        apiCalls();
      }
    });
  }

  Future<void> apiCalls() async{
   await  retrieveSiteVisitCount();
   await getSVPerHourList();
   await  getSVWaitList();
   await getSourceWiseSVCountList();
  }

  List<PopupMenuEntry<DateRangeSelection>> getPopupMenuDays(
      BuildContext context) {
    return [
      PopupMenuItem(
          enabled: false,
          child: Text(
            "Select Date Range",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.today,
          child: Text(
            "Today",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.yesterday,
          child: Text(
            "Yesterday",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.thisWeek,
          child: Text(
            "This Week",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.last7Days,
          child: Text(
            "Last 7 Days",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.lastWeek,
          child: Text(
            "Last Week",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.thisMonth,
          child: Text(
            "This Month",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.last28Days,
          child: Text(
            "Last 28 Days",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.lastMonth,
          child: Text(
            "Last Month",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.thisYear,
          child: Text(
            "This Year",
            style: mediumTextStyle(),
          )),
      PopupMenuItem(
          value: DateRangeSelection.custom,
          child: Text(
            "Custom",
            style: mediumTextStyle(),
          )),
    ];
  }

  Future<bool> retrieveSiteVisitCount() async {

    try {
      svCount.value = 0;
      isSVCountLoading.value = true;
      var data = {
      "fromdate": getAPIFormattedDate(date: svCountFromDate.value),
      "todate": getAPIFormattedDate(date: svCountToDate.value),
      "project_code": kSelectedProject.value.projectCode,
      "gre_emp_id": PreferenceController.getString(SharedPref.employeeID)
    };

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.siteVisitCount,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();

      if (responseData!['success'] == true) {
        var count = responseData['data'][0]['svcount'];

        svCount.value = count;

        isSVCountLoading.value = false;
        return true;
      }else{

        isSVCountLoading.value = false;
        return false;
      }
    } catch (e, x) {
      isSVCountLoading.value = false;
      devPrint('log e-----$e-----------$x');
      return false;
    }
  }

  Future<bool> getSVPerHourList() async {
    try {
      svPerHourList.clear();
      Map<String, dynamic> data = {
        "formdate": getAPIFormattedDate(date: svPerHourFromDate.value),
        "todate": getAPIFormattedDate(date: svPerHourToDate.value),
        "ProjectCode": [kSelectedProject.value.projectCode],
        "employee_id": [PreferenceController.getString(SharedPref.employeeID)]
      };

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.siteVisitPerHourCount,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData = await response.getResponse() ?? {};

      if (responseData['success'] == true) {
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
      Map<String, dynamic> responseData = await response.getResponse() ?? {};

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
        "project_code": [kSelectedProject.value.projectCode],
        "gre_emp_id": [PreferenceController.getString(SharedPref.employeeID)]
      };

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.sourceWiseSVCount,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData = await response.getResponse() ?? {};

      if (responseData['success'] == true) {
        sourceWiseSVCountList.value =
            SourceWiseDataBaseModel.fromJson(responseData).data;
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
