import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/model/EmployeeModel/employee_model.dart';
import 'package:intl/intl.dart';

import '../../config/Helper/api_response.dart';
import '../../config/utils/api_constant.dart';
import '../../model/LeadModel/lead_model.dart';
import '../../widgets/custom_dialogs.dart';

class HomeController extends GetxController {
  RxBool showAssigned = true.obs;
  RxList<LeadModel> assignedLeadList = RxList([]);
  RxList<LeadModel> unAssignedLeadList = RxList([]);
  RxList<LeadModel> filteredLeadList = RxList([]);
  TextEditingController txtEmployeeId = TextEditingController();

  RxList<EmployeeModel> arrEmployee = RxList<EmployeeModel>([]);

  HomeController() {
    getUnAssignedLeadList();
    filterList();
  }

  filterList() {
    filteredLeadList.clear();
    if (showAssigned.value) {
      filteredLeadList.addAll(assignedLeadList);
    } else {
      filteredLeadList.addAll(unAssignedLeadList);
    }
  }

  Future<bool> getUnAssignedLeadList() async {
    try {
      Map<String, dynamic> data = {
        "from_date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "to_date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "gre_emp_id": PreferenceController.getString(SharedPref.employeeID)
      };

      devPrint(data);

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.apiUnAssignedList,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData = await response.getResponse() ?? {"message":"Cannot Fetch Details"};

      log(responseData.toString());
      if (responseData['success'] == true) {
        unAssignedLeadList.value = LeadBaseModel.fromJson(responseData).data;
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


  Future<void> getEmployeeList() async {

    var data = {
      'page': '1',
      'size': '50',
    };

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiEmployeeList,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();

    try {
      if (responseData != null) {
        if (responseData['success'] == true) {
          if (responseData['data'] != null && responseData['data'].length > 0) {
            List result = responseData['data'];
            arrEmployee.value =
                List.from(result.map((e) => EmployeeModel.fromJson(e)));
            arrEmployee.refresh();
          }
        }
      } else {
        showError('=erorrr==>' + responseData?['message']);
      }
    } catch (e, x) {
      devPrint('get error------------$e');
      devPrint('get error x------------$x');
    }
  }
}
