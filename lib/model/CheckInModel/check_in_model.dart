import 'dart:convert';

import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';

class CheckInBaseModel {
  late bool success;
  late String message;
  late CheckInModel data;

  CheckInBaseModel() {
    success = false;
    message = "";
    data = CheckInModel();
  }

  CheckInBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success']?? false;
    message = json['message']?? "";
    data =json['data'] != null? CheckInModel.fromJson(json['data'][0]["employeeData"]):CheckInModel();
    if(json['data'] !=null ){
      PreferenceController.setString(SharedPref.loginToken, json['data'][0]['token'] );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data.toJson();
    return data;
  }
}

class CheckInModel {
  late String employeeId;
  late String type;
  late String checkInTime;
  late String? checkOutTime;
  late int totalTime;

  CheckInModel() {
    employeeId = "";
    type = "";
    checkInTime = "";
    checkOutTime = "";
    totalTime = 0;
  }

  CheckInModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id']?? "";
    type = json['type']?? "";
    checkInTime = json['check_in_time']?? "";
    checkOutTime = json['check_out_time'];
    totalTime = json['total_time']?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['type'] = type;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    data['total_time'] = totalTime;
    return data;
  }
}