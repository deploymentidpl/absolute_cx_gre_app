import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/common_api.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/model/OwnerDataModel/owner_data_model.dart';
import 'package:greapp/model/SiteVisitCountModel/site_visit_count.dart';
import 'package:greapp/model/SiteVisitSourceWiseCountModel/sitevisit_sourecwise_count_model.dart';
import 'package:greapp/style/assets_string.dart';
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
import '../../widgets/custom_dialogs.dart';
import '../HomeController/home_controller.dart';

class DashboardController extends GetxController {
  RxInt svCount = 0.obs;

  GlobalKey<SfCartesianChartState> overAllSvPerHourChartKey = GlobalKey();

  RxList<SVCountsModel> svList = RxList([]);
  RxList<OwnerDataListModel> ownerDataList = RxList([]);
  RxList<SourceWiseSVCountModel> sourceWiseSVCountList = RxList([]);
  RxList<SiteVisitSourceWiseCountModel> arrDashBoardCountLead = RxList<SiteVisitSourceWiseCountModel>([]);
  RxList<SiteVisitCountModel> arrSiteVisitCount =
  RxList<SiteVisitCountModel>([]);
  SiteVisitSourceCount? siteVisitSourceCount;

  // RxList<SVWaitListModel> svWaitList = RxList([]);
  RxBool showOverAllSVChart = true.obs;
  RxBool showSVWaitListChart = true.obs;

  // RxBool assignedSV = true.obs;
  late Rx<SizingInformation> sizingInformation;
  final HomeController homeController = HomeController();

  DashboardController() {
    retrieveSiteVisitCount();
    getSVList();
    getOwnerDataList();
    getSourceWiseSVCountList();
  }

  Future<void> retrieveSiteVisitCount() async {
    String fromDate = '';
    String toDate = '';

    var data = {
    // "fromdate": "2024-08-09",
    // "todate": "2024-08-15",
    "project_code": "102",
    "gre_emp_id": "090909"
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

        arrDashBoardCountLead.value =
            List.from(result.map((e) => SiteVisitSourceWiseCountModel.fromJson(e)));

        arrDashBoardCountLead.refresh();
        siteVisitSourceCount = SiteVisitSourceCount(dataList: arrDashBoardCountLead);
      }
    } catch (e, x) {
      devPrint('log e-----$e-----------$x');
    }

    return arrDashBoardCountLead;
  }


  Future<bool> getSVList() async {
    try {
      svList.clear();
      Map<String, dynamic> data = {};

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.siteVisitPerHourCount,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData =
          await response.getResponse() ?? {"message": "Cannot Fetch Details"};
      log(responseData.toString());
      log(PreferenceController.getString(
        SharedPref.loginToken,
      ));
      if (responseData['success'] == true) {
        svList.value = SVCountsBaseModel.fromJson(responseData).data;
      } else {
        showError(
          responseData['message'],
        );
        return false;
      }
      return true;
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }

  void getOwnerDataList() {
    ownerDataList.addAll(OwnerDataBaseModel.fromJson({
      "success": true,
      "message": "Data found",
      "data": [
        {
          "ownerdata": [
            {"id": "8000000057", "name": "Rohit Singh"},
            {"id": "8000000232", "name": "Cluster Head"},
            {"id": "8000000098", "name": "Ajay Sharma"},
            {"id": "8000000105", "name": "Vishnu Jain"},
            {"id": "8000000053", "name": "Shekhar Singh"},
            {"id": "8000000085", "name": "A Abhinav"},
            {"id": "8000000082", "name": "Amit Dhoot"},
            {"id": "8000000102", "name": "Aditi Sharma"},
            {"id": "8000000091", "name": "test678 test"},
            {"id": "8000000056", "name": "madhu Rao"},
            {"id": "8000000108", "name": "Varun Sharma"},
            {"id": "8000000094", "name": "Shruti Jain"},
            {"id": "8000001397", "name": "Babu Vigneshwar J"},
            {"id": "8000009550", "name": "GURU PRASAD"},
            {"id": "8000009700", "name": "Haseena M"},
            {"id": "8000000553", "name": "Srinivasa Rao"},
            {"id": "8000000550", "name": "Ramu Gajula"},
            {"id": "8000000560", "name": "Shekina Victor S"},
            {"id": "8000000989", "name": "A Saravanan"},
            {"id": "8000001149", "name": "Dinesh G"},
            {"id": "8000001206", "name": "Ajit Kumar Sahoo"},
            {"id": "8000001226", "name": "Ajay Gope"},
            {"id": "8000001335", "name": "Srinivas H G"},
            {"id": "8000001473", "name": "Bhallal Dev"},
            {"id": "80003000560", "name": "Ravi Kumar T"},
            {"id": "REC789878", "name": "RECEPTIONIST DEV"}
          ],
          "count": [
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            5,
            11,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
          ]
        }
      ]
    }).data);
  }

  Future<bool> getSourceWiseSVCountList() async {
    try {
      sourceWiseSVCountList.clear();
      Map<String, dynamic> data = {};

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.sourceWiseSVCount,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData =
          await response.getResponse() ?? {"message": "Cannot Fetch Details"};
      log(responseData.toString());
      log(PreferenceController.getString(
        SharedPref.loginToken,
      ));
      if (responseData['success'] == true) {
        sourceWiseSVCountList.value =
            SourceWiseSVCountBaseModel.fromJson(responseData).data;
        List<int> count = [];
        for (int i = 0; i < sourceWiseSVCountList.length; i++) {
          count.add(sourceWiseSVCountList[i].count);
        }
        List<String> percentage = FunctionHelper.convertToPercentage(count);

        for (int i = 0; i < sourceWiseSVCountList.length; i++) {
          sourceWiseSVCountList[i].percentage = percentage[i];
        }
      } else {
        showError(
          responseData['message'],
        );
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