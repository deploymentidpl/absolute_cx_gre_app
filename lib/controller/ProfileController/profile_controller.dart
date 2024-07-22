import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:greapp/model/EmployeeModel/employee_model.dart';
import 'package:greapp/widgets/custom_dialogs.dart';

import '../../config/Helper/api_response.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/preference_controller.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> passwordTextController = TextEditingController().obs;
  RxBool showPass = true.obs;
  RxBool changePin = false.obs;
  // RxString password = "".obs;
  Rx<EmployeeModel> employeeDetail = EmployeeModel().obs;

  ProfileController() {
    // passwordTextController.text = password.value;
  }

  Future<bool> getProfileDetails() async {
    try {
      Map<String, dynamic> data = {
        "page": "1",
        "size": "1",
        // "search": PreferenceController.getString(SharedPref.employeeID),
        "employee_id": PreferenceController.getString(SharedPref.employeeID),
      };
      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.apiEmployeeList,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData = await response.getResponse() ?? {};
print(data);
print(responseData);
      if (responseData['success'] == true) {
        List<EmployeeModel> tempList = [];
        tempList.addAll(EmployeeBaseModel.fromJson(responseData).data);
        if (tempList.isNotEmpty) {
          employeeDetail.value = tempList.first;
          passwordTextController.value.text = employeeDetail.value.pin;
          passwordTextController.refresh();
        } else {
          showError("Employee details not found");
        }
        return true;
      } else {
        showError(responseData["message"]);
        return false;
      }
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }
  Future<bool> savePin() async {
    try {
      Map<String, dynamic> data = {
        "employee_id" :employeeDetail.value.employeeId,
        "pin" :passwordTextController.value.text
      };
      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.apiChangeEmpPin,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData = await response.getResponse() ?? {};
print(data);
print(responseData);
      if (responseData['success'] == true) {
        List<EmployeeModel> tempList = [];
        tempList.addAll(EmployeeBaseModel.fromJson(responseData).data);
        if (tempList.isNotEmpty) {
          employeeDetail.value = tempList.first;
          print("employeeDetail.value.toJson()");
          print(employeeDetail.value.toJson());
          passwordTextController.value.text = employeeDetail.value.pin;
          passwordTextController.refresh();
          showSuccess(responseData['message']);
        } else {
          showError(responseData['error']);
        }
        return true;
      } else {
        showError(responseData["message"]);
        return false;
      }
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }
}
