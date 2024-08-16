import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:greapp/main.dart';
import 'package:greapp/model/CheckInModel/check_in_model.dart';
import 'package:greapp/model/EmployeeModel/employee_model.dart';

import '../../config/Helper/api_response.dart';
import '../../config/Helper/common_api.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/constant.dart';
import '../../config/utils/preference_controller.dart';
import '../../model/ChannelPartnerModel/channel_partner_model.dart';
import '../../model/SiteVisitFormModel/site_visit_form_existing_detail.dart';
import '../../model/common_model.dart';
import '../../model/lead_model/customer_data_model/customer_data_model.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/custom_dialogs.dart';

class SiteVisitFormController extends GetxController {
  GlobalKey<FormState> personalDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> purchaseDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> professionalDetailsFormKey = GlobalKey<FormState>();
  RxInt tabIndex = 0.obs;

  ///verify mobile
  TextEditingController txtMobileNo = TextEditingController();
  TextEditingController txtOtp = TextEditingController();

  FocusNode otpFocusNode = FocusNode();
  RxString scanId = ''.obs;
  String svFormId = '';
  RxString token = ''.obs;
  RxString waitListNumber = ''.obs;
  RxBool otpVerified = false.obs;
  RxBool disableSource = false.obs;
  RxBool showWaitListWebPage = false.obs;

  ///verify mobile
  String otpId = '';
  RxBool showOtp = false.obs;
  RxBool showReSendOtp = false.obs;
  RxBool checkWhatsapp = false.obs;
  RxString whatsappNumber = ''.obs;

  Timer timer = Timer.periodic(
    Duration.zero,
    (t) {},
  );

  Rx<Duration> otpTime = Duration.zero.obs;

  ///personal Details
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtResAlternate = TextEditingController();
  TextEditingController txtTelephoneNo = TextEditingController();
  TextEditingController txtWhatsappNumber = TextEditingController();
  TextEditingController txtAgeGroup = TextEditingController();
  TextEditingController txtCurrentResidence = TextEditingController();
  TextEditingController txtPinCode = TextEditingController();

  ///purchase details
  TextEditingController txtSource = TextEditingController();
  TextEditingController txtPurchasePurpose = TextEditingController();
  TextEditingController txtHomeLoan = TextEditingController();
  TextEditingController txtSVAttendee = TextEditingController();
  TextEditingController txtBudget = TextEditingController();
  TextEditingController txtConfiguration = TextEditingController();

  ///professional Details
  TextEditingController txtOccupation = TextEditingController();
  TextEditingController txtIndustry = TextEditingController();
  TextEditingController txtDesignation = TextEditingController();
  TextEditingController txtFunction = TextEditingController();
  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtCompanyLocation = TextEditingController();
  TextEditingController txtCompanyAddress = TextEditingController();
  TextEditingController txtOfficeTelephone = TextEditingController();
  TextEditingController txtAnnualIncome = TextEditingController();

  RxList<CommonModel> arrTabMenu = RxList([]);

  RxList<CustomerRefUnitModel> arrCustomerRefUnit =
      RxList(<CustomerRefUnitModel>[]);

  /// lead source fields
  ///  cp
  TextEditingController txtLeadCP = TextEditingController();
  TextEditingController txtLeadCPVendorId = TextEditingController();
  TextEditingController txtLeadCPExecutive = TextEditingController();
  TextEditingController txtLeadCPExecutiveMobile = TextEditingController();
  TextEditingController txtLeadCPCompanyName = TextEditingController();
  TextEditingController txtLeadCPRERANo = TextEditingController();

  ///customer
  TextEditingController txtLeadCustomerMobileSearch = TextEditingController();
  TextEditingController txtLeadCustomerId = TextEditingController();
  TextEditingController txtLeadCustomerName = TextEditingController();
  TextEditingController txtLeadUnitNo = TextEditingController();
  TextEditingController txtLeadProjectName = TextEditingController();

  ///employee
  TextEditingController txtLeadEmployeeId = TextEditingController();
  TextEditingController txtLeadEmployeeName = TextEditingController();
  TextEditingController txtLeadEmployeeMobile = TextEditingController();
  TextEditingController txtLeadEmployeeMail = TextEditingController();

  TextEditingController txtCustomerId = TextEditingController();
  TextEditingController txtCustomerMobile = TextEditingController();
  TextEditingController txtCustomerName = TextEditingController();
  TextEditingController txtCustomerUnitNo = TextEditingController();
  TextEditingController txtProjectName = TextEditingController();
  TextEditingController txtEmployeeId = TextEditingController();
  TextEditingController txtEmployeeName = TextEditingController();
  TextEditingController txtEmployeeMobile = TextEditingController();
  TextEditingController txtEmployeeEmail = TextEditingController();
  TextEditingController txtCPExecutiveMobile = TextEditingController();
  TextEditingController txtCPVendorId = TextEditingController();
  TextEditingController txtCP = TextEditingController();
  TextEditingController txtCPCompanyName = TextEditingController();
  TextEditingController txtCPReraNo = TextEditingController();

  RxList<CommonModel> arrAttendee = RxList([]);

  //RxList<CommonModel>  arrNeedLoan = RxList([]);
  RxList<CheckInModel> arrSelectedSourcingManager = RxList([]);

  Rx<CommonModel> objCountry = CommonModel().obs;
  Rx<CommonModel> objResCountry = CommonModel().obs;
  Rx<CommonModel> objTelCountry = CommonModel().obs;
  Rx<CommonModel> objOfficeTelCountry = CommonModel().obs;
  Rx<CommonModel> objTitle = CommonModel().obs;
  Rx<CommonModel> objAgeGroup = CommonModel().obs;
  Rx<CommonModel> objSource = CommonModel().obs;
  Rx<CommonModel> objOccupation = CommonModel().obs;
  Rx<CommonModel> objIndustry = CommonModel().obs;
  Rx<CommonModel> objFunction = CommonModel().obs;
  Rx<CommonModel> objIncome = CommonModel().obs;
  Rx<CommonModel> objPurpose = CommonModel().obs;
  Rx<CommonModel> objAttendee = CommonModel().obs;
  Rx<CommonModel> objConfiguration = CommonModel().obs;
  Rx<CommonModel> objDesignation = CommonModel().obs;
  Rx<CommonModel> objBudget = CommonModel().obs;

  RxList<EmployeeModel> arrEmployee = RxList<EmployeeModel>([]);
  TextEditingController txtSearch = TextEditingController();
  TextEditingController txtEmpId = TextEditingController();
  Rx<EmployeeModel> objEmployee = EmployeeModel().obs;
  RxList<ChannelModel> arrChannelList = RxList<ChannelModel>([]);
  TextEditingController txtChannelName = TextEditingController();
  TextEditingController txtVendorId = TextEditingController();
  TextEditingController txtCpUserName = TextEditingController();
  TextEditingController txtReraNo = TextEditingController();
  TextEditingController txtExecutiveName = TextEditingController();
  TextEditingController txtCpNumber = TextEditingController();
  Rx<ChannelModel> objChannel = ChannelModel().obs;
  Rx<CustomerDataFetchModel> objCustomer = CustomerDataFetchModel().obs;

  void defaultCountry() {
    objCountry.refresh();
    objResCountry = objCountry;
    objTelCountry = objCountry;
    objResCountry.refresh();
    objTelCountry.refresh();
  }

  void commonNextTap() {
    if (tabIndex.value < 3) {
      if (tabIndex.value == 1 &&
          personalDetailsFormKey.currentState!.validate()) {
        tabIndex.value = 1;
      }
    }
    if (tabIndex.value == 1 &&
        personalDetailsFormKey.currentState!.validate()) {
      addEditSvFormDetails(SVFormType.personalDetails).then((value) {
        if (value) {
          tabIndex.value = 2;
          tabIndex.refresh();
        }
      });
    }
    if (tabIndex.value == 2 &&
        professionalDetailsFormKey.currentState!.validate()) {
      addEditSvFormDetails(SVFormType.professionalDetails).then((value) {
        if (value) {
          tabIndex.value = 3;
          tabIndex.refresh();
        }
      });
    }
    tabIndex.refresh();
  }

  Future<void> loadData() async {
    isMobile ? mobileTabMenuData() : tabMenuData();
    retrieveSVAttendeeData();
    //retrieveNeedLoan();

    ///from common apis
    retrieveTitleList();
    await retrieveAgeList();
    retrieveCountry().whenComplete(() {
      objCountry.value = arrCountry.singleWhere(
          (element) => element.code.toString().trim().toUpperCase() == 'IN',
          orElse: () => CommonModel());
      objCountry.refresh();
      objResCountry = objCountry;
      objTelCountry = objCountry;
    });
    retrieveConfigurationList();
    retrieveLeadSourceList();
    retrievePurposeOfPurChase();
    retrieveOccupationList();
    retrieveFunctionList();
    retrieveIndustryList();
    retrieveIncomeList();
    retrieveEmployeeList();
    retrieveBudgetList();
    retrieveDesignationList();
    getEmployeeList();
    getChannelList();
    //arrSourcingManager.value = await retrieveEmployeeSearch(searchText: "sales manager");
    //arrSourcingManager.refresh();
  }

