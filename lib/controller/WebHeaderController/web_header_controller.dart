import 'package:get/get.dart';
import 'package:greapp/model/CheckInSummaryModel/check_in_summary_model.dart';

import '../../main.dart';

class WebHeaderController extends GetxController {
  RxList<String> projectsList = RxList([]);
  RxString selectedProject = "".obs;
  RxList<String> availableList = RxList([]);
  RxList<CheckInSummaryModel> checkInHistory = RxList([]);
  RxString selectedAvailability = "".obs;
  RxInt notificationCount = 10.obs;
  String time = "2024-06-20T11:58:07.457Z";

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

  getProjects() {
    projectsList.addAll(["Falcon Tower", "Swara Park Square", "Sky Line"]);
    selectedProject.value = projectsList.first;
    availableList
        .addAll(["Available for Call", "Available for Chat", "Not Available"]);
    selectedAvailability.value = availableList.first;
    commonSelectedProject.value = projectsList.first;
  }
}
