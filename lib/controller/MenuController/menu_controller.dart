import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:greapp/model/CheckInModel/check_in_model.dart';

import '../../config/shared_pref.dart';
import '../../config/utils/preference_controller.dart';
import '../../model/MenuModel/menu_model.dart';
import '../../model/common_model.dart';
import '../../style/assets_string.dart';

class MenusController extends GetxController {
  CheckInModel checkInModel = CheckInModel();
  List<MenuModel> arrMenu = [
    MenuModel(
        menu: "Scan Visitor QR",
        alias: "scan",
        menuIcon: AssetsString.aScan,
        isCurrent: false),
    MenuModel(
        menu: "Knowledgebase",
        alias: "knowledgebase",
        menuIcon: AssetsString.aFileDetail,
        isCurrent: false),
    MenuModel(
        menu: "Logout",
        alias: "logout",
        menuIcon: AssetsString.aLogout,
        isCurrent: false),
  ];
  Rx<Duration> time = const Duration().obs;

  RxList<MenuModel> arrCallStatus = [
    MenuModel(menu: "On Call", alias: "oncall"),
    MenuModel(menu: "Idle", alias: "idle", isCurrent: true),
  ].obs;

  RxList<MenuModel> arrAvailableStatus = [
    MenuModel(
        menu: "Available For Call", alias: "availableforcall", isCurrent: true),
    MenuModel(menu: "Available For Chat", alias: "availableforchat"),
    MenuModel(menu: "Not Available", alias: "notavailable"),
  ].obs;

  RxList<CommonModel> arrProject = [
    CommonModel(description: "ACX Sydney"),
    CommonModel(description: "ACX Huston"),
    CommonModel(description: "ACX Kent"),
    CommonModel(description: "ACX Paris"),
    CommonModel(description: "ACX London"),
    CommonModel(description: "ACX Berlin"),
    CommonModel(description: "ACX Perth"),
    CommonModel(description: "ACX Tokyo"),
    CommonModel(description: "ACX Babylon"),
  ].obs;

  RxList<CommonModel> arrBuilding = [
    CommonModel(description: "Tower A"),
    CommonModel(description: "Tower B"),
    CommonModel(description: "Tower C"),
    CommonModel(description: "Tower D"),
    CommonModel(description: "Tower E"),
    CommonModel(description: "Tower F"),
    CommonModel(description: "Tower G"),
    CommonModel(description: "Tower H"),
    CommonModel(description: "Tower I"),
  ].obs;

  MenusController() {
    updateTimer();
  }

  void updateTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(checkInModel.checkInTime != null && checkInModel.checkInTime != ""){
        if (!PreferenceController.getBool(SharedPref.isUserLocked)) {
          time.value = DateTime.now().difference(DateTime.parse(
              checkInModel.checkInTime ?? DateTime.now().toIso8601String()));
        }
      }else{
        timer.cancel();
      }
    });
  }

  String getTime() {
    return "${(time.value.inDays % 24).toString().padLeft(2, "0")}:${(time.value.inHours % 60).toString().padLeft(2, "0")}:${(time.value.inMinutes % 60).toString().padLeft(2, "0")} Hr";
  }

  void selectCurrentScreen(String alias) {
    int index = arrMenu.indexWhere((element) => element.alias == alias.trim());
    for (int i = 0; i < arrMenu.length; i++) {
      if (i == index) {
        arrMenu[i].isCurrent = true;
      } else {
        arrMenu[i].isCurrent = false;
      }
    }
    checkInModel = CheckInModel.fromJson(
        jsonDecode(PreferenceController.getString(SharedPref.employeeDetails)));
  }
}
