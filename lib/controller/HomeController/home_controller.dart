import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/model/EmployeeModel/employee_model.dart';
import 'package:intl/intl.dart';

import '../../config/Helper/api_response.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/constant.dart';
import '../../model/CheckInModel/check_in_model.dart';
import '../../model/LeadModel/lead_model.dart';
import '../../style/theme_color.dart';
import '../../widgets/SideBarMenuWidget/sidebar_menu_widget.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/common_bottomsheet.dart';
import '../../widgets/comon_type_ahead_field.dart';
import '../../widgets/custom_dialogs.dart';

class HomeController extends GetxController {
  RxBool showAssigned = true.obs;
  RxList<LeadModel> assignedLeadList = RxList([]);
  RxList<LeadModel> unAssignedLeadList = RxList([]);
  RxList<LeadModel> filteredLeadList = RxList([]);
  RxList<LeadModel> savedList = RxList([]);
  TextEditingController txtEmployeeId = TextEditingController();
  RxBool isLeadLoading = true.obs;

  RxList<EmployeeModel> arrEmployee = RxList<EmployeeModel>([]);
  Rx<EmployeeModel> selectedEmployee = EmployeeModel().obs;

  HomeController() {
    getLeadsList();
  }

  toggleShowAssigned({bool? newVal}) {
    if (newVal != null) {
      showAssigned.value = newVal;
    } else {
      showAssigned.value = !showAssigned.value;
    }
    getLeadsList();
  }

  filterList() {
    filteredLeadList.clear();

    if (showAssigned.value) {
      filteredLeadList.addAll(assignedLeadList);
    } else {
      filteredLeadList.addAll(unAssignedLeadList);
    }
  }

  Future<bool> getLeadsList({String? searchText}) async {
    try {
      isLeadLoading.value = true;
      filteredLeadList.clear();
      unAssignedLeadList.clear();
      assignedLeadList.clear();
      Map<String, dynamic> data = {
        "from_date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "to_date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "gre_emp_id": PreferenceController.getString(SharedPref.employeeID)
      };

      if (searchText != null) {
        data.addAll({"search": searchText});
      }

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl:
              showAssigned.value ? Api.apiAssignedList : Api.apiUnAssignedList,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData =
          await response.getResponse() ??
              {"message": "Cannot Fetch Details"};

      //todo: hide in future
      log(PreferenceController.getString(
        SharedPref.loginToken,
      ));
      if (responseData['success'] == true) {
        if (showAssigned.value) {
          assignedLeadList.value = LeadBaseModel.fromJson(responseData).data;
        } else {
          unAssignedLeadList.value = LeadBaseModel.fromJson(responseData).data;
        }
      }
      filterList();
      isLeadLoading.value = false;
      return true;
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      isLeadLoading.value = false;
      return false;
    }
  }

  Future<bool> assignedLead({required LeadModel obj}) async {
    try {
      Map<String, dynamic> data = {
        "sitevisit_id": obj.id,
        "lead_id": obj.leadId,
        "sv_owner_id": selectedEmployee.value.employeeId,
        "sv_owner_name": selectedEmployee.value.empFormattedName,
        "updated_by_emp_id":
            PreferenceController.getString(SharedPref.employeeID),
        "updated_by_emp_name": CheckInModel.fromJson(jsonDecode(
                PreferenceController.getString(SharedPref.employeeDetails)))
            .empFormattedName
      };

      devPrint(data);

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.apiReAssign,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData =
          await response.getResponse() ?? {"message": "Cannot Fetch Details"};

      log(responseData.toString());
      if (responseData['success'] != true) {
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
        showError(responseData?['message']);
      }
    } catch (e, x) {
      devPrint('get error------------$e');
      devPrint('get error x------------$x');
    }
  }

  Future<void> openAssignMenu(
      BuildContext context, LeadModel obj, GlobalKey<FormState> formKey) async {
    appLoader(context);
    getEmployeeList().then((value) {
      removeAppLoader(context);
      getMenu(context, obj, formKey);
    });
  }

  void getMenu(
      BuildContext context, LeadModel obj, GlobalKey<FormState> formKey) {
    txtEmployeeId.clear();
    selectedEmployee = EmployeeModel().obs;
    if (isWeb) {
      showDialog(
        context: context,
        builder: (context) {
          return SideBarMenuWidget(
            sideBarWidget: assignOwnerContent(obj, formKey),
            onTapBottomButton: () {
              appLoader(context);
              if (formKey.currentState!.validate()) {
                assignedLead(
                  obj: obj,
                ).whenComplete(() {
                  removeAppLoader(context);
                  Get.back();
                  getLeadsList();
                });
              }
            },
            showBottomStickyButton: true,
            bottomButtonMainText: "Assign",
          );
        },
      );
    } else {
      commonDialog(
        child: assignOwnerContent(obj, formKey),
        onTapBottomButton: () {
          appLoader(context);
          if (formKey.currentState!.validate()) {
            assignedLead(
              obj: obj,
            ).whenComplete(() {
              removeAppLoader(context);
              Get.back();
              getLeadsList();
            });
          }
        },
        showBottomStickyButton: true,
        bottomButtonMainText: "Assign",
        mainHeadingText: "Lead Assign",
      );
    }
  }

  Widget assignOwnerContent(LeadModel obj, GlobalKey<FormState> formKey) {
    return Container(
      color: isWeb ? null : ColorTheme.cThemeBg,
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customTypeAheadField(
                hintStyle: TextStyle(color: Colors.grey[600]),
                labelText: 'Select*',
                textController: txtEmployeeId,
                dataList: arrEmployee,
                suggestion: (e) => "${e.employeeId} ${e.empFormattedName}",
                onSelected: (t) async {
                  txtEmployeeId.text = "${t.employeeId} ${t.empFormattedName}";
                  selectedEmployee.value = t;
                },
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please select employee id";
                  } else {
                    return null;
                  }
                },
                fillColor: ColorTheme.cThemeCard),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
