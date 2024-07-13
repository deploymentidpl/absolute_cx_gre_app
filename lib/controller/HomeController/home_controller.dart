import 'package:get/get.dart';

import '../../model/LeadModel/lead_model.dart';

class HomeController extends GetxController {
  RxBool showAssigned = true.obs;
  RxList<LeadModel> leadList = RxList([]);
  RxList<LeadModel> filteredLeadList = RxList([]);

  HomeController() {
    getLeadList();
    filterList();
  }

  filterList() {
    filteredLeadList.clear();
    if (showAssigned.value) {
      filteredLeadList
          .addAll(leadList.where((p0) => p0.isAssigned == true).toList());
    } else {
      filteredLeadList
          .addAll(leadList.where((p0) => p0.isAssigned == false).toList());
    }
  }

  getLeadList() {
    leadList.addAll(LeadBaseModel.fromJson({
      "Data": [
        {
          "name": "Juniper Doe",
          "age": 6,
          "location": "Vile Parle West, Mumbai, Maharashtra",
          "created": "2023-01-28T17:19:00Z",
          "updated": "2023-03-15T16:03:00Z",
          "waitlist_number": 4356,
          "schedule_time": "2024-06-19T16:03:00Z",
          "exam": "#20202",
          "property_type": "3 BHK",
          "price_range": "1.25-1.5 Cr",
          "company": "ACX Paris",
          "source": "Newspaper",
          "status": "Validated",
          "isAssigned": false,
        },
        {
          "name": "Juniper Doe",
          "age": 6,
          "location": "Vile Parle West, Mumbai, Maharashtra",
          "created": "2023-01-28T17:19:00Z",
          "updated": "2023-03-15T16:03:00Z",
          "waitlist_number": 4356,
          "schedule_time": "2024-06-19T16:03:00Z",
          "exam": "#20202",
          "property_type": "3 BHK",
          "price_range": "1.25-1.5 Cr",
          "company": "ACX Paris",
          "source": "Newspaper",
          "status": "Validated",
          "isAssigned": false,
        }
      ]
    }).data);
  }
}


/*import 'dart:developer';

import 'package:get/get.dart';

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
      filteredLeadList
          .addAll(assignedLeadList);
    } else {
      filteredLeadList
          .addAll(unAssignedLeadList);
    }
  }

 Future<bool> getUnAssignedLeadList()  async {
   try {
     Map<String, dynamic> data = {
     };


     ApiResponse response = ApiResponse(
         data: data,
         baseUrl: Api.apiUnAssignedList,
         apiHeaderType: ApiHeaderType.content,
         apiMethod: ApiMethod.post);
     Map<String, dynamic> responseData = await response.getResponse() ?? {};


     log(responseData.toString());
     if (responseData['success'] == true) {
       unAssignedLeadList.value = LeadBaseModel.fromJson(responseData).data;

     } else {showError(responseData['message'],);
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
*/