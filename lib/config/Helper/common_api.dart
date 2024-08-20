import 'dart:developer';
import 'package:get/get.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/model/CheckInModel/check_in_model.dart';
import 'package:greapp/model/EmployeeModel/employee_model.dart';
import 'package:greapp/model/ProjectListModel/project_list_model.dart';

import '../../model/SiteVisitFormModel/sv_done_model.dart';
import '../../model/common_model.dart';
import '../utils/api_constant.dart';
import '../utils/constant.dart';
import 'api_response.dart';
import 'function.dart';

Future<SiteVisitDataModel?> getSiteVisitData(
    {required String leadId, required String siteVisitId}) async {
  SiteVisitDataModel? model;
  try {
    ApiResponse response = ApiResponse(
      data: {
        'lead_id': leadId,
        'sitevisit_id': siteVisitId,
      },
      baseUrl: Api.apiViewLeadSVDoneUrl,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    if (responseData!['success'] == true) {
      try {
        if (responseData['data'].length > 0) {
          model = SiteVisitDataModel.fromJson(responseData['data'][0]);
        }
      } catch (e) {
        FunctionHelper.printLog(message: e.toString());
      }
    } else {}
  } catch (e) {
    FunctionHelper.printLog(message: e.toString());
  }
  return model;
}

class FunctionHelper {
  static printLog({required String message}) {
    log(message);
  }

  static List<String> convertToPercentage(List<int> values) {
    // Calculate the total sum of the list
    int total = values.fold(0, (sum, item) => sum + item);

    // Convert each value to a percentage string
    List<String> percentages = [];

    for (int i = 0; i < values.length; i++) {
      int value = values[i];
      if (value > 0) {
        double percentage = (value / total) * 100;
        percentages.add("${percentage.toStringAsFixed(1)} %");
      } else {
        percentages.add("0 %");
      }
    }

    return percentages;
  }
}

Future<RxList<CommonModel>> retrieveCountry() async {
  arrCountry = RxList([]);
  var data = {'page': '1', 'size': '1000'};
  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiCountryList,
      apiHeaderType: ApiHeaderType.content);
  Map<String, dynamic>? responseData = await response.getResponse();

  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrCountry.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrCountry.refresh();
  }

  return arrCountry;
}

Future<RxList<CommonModel>> retrieveCity() async {
  arrCity = RxList([]);

  var data = {'': ''};


  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiCityList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];

    arrCity.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrCity.refresh();
  }

  return arrCity;
}

Future<RxList<CommonModel>> retrievePurposeOfPurChase() async {
  arrPurPoseOfPurchaseList = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiPurchasePurposeList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];

    arrPurPoseOfPurchaseList.value =
        List.from(result.map((e) => CommonModel.fromJson(e)));
    arrPurPoseOfPurchaseList.refresh();
  }

  return arrPurPoseOfPurchaseList;
}

Future<RxList<CommonModel>> retrieveLeadSourceList() async {
  arrLeadSource = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiSourceList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];

    arrLeadSource.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrLeadSource.refresh();
  }

  return arrLeadSource;
}

Future<RxList<CommonModel>> retrieveIndustryList() async {
  arrIndustry = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiIndustryList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrIndustry.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrIndustry.refresh();
  }

  return arrIndustry;
}

Future<RxList<ProjectModel>> retrieveProjectList() async {
  arrProject = RxList([]);
  var data = {'': ''};
  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.projectList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrProject.value = List.from(result.map((e) => ProjectModel.fromJson(e)));
    arrProject.refresh();
  }

  return arrProject;
}

Future<RxList<CommonModel>> retrieveIncomeList() async {
  arrIncome = RxList([]);
  var data = {'1': '500'};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiAnnualIncomeList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrIncome.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrIncome.refresh();
  }

  return arrIncome;
}

Future<RxList<CommonModel>> retrieveTitleList() async {
  arrTitle = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiTitleList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrTitle.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrTitle.refresh();
  }

  return arrTitle;
}