  Future<void> getEmployeeList() async {
    txtSearch.clear();

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
        showError(  responseData?['message']);
      }
    } catch (e, x) {
      devPrint('get error------------$e');
      devPrint('get error x------------$x');
    }
  }

  devPrint(Object object) {
    if (kDebugMode) {
      print(object);
    }
  }

  Future<void> getEmployeeSearch() async {
    var data = {'page': '1', 'size': '50', 'search': txtEmployeeId.text};

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: txtSearch.text.isEmpty
            ? Api.apiEmployeeList
            : Api.employeeSearchUrl,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();

    try {
      if (responseData != null) {
        if (responseData['success'] == true) {
          if (responseData['data'] != null && responseData['data'].length > 0) {
            objEmployee.value = EmployeeModel.fromJson(responseData['data'][0]);

            devPrint('RES------>${objEmployee.value.firstName}');
            devPrint('------>${objEmployee.value.lastName}');
            devPrint('------>${objEmployee.value.employeeId}');

            txtEmployeeId.text = objEmployee.value.employeeId;
            txtEmployeeName.text = objEmployee.value.firstName;
            txtEmployeeMobile.text = objEmployee.value.mobileNo;
            txtEmployeeEmail.text = objEmployee.value.email;
          }
        }
      } else {
        showError(  responseData?['message']);
      }
    } catch (e, x) {
      devPrint('get error------------$e');
      devPrint('get error x------------$x');
    }
  }

  void getCustomerReferral() async {
    var data = {
      'mobile_no': txtCustomerMobile.text,
      'mobile_country_code': objCountry.value.countryCode
    };

    devPrint('---->$txtCustomerMobile');
    devPrint('---->${objCountry.value.countryCode}');

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiCustomerLeadDetails,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();

    devPrint("----->${responseData?["data"]}");
    try {
      if (responseData != null) {
        if (responseData['success'] == true) {
          if (responseData['data'] != null && responseData['data'].length > 0) {

            objCustomer.value =
                CustomerDataFetchModel.fromJson(responseData['data'][0]);

            txtCustomerId.text = objCustomer.value.customerId ?? '';
            txtCustomerMobile.text = objCustomer.value.mobileNo ?? '';
            txtCustomerName.text = objCustomer.value.firstName ?? '';
          }
        }
      } else {
        showError( responseData?['message']);
      }
    } catch (e, x) {
      devPrint('get error------------$e');
      devPrint('get error x------------$x');
    }
  }

  Future<RxList<ChannelModel>> getChannelList() async {
    var data = {
      'page': '1',
      'size': '20',
    };

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.channelPartnerListUrl,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();

    devPrint("----->${responseData?["data"]}");
    try {
      if (responseData != null) {
        if (responseData['success'] == true) {
          if (responseData['data'] != null && responseData['data'].length > 0) {
            List result = responseData['data'];
            arrChannelList.value =
                List.from(result.map((e) => ChannelModel.fromJson(e)));
            arrChannelList.refresh();
          }
        }
      } else {
        showError(  responseData?['message']);
      }
    } catch (e, x) {
      devPrint('get error------------$e');
      devPrint('get error x------------$x');
    }

    return arrChannelList;
  }

  Future<Rx<ChannelModel>> getChannelSearch() async {
    var data = {'page': '1', 'size': '20', 'search': txtCpUserName.text};

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.channelPartnerListUrl,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();

    devPrint("----->${responseData?["data"]}");
    try {
      if (responseData != null) {
        if (responseData['success'] == true) {
          if (responseData['data'] != null && responseData['data'].length > 0) {
            objChannel.value = ChannelModel.fromJson(responseData['data'][0]);
            txtCpUserName.text = objChannel.value.firstName!;
            txtCPVendorId.text = objChannel.value.vendorId!;
            txtCPCompanyName.text = objChannel.value.companyDescription!;
            txtCPReraNo.text = objChannel.value.reraNumber!;
            txtCPExecutiveMobile.text = objChannel.value.mobileNo!;

            devPrint('------->${txtCpUserName.text}');
            devPrint('------->${txtCPVendorId.text}');
            devPrint('------->${txtCpUserName.text}');
            devPrint('------->${txtCpUserName.text}');
            devPrint('------->${txtCpUserName.text}');
          }
        }
      } else {
        showError( responseData?['message']);
      }
    } catch (e, x) {
      devPrint('get error------------$e');
      devPrint('get error x------------$x');
    }

    return objChannel;
  }

  Future<void> clearData() async {
    scanId.value = '';
    scanId.refresh();
    svFormId = '';
    waitListNumber.value = '';
    waitListNumber.refresh();
    token.value = '';
    token.refresh();
    showWaitListWebPage.value = false;

    ///verify mobile
    txtMobileNo.clear();
    txtOtp.clear();
    showOtp.value = false;
    showOtp.refresh();
    showReSendOtp.value = false;
    defaultCountry();

    ///personal
    txtTitle.clear();
    objTitle.value = CommonModel();
    txtFirstName.clear();
    txtLastName.clear();
    txtEmail.clear();
    txtResAlternate.clear();
    txtTelephoneNo.clear();
    txtWhatsappNumber.clear();
    txtAgeGroup.clear();
    objAgeGroup.value = CommonModel();
    txtCurrentResidence.clear();
    txtPinCode.clear();
    txtSource.clear();
    objSource.value = CommonModel();
    arrSelectedSourcingManager.clear();
    arrSelectedSourcingManager.refresh();

    ///professional
    txtOccupation.clear();
    objOccupation.value = CommonModel();
    txtIndustry.clear();
    objIndustry.value = CommonModel();
    txtDesignation.clear();
    objDesignation.value = CommonModel();
    txtFunction.clear();
    objFunction.value = CommonModel();
    txtCompanyName.clear();
    txtCompanyLocation.clear();
    txtCompanyAddress.clear();
    txtOfficeTelephone.clear();
    txtAnnualIncome.clear();
    objIncome.value = CommonModel();

    disableSource.value = false;
    showWaitListWebPage.value = false;

    ///purchase
    txtPurchasePurpose.clear();
    objPurpose.value = CommonModel();
    txtSVAttendee.clear();
    objAttendee.value = CommonModel();
    txtConfiguration.clear();
    objConfiguration.value = CommonModel();
    txtBudget.clear();
    objBudget.value = CommonModel();
  }

  bool checkForm(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }

  void tabMenuData() {
    arrTabMenu.value = [
      CommonModel(code: "verify", description: "Lets Get Started"),
      CommonModel(code: "personal", description: "Personal Details"),
      CommonModel(code: "professional", description: "Professional Details"),
    ];
    arrTabMenu.refresh();
  }

  void mobileTabMenuData() {
    arrTabMenu.value = [
      CommonModel(code: "verify", description: "Verify Mobile Number"),
      CommonModel(code: "personal", description: "Personal Details"),
      CommonModel(code: "professional", description: "Professional Details"),
      // CommonModel(code: "purchase", description: "Purchase Details"),
      CommonModel(code: "success", description: "Success"),
    ];
    arrTabMenu.refresh();
  }

  String? validation(String? value, String message) {
    if (value!.trim().isEmpty) {
      return message.capitalizeFirst;
    } else {
      return null;
    }
  }

  Future<void> sendOTP() async {
    appLoader(Get.context!);
    otpId = '';
    var data = {
      'mobile_no': txtMobileNo.text.trim(),
      'mobile_country_code': objCountry.value.countryCode,
      'country_code': objCountry.value.code,
      'project_code': kSelectedProject.value.projectCode
    };

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiSvFormSendOTP,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);
    Map<String, dynamic>? responseData = await response.getResponse();
    /*  devPrint("sv form otp send---------${jsonEncode(data)}");
    devPrint("sv form otp responseData---------$responseData");*/
    try {
      if (responseData!['success'] == true) {
        removeAppLoader(Get.context!);
/*        showSuccess(responseData['message']);*/
        showSuccess(
            "${responseData['message']} \n OTP is: ${responseData['data'][0]['otp']}");

        // showSuccess("OTP Sent Successfully: ${responseData["data"][0]['otp']}");
        if (responseData['data'] != null &&
            responseData['data'] != '' &&
            responseData['data'].length > 0) {
          otpId = responseData['data'][0]['_id'].toString();
          if (otpId.isNotEmpty) {
            showOtp.value = true;
            showReSendOtp.value = false;
            showOtp.refresh();
            otpTime.value = const Duration(seconds: 30);
            timer = Timer.periodic(const Duration(seconds: 1), (_) {
              if (otpTime.value.inSeconds == 0) {
                timer.cancel();
                showReSendOtp.value = true;
              } else {
                otpTime.value = Duration(seconds: otpTime.value.inSeconds - 1);
              }
            });
          }
          devPrint(responseData['message']);
        } else {
          devPrint(responseData['message']);
        }
      } else {
        removeAppLoader(Get.context!);
        showError(responseData['message']);
      }
    } catch (e, x) {
      removeAppLoader(Get.context!);
      devPrint(responseData!['message']);
      devPrint('exception---$e');
      devPrint('exception x---$x');
    }
  }

  Future<bool> verifyOtp() async {
    bool isValid = false;
    appLoader(Get.context!);

    var data = {
      //"SalesOwnerPartyID": kOwnerPartyID,
      //"SalesOwnerPartyName": kOwnerPartyName,
      '_id': otpId,
      'otp': txtOtp.text.trim().toString(),
      'created_by_emp_id':
          PreferenceController.getString(SharedPref.employeeID),
      //"sitecode": kSavedProject.value.projectCode,
    };
    /*   devPrint("sv form otp verify data---------$data");*/
    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiSvFormVerifyOTP,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();
    /*devPrint("sv form otp verify res---------$responseData");*/

    try {
      if (responseData!['success'] == true) {
        removeAppLoader(Get.context!);
        showSuccess(responseData['message']);
        isValid = true;
        otpVerified.value = true;
        if (responseData['data'] != null && responseData['data'].length > 0) {
          try {
            SVExistingDetail svData =
                SVExistingDetail.fromJson(responseData['data'][0]);

            devPrint("---------->${responseData['data'][0]}");
            /*   txtTitle.text = svData.designationDescription ?? '';
            if (svData.titleCode != null && svData.titleCode!.isNotEmpty) {
              int index = arrTitle.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.titleCode);
              if (index >= 0) {
                txtTitle.text = arrTitle[index].description ?? '';
                objTitle.value = arrTitle[index];
                objTitle.refresh();
              }
            }

            txtFirstName.text = svData.firstName ?? '';
            txtLastName.text = svData.lastName ?? '';
            txtEmail.text = svData.email ?? '';
            txtMobileNo.text = svData.mobileNo ?? '';
            txtResAlternate.text = svData.altMobileNo ?? '';
            txtTelephoneNo.text = svData.officeTelephone ?? '';
            txtAgeGroup.text = svData.ageGroupDescription ?? '';
            if (svData.ageGroupCode != null &&
                svData.ageGroupCode!.isNotEmpty) {
              int index = arrAgeGroup.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.ageGroupCode);
              if (index >= 0) {
                txtAgeGroup.text = arrAgeGroup[index].description ?? '';
                objAgeGroup.value = arrAgeGroup[index];
                objAgeGroup.refresh();
              }
            }
            txtConfiguration.text = svData.configurationDescription ?? "";
            if (svData.configurationCode != null &&
                svData.configurationCode!.isNotEmpty) {
              int index = arrConfiguration.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.configurationCode);
              if (index >= 0) {
                txtConfiguration.text =
                    arrConfiguration[index].description ?? '';
                objConfiguration.value = arrConfiguration[index];
                objConfiguration.refresh();
              }
            }
            txtBudget.text = svData.budgetDescription ?? "";
            if (svData.budgetCode != null && svData.budgetCode!.isNotEmpty) {
              int index = arrBudget.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.budgetCode);
              if (index >= 0) {
                txtBudget.text = arrBudget[index].description ?? '';
                objBudget.value = arrBudget[index];
                objBudget.refresh();
              }
            }
            txtCurrentResidence.text = svData.currentResidenceLocation ?? '';
            txtPinCode.text = svData.pincode ?? '';
            txtCustomerMobile.text = svData.referralCustomerMobile ?? '';
            txtCustomerUnitNo.text = svData.referralCustomerUnitNo ?? '';
            txtCustomerId.text = svData.customerId ?? '';
            txtCustomerName.text = svData.referralCustomerName ?? '';
            txtProjectName.text = svData.referralCustomerProjectName ?? '';

            txtEmployeeId.text = svData.referralEmployeeId ?? '';
            txtEmployeeMobile.text = svData.referralEmployeeMobile ?? '';
            txtEmployeeEmail.text = svData.referralEmployeeEmail ?? '';
            txtCustomerName.text = svData.referralCustomerName ?? '';

            txtCP.text = svData.referralCpName ?? '';
            txtCPVendorId.text = svData.referralVendorId ?? '';
            txtCPReraNo.text = svData.referralCpReraNo ?? '';
            txtCPExecutive.text = svData.referralCpExecutive ?? '';
            txtCPExecutiveMobile.text = svData.referralCpExecutiveMobile ?? '';

            txtOccupation.text = svData.occupationDescription ?? '';
            if (svData.occupationCode != null &&
                svData.occupationCode!.isNotEmpty) {
              int index = arrOccupation.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.occupationCode);
              if (index >= 0) {
                txtOccupation.text = arrOccupation[index].description ?? '';
                objOccupation.value = arrOccupation[index];
                objOccupation.refresh();
              }
            }
            txtIndustry.text = svData.industryDescription ?? '';
            if (svData.industryCode != null &&
                svData.industryCode!.isNotEmpty) {
              int index = arrIndustry.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.industryCode);
              if (index >= 0) {
                txtIndustry.text = arrIndustry[index].description ?? '';
                objIndustry.value = arrIndustry[index];
                objIndustry.refresh();
              }
            }
            txtDesignation.text = svData.designationDescription ?? '';
            if (svData.designationCode != null &&
                svData.designationCode!.isNotEmpty) {
              int index = arrDesignation.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code != svData.designationCode!);
              if (index >= 0) {
                txtDesignation.text = arrDesignation[index].description ?? '';
                objDesignation.value = arrDesignation[index];
                devPrint("------>${arrDesignation[index].description}");
                objDesignation.refresh();
              }
            }

            txtFunction.text = svData.functionDescription ?? '';

            if (svData.functionCode != null &&
                svData.functionCode!.isNotEmpty) {
              int index = arrFunction.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code! == svData.functionCode);
              if (index >= 0) {
                txtFunction.text = arrFunction[index].description ?? '';
                objFunction.value = arrFunction[index];
                objFunction.refresh();

                */
            /* devPrint("---------->${arrFunction[index].description}");*/ /*
              }
            }
            txtCompanyName.text = svData.companyName ?? '';

            txtCompanyAddress.text = svData.companyAddress ?? '';
            txtCompanyLocation.text = svData.companyLocation ?? '';
            txtOfficeTelephone.text =
                svData.officeTelephoneCountryDescription ?? '';
            txtAnnualIncome.text = svData.annualIncomeDescription ?? '';

            txtPurchasePurpose.text = svData.purposeOfPurchaseDescription ?? '';

            if (svData.purposeOfPurchaseCode != null &&
                svData.purposeOfPurchaseCode!.isNotEmpty) {
              int index = arrPurPoseOfPurchaseList.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.purposeOfPurchaseCode);
              if (index >= 0) {
                txtPurchasePurpose.text =
                    arrPurPoseOfPurchaseList[index].description ?? '';
                objPurpose.value = arrPurPoseOfPurchaseList[index];
                objPurpose.refresh();
              }
            }

            if (svData.sourcingManagerList != null &&
                svData.sourcingManagerList!.isNotEmpty) {
              for (int i = 0; i < svData.sourcingManagerList!.length; i++) {
                arrSelectedSourcingManager.add(UserLoginDataModel(
                    employeeId: svData.sourcingManagerList![i].ownerEmpId,
                    empFormattedName:
                        svData.sourcingManagerList![i].ownerEmpName));

                arrSelectedSourcingManager.refresh();
              }
            }
            if (svData.leadRequirements != null &&
                svData.leadRequirements!.isNotEmpty) {
              txtSource.text =
                  svData.leadRequirements![0].sourceDescription ?? '';
              if (txtSource.text.isNotEmpty &&
                  svData.leadRequirements![0].sourceCode!.isNotEmpty) {
                int index = arrLeadSource.indexWhere((e) =>
                    e.code != null &&
                    e.code!.isNotEmpty &&
                    e.code == svData.leadRequirements![0].sourceCode);
                if (index >= 0) {
                  objSource.value = arrLeadSource[index];
                  objSource.refresh();
                }
              }*/

            txtTitle.text = svData.titleName ?? '';
            if (svData.titleCode != null && svData.titleCode!.isNotEmpty) {
              int index = arrTitle.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.titleCode);
              if (index >= 0) {
                txtTitle.text = arrTitle[index].description ?? '';
                objTitle.value = arrTitle[index];
                objTitle.refresh();
              }
            }
            txtFirstName.text = svData.firstName ?? '';
            txtLastName.text = svData.lastName ?? '';
            txtEmail.text = svData.email ?? '';
            txtMobileNo.text = svData.mobileNo ?? '';
            txtResAlternate.text = svData.altMobileNo ?? '';
            txtTelephoneNo.text = svData.residentialTelephoneNo ?? '';
            txtWhatsappNumber.text = svData.whatsappNo ?? '';
            txtAgeGroup.text = svData.ageGroupDescription ?? '';
            txtCompanyName.text = svData.companyName ?? '';

            if (svData.ageGroupCode != null &&
                svData.ageGroupCode!.isNotEmpty) {
              int index = arrAgeGroup.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.ageGroupCode);
              if (index >= 0) {
                txtAgeGroup.text = arrAgeGroup[index].description ?? '';
                objAgeGroup.value = arrAgeGroup[index];
                objAgeGroup.refresh();
              }
            }

            txtCurrentResidence.text = svData.currentResidenceLocation ?? '';
            txtPinCode.text = svData.pincode ?? '';
            txtSource.text = svData.sourceDescription ?? '';
            if (svData.siteVisitSourceCode != null &&
                svData.siteVisitSourceCode!.isNotEmpty) {
              int index = arrLeadSource.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.siteVisitSourceCode);
              if (index >= 0) {
                txtSource.text = arrLeadSource[index].description ?? '';
                objSource.value = arrLeadSource[index];
                objSource.refresh();
              }
            }

            if (svData.sourcingManagerList != null &&
                svData.sourcingManagerList!.isNotEmpty) {
              for (int i = 0; i < svData.sourcingManagerList!.length; i++) {
                arrSelectedSourcingManager.add(CheckInModel.fromJson({
                  "employee_id": svData.sourcingManagerList![i].ownerEmpId,
                  "emp_formatted_name":
                      svData.sourcingManagerList![i].ownerEmpName
                }));

                arrSelectedSourcingManager.refresh();
              }
            }

            //Professional Details
            txtOccupation.text = svData.occupationDescription ?? '';
            if (svData.occupationCode != null &&
                svData.occupationCode!.isNotEmpty) {
              int index = arrOccupation.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.occupationCode);
              if (index >= 0) {
                txtOccupation.text = arrOccupation[index].description ?? '';
                objOccupation.value = arrOccupation[index];
                objOccupation.refresh();
              }
            }

            txtIndustry.text = svData.industryDescription ?? '';
            if (svData.industryCode != null &&
                svData.industryCode!.isNotEmpty) {
              int index = arrIndustry.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.industryCode);
              if (index >= 0) {
                txtIndustry.text = arrIndustry[index].description ?? '';
                objIndustry.value = arrIndustry[index];
                objIndustry.refresh();
              }
            }

            txtDesignation.text = svData.designationDescription ?? '';


            txtFunction.text = svData.functionDescription ?? '';
            if (svData.functionCode != null &&
                svData.functionCode!.isNotEmpty) {
              int index = arrFunction.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.functionCode);
              if (index >= 0) {
                txtFunction.text = arrFunction[index].description ?? '';
                objFunction.value = arrFunction[index];
                objFunction.refresh();
              }
            }
            txtCompanyLocation.text = svData.companyLocation ?? '';
            txtCompanyAddress.text = svData.companyAddress ?? '';
            txtOfficeTelephone.text = svData.officeTelephoneNumber ?? '';
            txtAnnualIncome.text = svData.annualIncomeDescription ?? '';
            if (svData.annualIncomeCode != null &&
                svData.annualIncomeCode!.isNotEmpty) {
              int index = arrIncome.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.annualIncomeCode);
              if (index >= 0) {
                txtAnnualIncome.text = arrIncome[index].description ?? '';
                objIncome.value = arrIncome[index];
                devPrint('designation------>${arrIncome[index].description}');
                objIncome.refresh();
              }
            }

            txtPurchasePurpose.text = svData.purposeOfPurchaseDescription ?? '';
            if (svData.purposeOfPurchaseCode != null &&
                svData.purposeOfPurchaseCode!.isNotEmpty) {
              int index = arrPurPoseOfPurchaseList.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.purposeOfPurchaseCode);
              if (index >= 0) {
                txtPurchasePurpose.text =
                    arrPurPoseOfPurchaseList[index].description ?? '';
                objPurpose.value = arrPurPoseOfPurchaseList[index];
                objPurpose.refresh();
              }
            }

            txtSVAttendee.text = svData.svAttendeeDescription ?? '';
            if (svData.svAttendeeCode != null &&
                svData.svAttendeeCode!.isNotEmpty) {
              int index = arrAttendee.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.svAttendeeCode);
              if (index >= 0) {
                txtSVAttendee.text = arrAttendee[index].description ?? '';
                objAttendee.value = arrAttendee[index];
                objAttendee.refresh();
              }
            }

            txtConfiguration.text = svData.configurationDescription ?? '';
            if (svData.configurationCode != null &&
                svData.configurationCode!.isNotEmpty) {
              int index = arrConfiguration.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.configurationCode);
              if (index >= 0) {
                txtConfiguration.text =
                    arrConfiguration[index].description ?? '';
                objConfiguration.value = arrConfiguration[index];
                objConfiguration.refresh();
              }
            }

            txtBudget.text = svData.budgetDescription ?? '';
            if (svData.budgetCode != null && svData.budgetCode!.isNotEmpty) {
              int index = arrBudget.indexWhere((e) =>
                  e.code != null &&
                  e.code!.isNotEmpty &&
                  e.code == svData.budgetCode);
              if (index >= 0) {
                txtBudget.text = arrBudget[index].description ?? '';
                objBudget.value = arrBudget[index];
                objBudget.refresh();
              }
            }

            //Employee Reference
            txtEmployeeId.text = svData.referralEmployeeId ?? '';
            txtEmployeeName.text = svData.referralEmployeeName ?? '';
            txtEmployeeMobile.text = svData.referralEmployeeMobile ?? '';
            txtEmployeeEmail.text = svData.referralEmployeeEmail ?? '';
            //Channel Partner
            txtCpUserName.text = svData.referralCpName ?? '';
            txtCPVendorId.text = svData.referralVendorId ?? '';
            txtCPCompanyName.text = svData.referralCpCompanyName ?? '';
            /*txtCPCompanyName.text*/
            txtCPReraNo.text = svData.referralCpReraNo ?? '';
            txtExecutiveName.text = svData.referralCpExecutive ?? '';
            txtCPExecutiveMobile.text = svData.referralCpExecutiveMobile ?? '';
            txtCpUserName.text = svData.referralCpExecutive ?? '';
            //Customer Referral
            txtCustomerMobile.text = svData.referralCustomerMobile ?? '';
            txtCustomerUnitNo.text = svData.referralCustomerUnitNo ?? '';
            txtCustomerId.text = svData.referralCustomerId ?? '';
            txtCustomerName.text = svData.referralCustomerName ?? '';
            txtProjectName.text = svData.referralCustomerProjectName ?? '';
          } catch (e, x) {
            FunctionHelper.printLog(message: '------------------>$e');
            FunctionHelper.printLog(message: '------------------>$x');
          }
        }
      } else {
        removeAppLoader(Get.context!);
        showError(responseData['message']);
        if (responseData['data'] != null &&
            responseData['data'] != '' &&
            responseData['data'].length > 0) {
          // scanId.value = responseData['data'][0]['scanid'];
          // if (scanId.isNotEmpty) {
          otpVerified.value = false;
          showOtp.value = false;
          txtOtp.clear();
          // }
          Future.delayed(const Duration(milliseconds: 900), () {
            devPrint(responseData['message']);
          });
        } else {
          devPrint(responseData['message']);
        }
      }
    } catch (e) {
      //removeAppLoader(Get.context!);
      devPrint(responseData!['message']);
      devPrint('exception---$e');
    }

    return isValid;
  }

  Future<bool> addEditSvFormDetails(SVFormType type) async {


    bool isValid = false;
    // final String svattendeeCode = objAttendee.value.code ?? '';
    // final String svAttendeeDescription = objAttendee.value.description ?? '';
    final String projectName = kSelectedProject.value.projectDescription;
    final String projectCode = kSelectedProject.value.projectCode;
    appLoader(Get.context!);
    var data = {
      'lead_created_from': isMobile ? 'ACX SALES APP' : 'ACX SALES WEB',
      'annual_income_code': objIncome.value.code,
      'annual_income_description': objIncome.value.description,
      /*'designation_code': objDesignation.value.code,*/
      'current_designation': txtDesignation.text,
      'sv_attendee_code': objAttendee.value.code,
      'sv_attendee_description': objAttendee.value.description,
      '0': txtOfficeTelephone.text,
      'configuration_code': objConfiguration.value.code,
      'configuration_description': objConfiguration.value.description,
      'company_location': txtCompanyLocation.text,
      'company_address': txtCompanyAddress.text,
      'company_name': txtCompanyName.text,
      'function_code': objFunction.value.code,
      'function_description': objFunction.value.description,
      'source_code': objSource.value.code,
      'source_description': objSource.value.description,
      //"SalesOwnerPartyID": kOwnerPartyID,
      //"SalesOwnerPartyName": kOwnerPartyName,
      //"scanfrom": "preosssalesapp",
      'title_code': objTitle.value.code,
      'title_name': objTitle.value.description,
      'first_name': txtFirstName.text,
      'last_name': txtLastName.text,
      'email': txtEmail.text.toLowerCase(),
      'mobile_no': txtMobileNo.text,
      'mobile_country_code': objCountry.value.countryCode,
      //"mobile_country_str": "IN",
      'alt_mobile_no': txtResAlternate.text,
      'alt_mobile_country_code': objResCountry.value.countryCode,
      //"alt_mobile_country_str": "IN",
      'residential_telephone_no': txtTelephoneNo.text,
      'residential_telephone_no_country_code': objTelCountry.value.countryCode,
      //"residential_telephone_no_country_ste": "IN",
      'age_group_code': objAgeGroup.value.code,
      'age_group_description': objAgeGroup.value.description,
      'current_residence': txtCurrentResidence.text,
      'pincode': txtPinCode.text,
      if (arrSelectedSourcingManager.isNotEmpty)
        'sourcing_manager_list':
            arrSelectedSourcingManager.map((e) => e.toJsonCodeDesc()).toList(),
      'site_visit_source_code': objSource.value.code,
      'site_visit_source_description': objSource.value.description,
      'occupation_code': objOccupation.value.code,
      'occupation_description': objOccupation.value.description,
      'industry_code': objIndustry.value.code,
      'industry_description': objIndustry.value.description,
      'purpose_of_purchase_code': objPurpose.value.code,
      'purpose_of_purchase_description': objPurpose.value.description,
      'budget_code': objBudget.value.code,
      'budget_description': objBudget.value.description,
      'project_name': projectName,
      //  "project_description": Settings.projectData!.projectDescription ?? '',
      'project_code': projectCode,
      'role_code': CheckInModel.fromJson(jsonDecode(
              PreferenceController.getString(SharedPref.employeeDetails)))
          .roleCode,
      'created_by_emp_id':
          PreferenceController.getString(SharedPref.employeeID),
      'office_telephone_number': txtTelephoneNo.text,
      'office_telephone_country_code': objCountry.value.countryCode,
      'whatsapp_no': txtWhatsappNumber.text,
      'whatsapp_country_code': objCountry.value.countryCode,
    };
    /*dynamic professionalDetails;
    professionalDetails = {
      "company_name": txtCompanyName.text,
      "occupation_code": objOccupation.value.code,
      "occupation_description": objOccupation.value.description,
      "industry_code": objIndustry.value.code,
      "industry_description": objIndustry.value.description,
      "function_code": objFunction.value.code,
      "function_description": objFunction.value.description,
      "company_location": txtCompanyLocation.text,
      "company_address": txtCompanyAddress.text,
      "office_telephone_number": txtTelephoneNo.text,
      "office_telephone_country_code": objCountry.value.countryCode,

    };


    if (type == SVFormType.professionalDetails) {
      data.addAll(professionalDetails);
    }*/

    if (txtSource.text.toLowerCase() != 'customer reference' &&
        txtSource.text.toLowerCase() != 'employee reference' &&
        txtSource.text.toLowerCase() != 'channel partner') {
      //Employee Reference
      txtEmployeeId.clear();
      txtEmployeeName.clear();
      txtEmployeeMobile.clear();
      txtEmployeeEmail.clear();
      //Channel partner
      txtCPVendorId.clear();
      txtCPExecutiveMobile.clear();
      txtCPCompanyName.clear();
      txtCPReraNo.clear();
      //Customer Referral
      txtCustomerMobile.clear();
      txtCustomerName.clear();
      txtCustomerId.clear();
      txtCustomerUnitNo.clear();
      txtProjectName.clear();

      /* devPrint('------->OTHER');*/
    }

    if (svFormId.isNotEmpty) {
      data.addAll({'svform_id': svFormId});
    }

    if (scanId.isNotEmpty) {
      data.addAll({'scanvisitlocation_id': scanId.value});
    }

    dynamic leadSourceData;

    if (txtSource.text.toLowerCase() == 'customer reference') {
      leadSourceData = {
        'referral_customer_mobile': txtCustomerMobile.text.trim(),
        'referral_customer_unit_no': txtCustomerUnitNo.text.trim(),
        'referral_customer_id': txtCustomerId.text.trim(),
        'referral_customer_name': txtCustomerName.text.trim(),
        'referral_customer_project_name': txtProjectName.text.trim(),
      };
      //Employee Reference
      txtEmployeeId.clear();
      txtEmployeeName.clear();
      txtEmployeeMobile.clear();
      txtEmployeeEmail.clear();
      //Channel partner
      txtCPVendorId.clear();
      txtCpUserName.clear();
      txtCPExecutiveMobile.clear();
      txtCPCompanyName.clear();
      txtCPReraNo.clear();

      devPrint('------>Customer Referral');
    }
    if (txtSource.text.toLowerCase() == 'employee reference') {
      leadSourceData = {
        'referral_employee_id': txtEmployeeId.text.trim(),
        'referral_employee_name': txtEmployeeName.text.trim(),
        'referral_employee_mobile': txtEmployeeMobile.text.trim(),
        'referral_employee_email': txtEmployeeEmail.text.trim().toLowerCase(),
      };

      //Channel partner
      txtCPVendorId.clear();
      txtCpUserName.clear();
      txtCPExecutiveMobile.clear();
      txtCPCompanyName.clear();
      txtCPReraNo.clear();
      //Customer Referral
      txtCustomerMobile.clear();
      txtCustomerName.clear();
      txtCustomerId.clear();
      txtCustomerUnitNo.clear();
      txtProjectName.clear();

      devPrint('------>Employee Reference');
    }

    if (txtSource.text.toLowerCase() == 'channel partner') {
      leadSourceData = {
        'referral_vendor_id': txtCPVendorId.text.trim(),
        'referral_cp_name': txtCpUserName.text.trim(),
        'referral_cp_company_name': txtCPCompanyName.text.trim(),
        'referral_cp_rera_no': txtCPReraNo.text.trim(),
        'referral_cp_executive': txtCpUserName.text.trim(),
        'referral_cp_executive_mobile': txtCPExecutiveMobile.text.trim(),
      };
      //Customer Referral
      txtCustomerMobile.clear();
      txtCustomerName.clear();
      txtCustomerId.clear();
      txtCustomerUnitNo.clear();
      txtProjectName.clear();
      //Employee Reference
      txtEmployeeId.clear();
      txtEmployeeName.clear();
      txtEmployeeMobile.clear();
      txtEmployeeEmail.clear();

      devPrint('------>Channel Partner');
    }

    if (leadSourceData != null) data.addAll(leadSourceData);
    /*log(" Data----${jsonEncode(data)}");*/
    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: svFormId.isNotEmpty && scanId.isNotEmpty
            ? Api.apiSvFormUpdate
            : Api.apiSvFormCreate,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);
    Map<String, dynamic>? responseData = await response.getResponse();
    devPrint('Response Data <-------->$responseData');
    try {
      if (responseData!['success'] == true) {
        removeAppLoader(Get.context!);
        showSuccess(responseData['message']);
        try {
          if (responseData['data'] != null &&
              responseData['data'] != '' &&
              responseData['data'].length > 0) {
            List data1 = responseData['data'];
            if (data1.isNotEmpty) {
              isValid = true;

              svFormId = data1[0]['_id'];
              scanId.value = data1[0]['scanvisitlocation_id'];
              scanId.refresh();

              //formDataModel.value = SvFormDataModel.fromJson(data1[0]);
              token.value = data1[0]['current_visit_token'].toString();
              token.refresh();
              waitListNumber.value = data1[0]['sv_wait_list_number'].toString();
              waitListNumber.refresh();
              disableSource.value = true;
              //formDataModel.refresh();
              //fillSvFormDetails();
            }
          }
        } catch (ex, x) {
          devPrint('exception====$ex');
          devPrint('at=====$x');
        }
      } else {
        showError(responseData['message']);
        removeAppLoader(Get.context!);
      }
    } catch (e) {
      removeAppLoader(Get.context!);
      devPrint('exception---$e');
    }

    return isValid;
  }

  Future<RxList<CommonModel>> retrieveSVAttendeeData() async {
    arrAttendee = RxList([]);
    var data = {'': ''};
    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiAttendeeList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrAttendee.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrAttendee.refresh();
    }
    return arrAttendee;
  }

