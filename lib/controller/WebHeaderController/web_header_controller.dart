import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/api_response.dart';
import 'package:greapp/controller/CommonController/common_controller.dart';
import 'package:greapp/model/CheckInSummaryModel/check_in_summary_model.dart';
import 'package:greapp/model/ProjectListModel/nearby_projct_list_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/utils/api_constant.dart';
import '../../main.dart';

class WebHeaderController extends GetxController {
  RxBool isSearch = false.obs;
  Rx<TextEditingController> txtSearch = TextEditingController().obs;
  FocusNode searchFocus = FocusNode();
  RxList<NearbyProjectModel> projectsList = RxList([]);
  Rx<NearbyProjectModel> selectedProject = NearbyProjectModel().obs;
  RxList<String> availableList = RxList([]);
  RxList<CheckInSummaryModel> checkInHistory = RxList([]);
  RxString selectedAvailability = "".obs;
  RxInt notificationCount = 10.obs;
  String time = "2024-06-20T11:58:07.457Z";
  Rx<Position>? currPosition;

  WebHeaderController() {
    getProjects();
  }

  getCheckInHistory() {
    checkInHistory.clear();
    checkInHistory.addAll(CheckInSummaryBaseModel.fromJson({
      "checkInSummary": [
        {"checkIn": "10:08 AM", "checkOut": "01:05 PM", "time": "02:57 Hr"},
        {"checkIn": "02:09 PM", "checkOut": "05:22 PM", "time": "03:13 Hr"},
        {"checkIn": "05:45 PM", "checkOut": "", "time": "03:03 Hr"}
      ]
    }).data);
  }

  getProjects() async {
    Permission.location.request().then((value) async {
      if (value.isGranted) {
        try {
          currPosition = (await CommonController().getCurrentLocation()).obs;
          Map<String, dynamic> response = await ApiResponse(
                      data: {"page": "1", "size": "5"},
                      isFormData: false,
                      apiHeaderType: ApiHeaderType.content,
                      baseUrl: Api.nearbyProjectList)
                  .getResponse() ??
              {};
          print("responsedsfdvfdb");
          print(response);
          if (response.isNotEmpty) {
            projectsList.addAll(NearbyProjectBaseModel.fromJson(response).data);
            selectedProject.value = projectsList.first;
            commonSelectedProject.value = projectsList.first;
          }
        } catch (error) {
          log("error-----$error");
        }
      } else {}
    });
    availableList
        .addAll(["Available for Call", "Available for Chat", "Not Available"]);
    selectedAvailability.value = availableList.first;
  }
}