Future<RxList<CommonModel>> retrieveBudgetList() async {
  arrBudget = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiBudgetList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrBudget.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrBudget.refresh();
  }

  return arrBudget;
}

Future<RxList<CommonModel>> retrieveDesignationList() async {
  arrDesignation = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiDesignationList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrDesignation.value =
        List.from(result.map((e) => CommonModel.fromJson(e)));
    arrDesignation.refresh();
  }

  return arrDesignation;
}

Future<RxList<CommonModel>> retrieveAgeList() async {
  arrAgeGroup = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiAgeGroupList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrAgeGroup.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrAgeGroup.refresh();
  }

  return arrAgeGroup;
}

Future<RxList<CommonModel>> retrieveLanguageList() async {
  arrLanguage = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiLanguageList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrLanguage.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrLanguage.refresh();
  }

  return arrLanguage;
}

Future<RxList<CommonModel>> retrieveConfigurationList() async {
  arrConfiguration = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiConfigurationList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrConfiguration.value =
        List.from(result.map((e) => CommonModel.fromJson(e)));
    arrConfiguration.refresh();
  }

  return arrConfiguration;
}

Future<RxList<CommonModel>> retrieveFunctionList() async {
  arrFunction = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiFunctionList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrFunction.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrFunction.refresh();
  }

  return arrFunction;
}

Future<RxList<CommonModel>> retrieveOccupationList() async {
  arrOccupation = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiOccupationList,
    apiHeaderType: ApiHeaderType.content,
    apiMethod: ApiMethod.post,
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrOccupation.value = List.from(result.map((e) => CommonModel.fromJson(e)));
    arrOccupation.refresh();
  }

  return arrOccupation;
}

Future<RxList<CheckInModel>> retrieveEmployeeList() async {
  var data = {'': ''};

  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiEmployeeList,
      apiHeaderType: ApiHeaderType.content,
      apiMethod: ApiMethod.post);

  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData != null) {
    if (responseData['success'] == true) {
      List result = responseData['data'];
      arrEmployee.value =
          List.from(result.map((e) => CheckInModel.fromJson(e)));
      arrEmployee.refresh();
    }
  }

  return arrEmployee;
}

Future<RxList<CheckInModel>> retrieveEmployeeSearch(
    {required String searchText}) async {
  RxList<CheckInModel> arrSearchedEmployee = RxList([]);

  var data = {'search': searchText};

  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiEmployeeList,
      apiHeaderType: ApiHeaderType.content,
      apiMethod: ApiMethod.post);

  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData != null) {
    if (responseData['success'] == true) {
      List result = responseData['data'];
      arrSearchedEmployee.value =
          List.from(result.map((e) => CheckInModel.fromJson(e)));
      arrSearchedEmployee.refresh();
    }
  }
  return arrSearchedEmployee;
}

Future<RxList<CheckInModel>> retrieveRoleWiseEmployeeList(
    {String? roleCode}) async {
  var data = {
    'page': '1',
    'size': '30',
    'role_code': [roleCode]
  };

  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiRoleWiseEmployeeList,
      apiHeaderType: ApiHeaderType.content,
      apiMethod: ApiMethod.post);

  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData != null) {
    if (responseData['success'] == true) {
      List result = responseData['data'];
      arrRoleWiseEmployee.value =
          List.from(result.map((e) => CheckInModel.fromJson(e)));
      arrRoleWiseEmployee.refresh();
    }
  }

  return arrRoleWiseEmployee;
}