/*retrieveNeedLoan() {
    arrNeedLoan.value = [
      CommonModel(code: "0",description: "Yes"),
      CommonModel(code: "1",description: "No"),
    ];
  }*/
}

void fillSvFormDetail() {}

enum SVFormType {
  personalDetails,
  professionalDetails,
}

/*import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:greapp/config/utils/app_constant.dart';
import 'package:greapp/controller/CommonController/common_controller.dart';
import 'package:greapp/main.dart';
import 'package:intl/intl.dart';

import '../../config/Helper/api_response.dart';
import '../../config/Helper/event_bus.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/constant.dart';
import '../../config/utils/preference_controller.dart';
import '../../model/AgeGroupModel/age_group_model.dart';
import '../../model/ChannelPartnerModel/channel_partner_model.dart';
import '../../model/CustomerDialogViewModel/customer_dialog_view_model.dart';
import '../../model/EmployeeModel/employee_model.dart';
import '../../model/SiteVisitFormModel/title_model.dart';
import '../../model/common_model.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/custom_dialogs.dart';

class SiteVisitFormController extends GetxController {
  GlobalKey<FormState> personalDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> professionalDetailsFormKey = GlobalKey<FormState>();

  RxInt tabIndex = 0.obs;

  ///verify mobile
  TextEditingController txtMobileNo = TextEditingController();
  TextEditingController txtOtp = TextEditingController();

  FocusNode otpFocusNode = FocusNode();

  String svFormId = "";
  String scanVisitId = "";
  RxString token = "".obs;
  RxString waitListNumber = "".obs;
  RxBool otpVerified = false.obs;
  RxBool disableSource = false.obs;

  ///verify mobile
  String otpId = "";
  RxBool showOtp = false.obs;
  RxBool showReSendOtp = false.obs;
  Rx<Timer> timer = Timer.periodic(
    Duration.zero,
    (t) {},
  ).obs;
  Rx<Duration> otpTime = const Duration().obs;

  ///personal Details
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtMiddleName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtResAlternate = TextEditingController();
  TextEditingController txtTelephoneNo = TextEditingController();
  TextEditingController txtAgeGroup = TextEditingController();
  TextEditingController txtCurrentResidence = TextEditingController();
  TextEditingController txtPinCode = TextEditingController();
  TextEditingController txtSourcingManager = TextEditingController();

  ///purchase details
  TextEditingController txtBookingSource = TextEditingController();
  TextEditingController txtLeadSource = TextEditingController();
  TextEditingController txtPurchasePurpose = TextEditingController();
  TextEditingController txtHomeLoan = TextEditingController();
  TextEditingController txtSVAttendee = TextEditingController();
  TextEditingController txtBudget = TextEditingController();
  TextEditingController txtConfiguration = TextEditingController();

  RxDouble minBudget = 5000000.0.obs;
  RxDouble maxBudget = 250000000.0.obs;
  RxDouble indicatorValue = 5000000.0.obs;
  RxString indicatorValueString = "0.0".obs;
  RxString selectedSource = "".obs;

  RxList<TitleModel> arrTitle = RxList([]);
  RxList<AgeGroupModel> arrAgeGroup = RxList([]);
  RxList<EmployeeModel> arrManager = RxList([]);
  RxList<CommonModel> arrSource = RxList([]);
  RxList<CommonModel> arrPurpose = RxList([]);
  RxList<CommonModel> arrAttendee = RxList([]);
  RxList<CommonModel> arrConfiguration = RxList([]);
  RxList<CommonModel> arrNeedLoan = RxList([]);
  RxList<CommonModel> arrBudget = RxList([]);
  Rx<CommonModel> objBudget = CommonModel().obs;
  Rx<CommonModel> objDesignation = CommonModel().obs;

  ///professional Details
  TextEditingController txtOccupation = TextEditingController();
  TextEditingController txtIndustry = TextEditingController();
  TextEditingController txtDesignation = TextEditingController();
  TextEditingController txtFunction = TextEditingController();
  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtCompanyLocation = TextEditingController();
  TextEditingController txtCompanyAddress = TextEditingController();
  TextEditingController txtOfficeTelephone = TextEditingController();
  TextEditingController txtAnnualIncome = TextEditingController();

  RxList<CommonModel> arrOccupation = RxList([]);
  RxList<CommonModel> arrIndustry = RxList([]);
  RxList<CommonModel> arrDesignation = RxList([]);
  RxList<CommonModel> arrFunction = RxList([]);
  RxList<CommonModel> arrAnnualIncome = RxList([]);
  RxList<CommonModel> arrTabMenu = RxList([]);

  RxList<CustomerRefUnitModel> arrCustomerRefUnit =
      RxList(<CustomerRefUnitModel>[]);
  RxList<CustomerRefUnitModel> arrLeadCustomerRefUnit =
      RxList(<CustomerRefUnitModel>[]);
  RxList<CustomerDialogModel> arrCustomerRefSearch =
      RxList(<CustomerDialogModel>[]);
  RxList<ChannelPartnerModel> arrCPSearchData = RxList(<ChannelPartnerModel>[]);

  Rx<CommonModel> objCountry = CommonModel(countryCode: "+91", description: "IN").obs;
  CommonModel objResCountry =
      CommonModel(countryCode: "+91", description: "IN");
  CommonModel objTelCountry =
      CommonModel(countryCode: "+91", description: "IN");

  /// lead source fields
  ///  cp
  TextEditingController txtLeadCP = TextEditingController();
  TextEditingController txtLeadCPVendorId = TextEditingController();
  TextEditingController txtLeadCPExecutive = TextEditingController();
  TextEditingController txtLeadCPExecutiveMobile = TextEditingController();
  TextEditingController txtLeadCPCompanyName = TextEditingController();
  TextEditingController txtLeadCPRERANo = TextEditingController();

  ///customer
  TextEditingController txtLeadCustomerMobileSearch = TextEditingController();
  TextEditingController txtLeadCustomerId = TextEditingController();
  TextEditingController txtLeadCustomerName = TextEditingController();
  TextEditingController txtLeadUnitNo = TextEditingController();
  TextEditingController txtLeadProjectName = TextEditingController();

  ///employee
  TextEditingController txtLeadEmployeeId = TextEditingController();
  TextEditingController txtLeadEmployeeName = TextEditingController();
  TextEditingController txtLeadEmployeeMobile = TextEditingController();
  TextEditingController txtLeadEmployeeMail = TextEditingController();

  TextEditingController txtCustomerId = TextEditingController();
  TextEditingController txtCustomerMobile = TextEditingController();
  TextEditingController txtCustomerName = TextEditingController();
  TextEditingController txtCustomerUnitNo = TextEditingController();
  TextEditingController txtProjectName = TextEditingController();
  TextEditingController txtEmployeeId = TextEditingController();
  TextEditingController txtEmployeeName = TextEditingController();
  TextEditingController txtEmployeeMobile = TextEditingController();
  TextEditingController txtEmployeeEmail = TextEditingController();
  TextEditingController txtCPExecutive = TextEditingController();
  TextEditingController txtCPExecutiveMobile = TextEditingController();
  TextEditingController txtCPVendorId = TextEditingController();
  TextEditingController txtCP = TextEditingController();
  TextEditingController txtCPCompanyName = TextEditingController();
  TextEditingController txtCPRERANo = TextEditingController();
  RxList<ChannelModel> arrChannelList = RxList<ChannelModel>([]);
  TextEditingController txtChannelName = TextEditingController();
  TextEditingController txtVendorId = TextEditingController();
  TextEditingController txtCpUserName = TextEditingController();
  TextEditingController txtReraNo = TextEditingController();
  TextEditingController txtExecutiveName = TextEditingController();
  TextEditingController txtCpNumber = TextEditingController();
  Rx<ChannelModel> objChannel = ChannelModel().obs;
  TextEditingController txtCPReraNo = TextEditingController();

  void loadData() {
    isMobile ? mobileTabMenuData() : tabMenuData();
    retrieveTitle();
    retrieveAgeGroup();
    retrieveSourceData();
    retrieveSourcingManager(searchText: AppConstant.roleCodeSalesManager);
    retrievePurchasePurpose();
    retrieveSVAttendeeData();
    retrieveConfiguration();
    retrieveOccupation();
    retrieveIndustry();
    retrieveFunction();
    retrieveBudgetList();
    retrieveDesignationList();
    retrieveAnnualIncome();
    CommonController().retrieveCountry().whenComplete(() {
      objCountry.value = arrCountry.singleWhere(
          (element) => element.code?.toUpperCase() == "IN",
          orElse: () => CommonModel());
      objResCountry = objCountry.value;
      objTelCountry = objCountry.value;
    });
  }

  bool checkForm(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }

  void tabMenuData() {
    arrTabMenu.value = [
      CommonModel(code: "verify", description: "Lets Get Started"),
      CommonModel(code: "personal", description: "Personal Details"),
      CommonModel(code: "professional", description: "Professional Details"),
    ];
    arrTabMenu.refresh();
  }

  void mobileTabMenuData() {
    arrTabMenu.value = [
      CommonModel(code: "verify", description: "Verify Mobile Number"),
      CommonModel(code: "personal", description: "Personal Details"),
      CommonModel(code: "professional", description: "Professional Details"),
      // CommonModel(code: "purchase", description: "Purchase Details"),
      CommonModel(code: "success", description: "Success"),
    ];
    arrTabMenu.refresh();
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
    print('Designation list-------$responseData');
    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrDesignation.value =
          List.from(result.map((e) => CommonModel.fromJson(e)));
      arrDesignation.refresh();
    }
    print("arrDesignation.length${arrDesignation.length}");

    return arrDesignation;
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
    print('retrieveBudgetList resp-------$responseData');
    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrBudget.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrBudget.refresh();
    }
print("arrBudget.length${arrBudget.length}");
    return arrBudget;
  }

  // Future<bool> addEditSvFormDetails(SVFormType type) async {
  //   bool isValid = false;
  //
  //   appLoader(Get.context!);
  //   try {
  //     var data = {
  //       "lead_created_from":isWeb? "ACX GRE WEB":"ACX GRE APP",
  //       "svform_id": svFormId,
  //       "scanvisitlocation_id": scanVisitId,
  //       "created_by_emp_id":
  //       PreferenceController.getString(
  //           SharedPref.employeeID),
  //       "title_name": txtTitle.text,
  //       "title_code": arrTitle
  //           .singleWhere((e) => e.description == txtTitle.text,
  //           orElse: () => TitleModel())
  //           .code,
  //       "first_name": txtFirstName.text,
  //       "last_name": txtLastName.text,
  //       "mobile_no": txtMobileNo.text,
  //       "pincode": txtPinCode.text,
  //       "mobile_country_code": "+91",
  //       "alt_mobile_no": txtResAlternate.text,
  //       "alt_mobile_country_code": " +91",
  //       "email": txtEmail.text.toLowerCase(),
  //       if (txtAgeGroup.text.isNotEmpty)
  //         "age_group_code": arrAgeGroup
  //             .where((p0) => p0.description == txtAgeGroup.text)
  //             .toList()
  //             .isNotEmpty
  //             ? arrAgeGroup
  //             .where((p0) => p0.description == txtAgeGroup.text)
  //             .toList()
  //             .first
  //             .code
  //             : "",
  //       if (txtAgeGroup.text.isNotEmpty)
  //         "age_group_description": txtAgeGroup.text,
  //       "residential_telephone_no": txtTelephoneNo.text,
  //       "residential_telephone_no_country_code": "+91",
  //       "purpose_of_purchase_description": txtPurchasePurpose.text,
  //       "purpose_of_purchase_code": arrPurpose
  //           .where((p0) => p0.description == txtPurchasePurpose.text)
  //           .toList()
  //           .isNotEmpty
  //           ? arrPurpose
  //           .where((p0) => p0.description == txtPurchasePurpose.text)
  //           .toList()
  //           .first
  //           .code
  //           : "",
  //       /*if (txtSourcingManager.text.isNotEmpty) {
  //     List smList = [objSelectedSourcingManager.toJson()];
  //     data.addAll({"SourcingManagerList": smList});
  //   }*/
  //
  //       "sourcing_manager_list": List.generate(
  //           arrManager.length,
  //               (index) => {
  //             "owner_emp_id": arrManager[index].employeeId,
  //             "owner_emp_name": arrManager[index].empFormattedName,
  //           }),
  //       "svattendee": txtSVAttendee.text,
  //       "svattendee_code": arrAttendee
  //           .where((p0) => p0.description == txtSVAttendee.text)
  //           .toList()
  //           .isNotEmpty
  //           ? arrAttendee
  //           .where((p0) => p0.description == txtSVAttendee.text)
  //           .toList()
  //           .first
  //           .code
  //           : "",
  //       if (txtConfiguration.text.isNotEmpty)
  //         "configuration_code": arrConfiguration
  //             .where((p0) => p0.description == txtConfiguration.text)
  //             .toList()
  //             .isNotEmpty
  //             ? arrConfiguration
  //             .where((p0) => p0.description == txtConfiguration.text)
  //             .toList()
  //             .first
  //             .code
  //             : "",
  //       if (txtConfiguration.text.isNotEmpty)
  //         "configuration_description": txtConfiguration.text,
  //       "project_code": kSelectedProject.value.projectCode,
  //       //"latlong": [live_latlang.latitude, live_latlang.longitude],
  //       "site_visit_source_description": txtBookingSource.text,
  //       "site_visit_source_code": arrSource
  //           .where((p0) => p0.description == txtBookingSource.text)
  //           .toList()
  //           .isNotEmpty
  //           ? arrSource
  //           .where((p0) => p0.description == txtBookingSource.text)
  //           .toList()
  //           .first
  //           .code
  //           : ""
  //     };
  //
  //     dynamic professionalDetails;
  //     professionalDetails = {
  //       if (txtOccupation.text.isNotEmpty)
  //         "occupation_code": arrOccupation
  //             .where((p0) => p0.description == txtOccupation.text)
  //             .toList()
  //             .isNotEmpty
  //             ? arrOccupation
  //             .where((p0) => p0.description == txtOccupation.text)
  //             .toList()
  //             .first
  //             .code
  //             : "",
  //       if (txtOccupation.text.isNotEmpty)
  //         "occupation_description": txtOccupation.text,
  //       if (txtIndustry.text.isNotEmpty)
  //         "industry_description": txtIndustry.text.trim(),
  //       if (txtIndustry.text.isNotEmpty)
  //         "industry_code": arrIndustry
  //             .where((p0) => p0.description == txtIndustry.text)
  //             .toList()
  //             .isNotEmpty
  //             ? arrIndustry
  //             .where((p0) => p0.description == txtIndustry.text)
  //             .toList()
  //             .first
  //             .code
  //             : "",
  //       // ------------------todo: add designation list-------------------------
  //       /// if (txtDesignation.text.isNotEmpty)
  //       ///   "current_designation_text": txtDesignation.text,
  //       if (txtFunction.text.isNotEmpty)
  //         "function_description": txtFunction.text.trim(),
  //       if (txtFunction.text.isNotEmpty)
  //         "function_code": arrFunction
  //             .where((p0) => p0.description == txtFunction.text)
  //             .toList()
  //             .isNotEmpty
  //             ? arrFunction
  //             .where((p0) => p0.description == txtFunction.text)
  //             .toList()
  //             .first
  //             .code
  //             : "",
  //       if (txtCompanyName.text.isNotEmpty)
  //         "company_name": txtCompanyName.text.trim(),
  //       if (txtCompanyLocation.text.isNotEmpty)
  //         "company_location": txtCompanyLocation.text.trim(),
  //       if (txtCompanyAddress.text.isNotEmpty)
  //         "company_address": txtCompanyAddress.text.trim(),
  //       if (txtOfficeTelephone.text.isNotEmpty)
  //         "office_telephone": txtOfficeTelephone.text.trim(),
  //       if (txtAnnualIncome.text.isNotEmpty)
  //         "annual_income_description": txtAnnualIncome.text,
  //       if (txtAnnualIncome.text.isNotEmpty)
  //         "annual_income_code": arrAnnualIncome
  //             .where((p0) => p0.description == txtAnnualIncome.text)
  //             .toList()
  //             .isNotEmpty
  //             ? arrAnnualIncome
  //             .where((p0) => p0.description == txtAnnualIncome.text)
  //             .toList()
  //             .first
  //             .code
  //             : "",
  //     };
  //
  //     if (type == SVFormType.professionalDetails) {
  //       data.addAll(professionalDetails);
  //     }
  //
  //     if (svFormId.isNotEmpty) {
  //       data.addAll({"_id": svFormId});
  //     }
  //
  //     var sourceData = {
  //       if (txtBookingSource.text.toLowerCase() == "customer reference" &&
  //           txtCustomerMobile.text != "")
  //         "referral_customer_mobile": txtCustomerMobile.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "customer reference" &&
  //           txtCustomerName.text != "")
  //         "referral_customer_name": txtCustomerName.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "customer reference" &&
  //           txtCustomerId.text != "")
  //         "referral_customer_id": txtCustomerId.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "customer reference" &&
  //           txtCustomerUnitNo.text != "")
  //         "referral_customer_unit_no": txtCustomerUnitNo.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "customer reference" &&
  //           txtProjectName.text != "")
  //         "referral_customer_project_name": txtProjectName.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "employee reference" &&
  //           txtEmployeeId.text != "")
  //         "referral_employee_id": txtEmployeeId.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "employee reference" &&
  //           txtEmployeeName.text != "")
  //         "referral_employee_name": txtEmployeeName.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "employee reference" &&
  //           txtEmployeeMobile.text != "")
  //         "referral_employee_mobile": txtEmployeeMobile.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "employee reference" &&
  //           txtEmployeeEmail.text != "")
  //         "referral_employee_email": txtEmployeeEmail.text.trim().toLowerCase(),
  //       if (txtBookingSource.text.toLowerCase() == "channel partner" &&
  //           txtCPVendorId.text != "")
  //         "referral_vendor_id": txtCPVendorId.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "channel partner" &&
  //           txtCPExecutive.text != "")
  //         "referral_cp_executive": txtCPExecutive.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "channel partner" &&
  //           txtCPExecutiveMobile.text != "")
  //         "referral_cp_executive_mobile": txtCPExecutiveMobile.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "channel partner" &&
  //           txtCP.text != "")
  //         "referral_cp_name": txtCP.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "channel partner" &&
  //           txtCPCompanyName.text != "")
  //         "referral_cp_company_name": txtCPCompanyName.text.trim(),
  //       if (txtBookingSource.text.toLowerCase() == "channel partner" &&
  //           txtCPRERANo.text != "")
  //         "referral_cp_rera_no": txtCPRERANo.text.trim(),
  //       "purchasedetails_source": txtBookingSource.text,
  //       "purchasedetails_source_code": arrSource
  //           .where((p0) => p0.description == txtBookingSource.text)
  //           .toList()
  //           .isNotEmpty
  //           ? arrSource
  //           .where((p0) => p0.description == txtBookingSource.text)
  //           .toList()
  //           .first
  //           .code
  //           : "",
  //     };
  //     data.addAll(sourceData);
  //
  //     if (txtBookingSource.text.isNotEmpty) {
  //       data.addAll({
  //         "first_lead_souce_text": txtBookingSource.text,
  //         "first_lead_source_code": arrSource
  //             .where((p0) => p0.description == txtBookingSource.text)
  //             .toList()
  //             .isNotEmpty
  //             ? arrSource
  //             .where((p0) => p0.description == txtBookingSource.text)
  //             .toList()
  //             .first
  //             .code
  //             : ""
  //       });
  //     }
  //
  //     if (svFormId.isNotEmpty) {
  //       data.addAll({"_id": svFormId});
  //     }
  //     print(
  //         "requesting to --->${svFormId != "" && scanVisitId != "" ? Api.apiSvFormUpdate : Api.apiSvFormCreate}");
  //     ApiResponse response = ApiResponse(
  //         data: data,
  //         baseUrl: svFormId != "" && scanVisitId != ""
  //             ? Api.apiSvFormUpdate
  //             : Api.apiSvFormCreate,
  //         apiHeaderType: ApiHeaderType.content,
  //         apiMethod: ApiMethod.post);
  //     Map<String, dynamic>? responseData = await response.getResponse();
  //     log(" Data----${jsonEncode(data)}");
  //     log("Response Data----$responseData");
  //
  //     if (responseData!['success'] == true) {
  //       removeAppLoader(Get.context!);
  //       showSuccess(responseData['message']);
  //       try {
  //         if (responseData['data'] != null &&
  //             responseData['data'] != "" &&
  //             responseData['data'].length > 0) {
  //           List data1 = responseData['data'];
  //           if (data1.isNotEmpty) {
  //             isValid = true;
  //             eventBus.fire(SVCountEvent());
  //
  //             svFormId = data1[0]["scanVisitLocation"][0]["svform_id"];
  //             scanVisitId = data1[0]["scanVisitLocation"][0]["_id"];
  //
  //             token.value = data1[0]["scanVisitLocation"][0]
  //             ["current_visit_token"]
  //                 .toString();
  //             waitListNumber.value = data1[0]["scanVisitLocation"][0]
  //             ["sv_wait_list_number"]
  //                 .toString();
  //           }
  //         }
  //       } catch (ex, x) {
  //         log("exception====$ex");
  //         log("at=====$x");
  //       }
  //     } else {
  //       showError(responseData['message']);
  //       removeAppLoader(Get.context!);
  //     }
  //   } catch (e, stack) {
  //     removeAppLoader(Get.context!);
  //     log("exception---$e---${stack}");
  //   }
  //
  //   return isValid;
  // }

  Future<bool> addEditSvFormDetails(SVFormType type) async {
    bool isValid = false;

    appLoader(Get.context!);
    try {
      var data = {
        "lead_created_from": isWeb ? "ACX GRE WEB" : "ACX GRE APP",
        "created_by_emp_id":
            PreferenceController.getString(SharedPref.employeeID),
        "svform_id":svFormId,
        "scanvisitlocation_id":scanVisitId,
        "first_name": txtFirstName.text,
        "last_name": txtLastName.text,
        "mobile_country_code": objCountry.value.code.toString(),
        "mobile_no": txtMobileNo.text,
        "alt_mobile_country_code": objResCountry.code.toString(),
        "residential_telephone_no_country_code": objTelCountry.code.toString(),
        "residential_telephone_no": txtTelephoneNo.text,
        "email": txtEmail.text.toLowerCase(),
        "title_code": arrTitle
            .singleWhere((e) => e.description == txtTitle.text,
                orElse: () => TitleModel())
            .code,
        "title_name": txtTitle.text,
        "current_residence_location": txtCurrentResidence.text,
        "pincode": txtPinCode.text,
        "age_group_code": arrAgeGroup
                .where((p0) => p0.description == txtAgeGroup.text)
                .toList()
                .isNotEmpty
            ? arrAgeGroup
                .where((p0) => p0.description == txtAgeGroup.text)
                .toList()
                .first
                .code
            : "",
        "age_group_description": txtAgeGroup.text,
        "occupation_code": arrOccupation
                .where((p0) => p0.description == txtOccupation.text)
                .toList()
                .isNotEmpty
            ? arrOccupation
                .where((p0) => p0.description == txtOccupation.text)
                .toList()
                .first
                .code
            : "",
        "occupation_description": txtOccupation.text,
        "purpose_of_purchase_code": arrPurpose
                .where((p0) => p0.description == txtPurchasePurpose.text)
                .toList()
                .isNotEmpty
            ? arrPurpose
                .where((p0) => p0.description == txtPurchasePurpose.text)
                .toList()
                .first
                .code
            : "",
        "purpose_of_purchase_description": txtPurchasePurpose.text,
        "configuration_code": arrConfiguration
                .where((p0) => p0.description == txtConfiguration.text)
                .toList()
                .isNotEmpty
            ? arrConfiguration
                .where((p0) => p0.description == txtConfiguration.text)
                .toList()
                .first
                .code
            : "",
        "configuration_description": txtConfiguration.text,
        "industry_code": arrIndustry
                .where((p0) => p0.description == txtIndustry.text)
                .toList()
                .isNotEmpty
            ? arrIndustry
                .where((p0) => p0.description == txtIndustry.text)
                .toList()
                .first
                .code
            : "",
        "industry_description": txtIndustry.text.trim(),
        'budget_code': objBudget.value.code,
        'budget_description': objBudget.value.description,
        "function_code": arrFunction
                .where((p0) => p0.description == txtFunction.text)
                .toList()
                .isNotEmpty
            ? arrFunction
                .where((p0) => p0.description == txtFunction.text)
                .toList()
                .first
                .code
            : "",
        "function_description": txtFunction.text.trim(),
        "annual_income_code": arrAnnualIncome
                .where((p0) => p0.description == txtAnnualIncome.text)
                .toList()
                .isNotEmpty
            ? arrAnnualIncome
                .where((p0) => p0.description == txtAnnualIncome.text)
                .toList()
                .first
                .code
            : "",
        "annual_income_description": txtAnnualIncome.text,
        'designation_code': objDesignation.value.code,
        'designation_description': objDesignation.value.description,

        "company_name": txtCompanyName.text.trim(),
        "project_code": kSelectedProject.value.projectCode,
        "project_name": kSelectedProject.value.projectDescription,
        "site_visit_source_code": arrSource
                .where((p0) => p0.description == txtBookingSource.text)
                .toList()
                .isNotEmpty
            ? arrSource
                .where((p0) => p0.description == txtBookingSource.text)
                .toList()
                .first
                .code
            : "",
        "site_visit_source_description": txtBookingSource.text,
      };

      print(
          "requesting to --->${svFormId != "" && scanVisitId != "" ? Api.apiSvFormUpdate : Api.apiSvFormCreate}");
      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: svFormId != "" && scanVisitId != ""
              ? Api.apiSvFormUpdate
              : Api.apiSvFormCreate,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic>? responseData = await response.getResponse();
      log(" Data----${jsonEncode(data)}");
      log("Response Data----$responseData");

      if (responseData!['success'] == true) {
        removeAppLoader(Get.context!);
        showSuccess(responseData['message']);
        try {
          if (responseData['data'] != null &&
              responseData['data'] != "" &&
              responseData['data'].length > 0) {
            List data1 = responseData['data'];
            if (data1.isNotEmpty) {
              isValid = true;
              eventBus.fire(SVCountEvent());

              svFormId = data1[0]["_id"];
              scanVisitId = data1[0]["scanvisitlocation_id"];

              token.value = data1[0]["current_visit_token"].toString();
              waitListNumber.value = data1[0]["sv_wait_list_number"].toString();
            }
          }
        } catch (ex, x) {
          log("exception====$ex");
          log("at=====$x");
        }
      } else {
        showError(responseData['message']);
        removeAppLoader(Get.context!);
      }
    } catch (e, stack) {
      removeAppLoader(Get.context!);
      log("exception---$e---${stack}");
    }

    return isValid;
  }


  Future<RxList<ChannelModel>> getChannelList() async {
    var data = {
      'page': '1',
      'size': '20',
    };

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.channelPartnerListUrl,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();

    print("----->${responseData?["data"]}");
    try {
      if (responseData != null) {
        if (responseData['success'] == true) {
          if (responseData['data'] != null && responseData['data'].length > 0) {
            List result = responseData['data'];
            arrChannelList.value =
                List.from(result.map((e) => ChannelModel.fromJson(e)));
            arrChannelList.refresh();
          }
        }
      } else {
        showError('=erorrr==>' + responseData?['message']);
      }
    } catch (e, x) {
      print('get error------------$e');
      print('get error x------------$x');
    }

    return arrChannelList;
  }

  Future<Rx<ChannelModel>> getChannelSearch() async {
    var data = {'page': '1', 'size': '20', 'search': txtCpUserName.text};

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.channelPartnerListUrl,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);

    Map<String, dynamic>? responseData = await response.getResponse();

    print("----->${responseData?["data"]}");
    try {
      if (responseData != null) {
        if (responseData['success'] == true) {
          if (responseData['data'] != null && responseData['data'].length > 0) {
            objChannel.value = ChannelModel.fromJson(responseData['data'][0]);
            txtCpUserName.text = objChannel.value.firstName!;
            txtCPVendorId.text = objChannel.value.vendorId!;
            txtCPCompanyName.text = objChannel.value.companyDescription!;
            txtCPReraNo.text = objChannel.value.reraNumber!;
            txtCPExecutiveMobile.text = objChannel.value.mobileNo!;

            print('------->${txtCpUserName.text}');
            print('------->${txtCPVendorId.text}');
            print('------->${txtCpUserName.text}');
            print('------->${txtCpUserName.text}');
            print('------->${txtCpUserName.text}');
          }
        }
      } else {
        showError('=erorrr==>' + responseData?['message']);
      }
    } catch (e, x) {
      print('get error------------$e');
      print('get error x------------$x');
    }

    return objChannel;
  }


  String? validation(String? value, String message) {
    if (value!.trim().isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  indicatorValueChange(double value) {
    indicatorValue.value = value;
    String label = formatValue(indicatorValue.value);
    if (label.contains("T")) {
      label = label.replaceAll("T", "K");
    }
    indicatorValueString.value = label.toString().replaceAll('₹ ', '');
    log("indicatorValue.value-----${indicatorValue.value}");
    log("indicatorValueString.value-----${indicatorValueString.value}");
    indicatorValue.refresh();
  }

  String formatValue(double value) {
    double crore = value / 10000000;
    return '${NumberFormat('#,##,###.##').format(crore)} Cr';
  }

  Future<void> sendOTP() async {
    appLoader(Get.context!);

    var data = {
      "mobile_no": txtMobileNo.text.trim(),
      "country_code": objCountry.value.countryCode.toString(),
      "mobile_country_code": objCountry.value.code.toString(),
      "project_code": kSelectedProject.value.projectCode
    };

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiSvFormSendOTP,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);
    Map<String, dynamic>? responseData;
    try {
      responseData = await response.getResponse();
      log("sv form otp send---------${jsonEncode(data)}");
      log("sv form otp responseData---------$responseData");
      if (responseData!['success'] == true) {
        removeAppLoader(Get.context!);
        showSuccess(responseData['message'] +
            " \nOTP: ${responseData['data'][0]['otp']}");
        if (responseData['data'] != null &&
            responseData['data'] != "" &&
            responseData['data'].length > 0) {
          otpId = responseData['data'][0]['_id'].toString();
          if (otpId.isNotEmpty) {
            showOtp.value = true;
            showReSendOtp.value = false;
            showOtp.refresh();
            otpTime.value = const Duration(seconds: 30);
            timer = Timer.periodic(const Duration(seconds: 1), (_) {
              if (otpTime.value.inSeconds == 0) {
                showReSendOtp.value = true;
              } else {
                otpTime.value = Duration(seconds: otpTime.value.inSeconds - 1);
              }
            }).obs;
          }
          log(responseData['message']);
        } else {
          log(responseData['message']);
        }
      } else {
        removeAppLoader(Get.context!);
        showError(responseData['message']);
      }
    } catch (e, x) {
      removeAppLoader(Get.context!);
      log(responseData!['message']);
      log("exception---$e");
      log("exception x---$x");
    }
  }

  Future<bool> verifyOtp() async {
    bool isValid = false;

    Map<String, dynamic>? responseData;
    appLoader(Get.context!);
    try {
      var data = {
        "_id": otpId,
        "otp": txtOtp.text.trim().toString(),
        // "sitecode": kLocationCode,
        "created_by_emp_id":
            PreferenceController.getString(SharedPref.employeeID)
      };
      log("sv form otp verify data---------$data");
      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.apiSvFormVerifyOTP,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      responseData = await response.getResponse();
      if (kDebugMode) {
        print("sv form otp verify res---------$responseData");
      }

      if (responseData!['success'] == true) {
        removeAppLoader(Get.context!);
        showSuccess(responseData['message']);
        isValid = true;
        otpVerified.value = true;
      } else {
        removeAppLoader(Get.context!);
        showError(responseData['message']);
        if (responseData['data'] != null &&
            responseData['data'] != "" &&
            responseData['data'].length > 0) {
          showOtp.value = false;
          txtOtp.clear();
          log(responseData['message']);
        } else {
          log(responseData['message']);
        }
      }
    } catch (e) {
      removeAppLoader(Get.context!);
      log(responseData!['message']);
      log("exception---$e");
    }

    return isValid;
  }

  Future<RxList<TitleModel>> retrieveTitle() async {
    arrTitle = RxList([]);
    var data = {'': ''};
    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiTitleList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrTitle.value = List.from(result.map((e) => TitleModel.fromJson(e)));
      arrTitle.refresh();
    }
    return arrTitle;
  }

  Future<RxList<AgeGroupModel>> retrieveAgeGroup() async {
    arrAgeGroup = RxList([]);
    var data = {'': ''};

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiAgeGroupList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    if (responseData!['success'] == true) {
      // List result = responseData['data'];
      arrAgeGroup.value = AgeGroupBaseModel.fromJson(responseData).data;
      arrAgeGroup.refresh();
    }

    return arrAgeGroup;
  }

  Future<RxList<EmployeeModel>> retrieveSourcingManager(
      {required String searchText}) async {
    try {
      arrManager.value = RxList([]);
      var data = {
        "page": "1",
        "size": "2000",
        "search": searchText,
        "Role": [
          "Sales Manager",
          "Sales Head",
          "Project Head",
          "Cluster Head",
          "Pre-sales Manager",
          "Pre-sales Head",
          "Partner Head",
          "Partner Team Lead",
          "Business Admin",
          "Team Leader",
          "Partner Manager"
        ],
      };
      ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiEmployeeList,
        apiHeaderType: ApiHeaderType.content,
      );

      Map<String, dynamic>? responseData = await response.getResponse();
      log(responseData.toString());

      if (responseData!['success'] == true) {
        arrManager.value = EmployeeBaseModel.fromJson(responseData).data;
        print(arrManager.length);
        print("arrManager.length");
        arrManager.refresh();
      } else {
        log(responseData['message']);
      }
    } catch (e) {
      log("$e ERROR in search manager");
    }
    return arrManager;
  }

  Future<RxList<CommonModel>> retrieveSourceData() async {
    arrSource = RxList([]);
    var data = {'': ''};

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiSourceList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrSource.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrSource.refresh();
    }
    return arrSource;
  }

  Future<RxList<CommonModel>> retrievePurchasePurpose() async {
    arrPurpose = RxList([]);
    var data = {'': ''};

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiPurchasePurposeList,
      apiHeaderType: ApiHeaderType.content,
    );

    Map<String, dynamic>? responseData = await response.getResponse();

    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrPurpose.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrPurpose.refresh();
    }

    return arrPurpose;
  }

  Future<RxList<CommonModel>> retrieveSVAttendeeData() async {
    arrAttendee = RxList([]);
    var data = {'': ''};
    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiAttendeeList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrAttendee.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrAttendee.refresh();
    }
    return arrAttendee;
  }

  Future<RxList<CommonModel>> retrieveConfiguration() async {
    arrConfiguration = RxList([]);
    Map<String, dynamic> data = {};

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiConfigurationList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();

    log("configuration-----$responseData");

    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrConfiguration.value =
          List.from(result.map((e) => CommonModel.fromJson(e)));
      arrConfiguration.refresh();
    }

    return arrConfiguration;
  }

  Future<RxList<CommonModel>> retrieveOccupation() async {
    arrOccupation = RxList([]);
    var data = {'': ''};

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiOccupationList,
        apiHeaderType: ApiHeaderType.content);
    Map<String, dynamic>? responseData = await response.getResponse();

    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrOccupation.value =
          List.from(result.map((e) => CommonModel.fromJson(e)));
      arrOccupation.refresh();
    }

    return arrOccupation;
  }

  Future<RxList<CommonModel>> retrieveIndustry() async {
    arrIndustry = RxList([]);
    var data = {'': ''};

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiIndustryList,
        apiHeaderType: ApiHeaderType.content);
    Map<String, dynamic>? responseData = await response.getResponse();

    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrIndustry.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrIndustry.refresh();
    }

    return arrIndustry;
  }

  Future<RxList<CommonModel>> retrieveFunction() async {
    arrFunction = RxList([]);
    var data = {'': ''};
    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiFunctionList,
        apiHeaderType: ApiHeaderType.content);
    Map<String, dynamic>? responseData = await response.getResponse();

    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrFunction.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrFunction.refresh();
    }
    return arrFunction;
  }

  Future<RxList<CommonModel>> retrieveAnnualIncome() async {
    arrAnnualIncome = RxList([]);
    var data = {'': ''};
    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiAnnualIncomeList,
        apiHeaderType: ApiHeaderType.content);
    Map<String, dynamic>? responseData = await response.getResponse();

    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrAnnualIncome.value =
          List.from(result.map((e) => CommonModel.fromJson(e)));
      arrAnnualIncome.refresh();
    }

    return arrAnnualIncome;
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
    log("CustomerRefUnitList data----------$data");
    log("CustomerRefUnitList responseData----------$responseData");
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

  Future<RxList<CustomerDialogModel>> retrieveCustomerRefSearchData(
      String customerMobPhNumber,
      [String materialID = ""]) async {
    arrCustomerRefSearch = RxList([]);
    var data = {
      'CustMobPhNumber': customerMobPhNumber.trim(),
      if (materialID.isNotEmpty) "MaterialID": materialID
    };
    log("customer search data-----$data");

    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiCustomerRefSearchList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();

    log("customer search response-----$responseData");

    if (responseData?['success'] == true) {
      List result = responseData?['data'];
      arrCustomerRefSearch.value =
          List.from(result.map((e) => CustomerDialogModel.fromJson(e)));
      arrCustomerRefSearch.refresh();
    } else {}

    return arrCustomerRefSearch;
  }

  employeeDetailsApi(isLeadSource) async {
    var data = {
      "EmployeeID": isLeadSource
          ? txtLeadEmployeeId.text.trim()
          : txtEmployeeId.text.trim(),
    };
    log("data-----------$data");
    ApiResponse response = ApiResponse(
      data: data,
      baseUrl: Api.apiEmployeeDetailList,
      apiHeaderType: ApiHeaderType.content,
    );
    Map<String, dynamic>? responseData = await response.getResponse();
    log("response data-------------$responseData");
    if (responseData != null) {
      if (responseData['success'] == true) {
        if (responseData['data'] != null && responseData['data'].length > 0) {
          if (isLeadSource) {
            txtLeadEmployeeName.text = responseData['data'][0]['FirstName'] +
                " " +
                responseData['data'][0]['LastName'];
            txtLeadEmployeeMobile.text = responseData['data'][0]['Mobile_No'];
            txtLeadEmployeeMail.text = responseData['data'][0]['EmailURI'];
            txtLeadEmployeeMail.text = txtLeadEmployeeMail.text.toLowerCase();
            //fill same details in booking source
            txtEmployeeName.text = responseData['data'][0]['FirstName'] +
                " " +
                responseData['data'][0]['LastName'];
            txtEmployeeMobile.text = responseData['data'][0]['Mobile_No'];
            txtEmployeeEmail.text =
                responseData['data'][0]['EmailURI'].toString().toLowerCase();
          } else {
            txtEmployeeName.text = responseData['data'][0]['FirstName'] +
                " " +
                responseData['data'][0]['LastName'];
            txtEmployeeMobile.text = responseData['data'][0]['Mobile_No'];
            txtEmployeeEmail.text = responseData['data'][0]['EmailURI'];
            txtEmployeeEmail.text = txtEmployeeEmail.text.toLowerCase();
          }
        } else {
          if (isLeadSource) {
            txtLeadEmployeeMail.clear();
            txtLeadEmployeeName.clear();
            txtLeadEmployeeMobile.clear();
          } else {
            txtEmployeeName.text = "";
            txtEmployeeMobile.text = "";
            txtEmployeeEmail.text = "";
          }
        }
      } else {
        if (isLeadSource) {
          txtLeadEmployeeMail.clear();
          txtLeadEmployeeName.clear();
          txtLeadEmployeeMobile.clear();
        } else {
          txtEmployeeName.text = "";
          txtEmployeeMobile.text = "";
          txtEmployeeEmail.text = "";
        }
      }
    } else {}
  }

  Future<RxList<ChannelPartnerModel>> retrieveCPSearchData(
      String searchText) async {
    arrCPSearchData = RxList([]);
    var data = {
      'search': searchText,
      'ProjectID': kLocationCode,
    };

    log("cp search dialog data------${jsonEncode(data)}");

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiCPSearch,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);
    Map<String, dynamic>? responseData = await response.getResponse();

    log("cp search dialog res------$responseData");

    if (responseData!['success'] == true) {
      List result = responseData['data'];
      arrCPSearchData.value =
          List.from(result.map((e) => ChannelPartnerModel.fromJson(e)));
      arrCPSearchData.refresh();
    }

    return arrCPSearchData;
  }

  void commonNextTap() {
    if (tabIndex.value < 3) {
      if (tabIndex.value == 1 &&
          personalDetailsFormKey.currentState!.validate()) {
        tabIndex.value = 1;
      }
    }
    if (tabIndex.value == 1 &&
        personalDetailsFormKey.currentState!.validate()) {
      addEditSvFormDetails(SVFormType.personalDetails).then((value) {
        if (value) {
          tabIndex.value = 2;
          tabIndex.refresh();
        }
      });
    }
    if (tabIndex.value == 2 &&
        professionalDetailsFormKey.currentState!.validate()) {
      addEditSvFormDetails(SVFormType.professionalDetails).then((value) {
        if (value) {
          tabIndex.value = 3;
          tabIndex.refresh();
        }
      });
    }
    tabIndex.refresh();
  }
}

