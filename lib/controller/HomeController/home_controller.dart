import 'dart:developer';

import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
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
      Map<String, dynamic> responseData = await response.getResponse() ?? {};

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
}