Future<RxList<CustomerRefUnitModel>> retrieveCustomerRefUnit(
    {customerRefMobile, isLeadSource}) async {
  if (isLeadSource) {
    arrLeadCustomerRefUnit = RxList([]);
  } else {
    arrCustomerRefUnit = RxList([]);
  }
  var data = {'CustMobPhNumber': customerRefMobile};
  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiCustomerRefUnitList,
      apiHeaderType: ApiHeaderType.content);
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData!['success'] == true) {
    List result = responseData['data'];

    if (isLeadSource) {
      arrLeadCustomerRefUnit.value =
          List.from(result.map((e) => CustomerRefUnitModel.fromJson(e)));
    } else {
      arrCustomerRefUnit.value =
          List.from(result.map((e) => CustomerRefUnitModel.fromJson(e)));
    }
    arrCustomerRefUnit.refresh();
    arrLeadCustomerRefUnit.refresh();
  }
  return isLeadSource ? arrLeadCustomerRefUnit : arrCustomerRefUnit;
}

/*Future<RxList<CustomerDialogModel>> retrieveCustomerRefSearchData(
    String customerMobPhNumber,
    [String materialID = ""]) async {
  arrCustomerRefSearch = RxList([]);
  var data = {
    'CustMobPhNumber': customerMobPhNumber.trim(),
    if (materialID.isNotEmpty) "MaterialID": materialID
  };
  devPrint("customer search data-----$data");

  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiCustomerRefSearchList,
    apiHeaderType: ApiHeaderType.content,
  );
  Map<String, dynamic>? responseData = await response.getResponse();

  devPrint("customer search response-----$responseData");

  if (responseData?['success'] == true) {
    List result = responseData?['data'];
    arrCustomerRefSearch.value =
        List.from(result.map((e) => CustomerDialogModel.fromJson(e)));
    arrCustomerRefSearch.refresh();
  } else {}

  return arrCustomerRefSearch;
}*/

Future employeeDetailsApi(isLeadSource, empId) async {
  var data = {
    'EmployeeID': empId,
  };
  log('data-----------$data');
  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiEmployeeDetailList,
    apiHeaderType: ApiHeaderType.content,
    //apiMethod: ApiMethod.post
  );
  Map<String, dynamic>? responseData = await response.getResponse();
  if (responseData != null) {
    if (responseData['success'] == true) {
      if (responseData['data'] != null && responseData['data'].length > 0) {
      } else {}
    } else {}
  } else {}
}

Future<RxList<ChannelPartnerModel>> retrieveCPSearchData(
    String searchText) async {
  arrCPSearchData = RxList([]);
  var data = {
    'search': searchText,
  };


  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.channelPartnerListUrl,
      apiHeaderType: ApiHeaderType.content,
      apiMethod: ApiMethod.post);
  Map<String, dynamic>? responseData = await response.getResponse();


  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrCPSearchData.value =
        List.from(result.map((e) => ChannelPartnerModel.fromJson(e)));
    arrCPSearchData.refresh();
  }

  return arrCPSearchData;
}

Future<RxList<EmployeeModel>> retrieveEmpRefSearchData(String empId) async {
  arrEmpRefSearchData = RxList([]);
  var data = {
    'employee_id': empId,
  };


  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.employeeSearchUrl,
      apiHeaderType: ApiHeaderType.content,
      apiMethod: ApiMethod.post);
  Map<String, dynamic>? responseData = await response.getResponse();


  if (responseData!['success'] == true) {
    List result = responseData['data'];
    arrEmpRefSearchData.value =
        List.from(result.map((e) => EmployeeModel.fromJson(e)));
    arrEmpRefSearchData.refresh();
  }

  return arrEmpRefSearchData;
}

Future retrieveNotificationCount() async {
  var data = {
    'owner_party_id': PreferenceController.getString(SharedPref.employeeID),
  };
  ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiNotificationCount,
      apiHeaderType: ApiHeaderType.content);
  Map<String, dynamic>? responseData = await response.getResponse();

  try {
    if (responseData != null) {
      if (responseData['success'] == true) {
        notificationCount.value = responseData['data'][0]['count'].toString();
      } else {}
    } else {}
  } catch (e, x) {
    devPrint('error notification count-------$e');
    devPrint('error notification count details-------$x');
  }
}
