import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/api_response.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/controller/CommonController/common_controller.dart';
import 'package:greapp/model/CheckInSummaryModel/check_in_summary_model.dart';
import 'package:greapp/model/EventModel/project_event_model.dart';
import 'package:greapp/model/ProjectListModel/project_list_model.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/utils/api_constant.dart';
import '../../main.dart';

class WebHeaderController extends GetxController {
  RxBool isDarkTheme = false.obs;
  RxBool isSearch = false.obs;
  Rx<TextEditingController> txtSearch = TextEditingController().obs;
  FocusNode searchFocus = FocusNode();
  RxList<ProjectModel> projectsList = RxList([]);
  Rx<ProjectModel> selectedProject = ProjectModel().obs;
  RxList<String> availableList = RxList([]);
  RxList<CheckInSummaryModel> checkInHistory = RxList([]);
  RxString selectedAvailability = "".obs;
  RxInt notificationCount = 10.obs;

  // String time = "2024-06-20T11:58:07.457Z";
  Rx<Position>? currPosition;

  Rx<Duration> time = const Duration().obs;
  ScrollController scrollController = ScrollController();
  final TextEditingController txtSearchProject = TextEditingController();
  RxList<ProjectModel> searchList = RxList([]);

  WebHeaderController() {
    isDarkTheme.value = PreferenceController.getBool(SharedPref.isDark);

    getProjects();
  }

  Future<bool> getCheckInHistory() async {
    checkInHistory.clear();
    try {
      Map<String, dynamic> response = await ApiResponse(
                  data: {
                "employee_id":
                    PreferenceController.getString(SharedPref.employeeID),
                "date": DateFormat("yyyy-MM-dd").format(DateTime.now())
              },
                  isFormData: false,
                  apiHeaderType: ApiHeaderType.content,
                  baseUrl: Api.apiCheckInHistory)
              .getResponse(printAPI: true) ??
          {};
      if (response.isNotEmpty) {
        checkInHistory.addAll(CheckInSummaryBaseModel.fromJson(response).data);

        return true;
      } else {
        return false;
      }
    } catch (error) {
      log("error-----$error");
      return false;
    }
  }

  String getTime() {
    time.value =
        Duration(seconds: double.parse(checkInHistory[0].totalseconds).toInt());
    return "${(time.value.inHours).toString().padLeft(2, "0")}:${(time.value.inMinutes % 60).toString().padLeft(2, "0")} Hr";
  }

  Future<void> getProjects() async {
    Permission.location.request().then((value) async {
      if (value.isGranted) {
        currPosition = (await CommonController().getCurrentLocation()).obs;
      }
      //todo add lat-lng
      try {
        Map<String, dynamic> response = await ApiResponse(
                    data: {'employee_id': PreferenceController.getString(SharedPref.employeeID)},
                    isFormData: false,
                    apiHeaderType: ApiHeaderType.content,
                    baseUrl: Api.projectList)
                .getResponse() ??
            {};
        if (response.isNotEmpty) {
          projectsList.addAll(ProjectBaseModel.fromJson(response).data);
          selectedProject.value = projectsList.first;
          kSelectedProject.value = projectsList.first;
          eventBus.fire(ProjectEvent(isProjectAvailable: true));
        }
      } catch (error) {
        log("error-----$error");
      }
    });
    availableList
        .addAll(["Available for Call", "Available for Chat", "Not Available"]);
    selectedAvailability.value = availableList.first;
  }
}