enum SVFormType {
  personalDetails,
  professionalDetails,
}
*/
// Future<bool> addEditSvFormDetails(SVFormType type) async {
//   bool isValid = false;
//
//   appLoader(Get.context!);
//   try {
//     var data = {
//       "lead_created_from": isWeb ? "ACX GRE WEB" : "ACX GRE APP",
//       "created_by_emp_id":
//       PreferenceController.getString(SharedPref.employeeID),
//       "svform_id":svFormId,
//       "scanvisitlocation_id":scanVisitId,
//       "first_name": txtFirstName.text,
//       "last_name": txtLastName.text,
//       "mobile_country_code": objCountry.value.code.toString(),
//       "mobile_no": txtMobileNo.text,
//       "alt_mobile_country_code": objResCountry.code.toString(),
//       "residential_telephone_no_country_code": objTelCountry.code.toString(),
//       "residential_telephone_no": txtTelephoneNo.text,
//       "email": txtEmail.text.toLowerCase(),
//       "title_code": arrTitle
//           .singleWhere((e) => e.description == txtTitle.text,
//           orElse: () => TitleModel())
//           .code,
//       "title_name": txtTitle.text,
//       "current_residence_location": txtCurrentResidence.text,
//       "pincode": txtPinCode.text,
//       "age_group_code": arrAgeGroup
//           .where((p0) => p0.description == txtAgeGroup.text)
//           .toList()
//           .isNotEmpty
//           ? arrAgeGroup
//           .where((p0) => p0.description == txtAgeGroup.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "age_group_description": txtAgeGroup.text,
//       "occupation_code": arrOccupation
//           .where((p0) => p0.description == txtOccupation.text)
//           .toList()
//           .isNotEmpty
//           ? arrOccupation
//           .where((p0) => p0.description == txtOccupation.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "occupation_description": txtOccupation.text,
//       "purpose_of_purchase_code": arrPurpose
//           .where((p0) => p0.description == txtPurchasePurpose.text)
//           .toList()
//           .isNotEmpty
//           ? arrPurpose
//           .where((p0) => p0.description == txtPurchasePurpose.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "purpose_of_purchase_description": txtPurchasePurpose.text,
//       "configuration_code": arrConfiguration
//           .where((p0) => p0.description == txtConfiguration.text)
//           .toList()
//           .isNotEmpty
//           ? arrConfiguration
//           .where((p0) => p0.description == txtConfiguration.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "configuration_description": txtConfiguration.text,
//       "industry_code": arrIndustry
//           .where((p0) => p0.description == txtIndustry.text)
//           .toList()
//           .isNotEmpty
//           ? arrIndustry
//           .where((p0) => p0.description == txtIndustry.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "industry_description": txtIndustry.text.trim(),
//       'budget_code': objBudget.value.code,
//       'budget_description': objBudget.value.description,
//       "function_code": arrFunction
//           .where((p0) => p0.description == txtFunction.text)
//           .toList()
//           .isNotEmpty
//           ? arrFunction
//           .where((p0) => p0.description == txtFunction.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "function_description": txtFunction.text.trim(),
//       "annual_income_code": arrAnnualIncome
//           .where((p0) => p0.description == txtAnnualIncome.text)
//           .toList()
//           .isNotEmpty
//           ? arrAnnualIncome
//           .where((p0) => p0.description == txtAnnualIncome.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "annual_income_description": txtAnnualIncome.text,
//       'designation_code': objDesignation.value.code,
//       'designation_description': objDesignation.value.description,
//
//       "company_name": txtCompanyName.text.trim(),
//       "project_code": kSelectedProject.value.projectCode,
//       "project_name": kSelectedProject.value.projectDescription,
//       "site_visit_source_code": arrSource
//           .where((p0) => p0.description == txtBookingSource.text)
//           .toList()
//           .isNotEmpty
//           ? arrSource
//           .where((p0) => p0.description == txtBookingSource.text)
//           .toList()
//           .first
//           .code
//           : "",
//       "site_visit_source_description": txtBookingSource.text,
//     };
//
//     print(
//         "requesting to --->${svFormId != "" && scanVisitId != "" ? Api.apiSvFormUpdate : Api.apiSvFormCreate}");
//     ApiResponse response = ApiResponse(
//         data: data,
//         baseUrl: svFormId != "" && scanVisitId != ""
//             ? Api.apiSvFormUpdate
//             : Api.apiSvFormCreate,
//         apiHeaderType: ApiHeaderType.content,
//         apiMethod: ApiMethod.post);
//     Map<String, dynamic>? responseData = await response.getResponse();
//     log(" Data----${jsonEncode(data)}");
//     log("Response Data----$responseData");
//
//     if (responseData!['success'] == true) {
//       removeAppLoader(Get.context!);
//       showSuccess(responseData['message']);
//       try {
//         if (responseData['data'] != null &&
//             responseData['data'] != "" &&
//             responseData['data'].length > 0) {
//           List data1 = responseData['data'];
//           if (data1.isNotEmpty) {
//             isValid = true;
//             eventBus.fire(SVCountEvent());
//
//             svFormId = data1[0]["_id"];
//             scanVisitId = data1[0]["scanvisitlocation_id"];
//
//             token.value = data1[0]["current_visit_token"].toString();
//             waitListNumber.value = data1[0]["sv_wait_list_number"].toString();
//           }
//         }
//       } catch (ex, x) {
//         log("exception====$ex");
//         log("at=====$x");
//       }
//     } else {
//       showError(responseData['message']);
//       removeAppLoader(Get.context!);
//     }
//   } catch (e, stack) {
//     removeAppLoader(Get.context!);
//     log("exception---$e---${stack}");
//   }
//
//   return isValid;
// }
