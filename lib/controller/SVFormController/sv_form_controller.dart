import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:greapp/main.dart';
import 'package:intl/intl.dart';

import '../../config/Helper/api_response.dart';
import '../../config/Helper/common_api.dart';
import '../../config/Helper/event_bus.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/constant.dart';
import '../../model/AgeGroupModel/age_group_model.dart';
import '../../model/CustomerDialogViewModel/CustomerDialogViewModel.dart';
import '../../model/EmployeeModel/employee_model.dart';
import '../../model/ProfileModel/profile_model.dart';
import '../../model/SiteVisitFormModel/title_model.dart';
import '../../model/common_model.dart';
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
  RxString scanId = "".obs;
  String svFormId = "";
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

  CommonModel objCountry = CommonModel(countryCode: "+91", description: "IN");
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

  void loadData() {
    isMobile ? mobileTabMenuData() : tabMenuData();
    retrieveTitle();
    retrieveAgeGroup();
    retrieveSourceData();
    retrieveSourcingManager(searchText: 'Sales Manager');
    retrievePurchasePurpose();
    retrieveSVAttendeeData();
    retrieveConfiguration();
    retrieveNeedLoan();
    retrieveOccupation();
    retrieveIndustry();
    retrieveFunction();
    retrieveAnnualIncome();
    retrieveCountry().whenComplete(() {
      objCountry = arrCountry.singleWhere(
          (element) => element.code?.toUpperCase() == "IN",
          orElse: () => CommonModel());
      objResCountry = objCountry;
      objTelCountry = objCountry;
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
      // "SalesOwnerPartyID": kOwnerPartyID,
      // "SalesOwnerPartyName": kOwnerPartyName,
      // "Mobile_No": txtMobileNo.text.trim(),
      // "Mobile_CountryCode": "+91",
      // "Mobile_CountryISOCode": "IN",
      "mobile_no": txtMobileNo.text.trim(),
    };

    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiSvFormSendOTP,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);
    Map<String, dynamic>? responseData = await response.getResponse();
    log("sv form otp send---------${jsonEncode(data)}");
    log("sv form otp responseData---------$responseData");
    try {
      if (responseData!['success'] == true) {
        removeAppLoader(Get.context!);
        showSuccess(responseData['message']);
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
        "SalesOwnerPartyID": kOwnerPartyID,
        "SalesOwnerPartyName": kOwnerPartyName,
        "_id": otpId,
        "otp": txtOtp.text.trim().toString(),
        "sitecode": kLocationCode,
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
          scanId.value = responseData['data'][0]['scanid'];
          if (scanId.isNotEmpty) {
            showOtp.value = false;
            txtOtp.clear();
          }
          Future.delayed(const Duration(milliseconds: 900), () {
            log(responseData!['message']);
          });
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
        "page" : "1",
        "size":"20",
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
        baseUrl: Api.apiSourcingManagerList,
        apiHeaderType: ApiHeaderType.content,
      );

      Map<String, dynamic>? responseData = await response.getResponse();
      log(responseData.toString());

      if (responseData!['success'] == true) {
        arrManager.value =
            EmployeeBaseModel.fromJson(responseData).data;
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

  retrieveNeedLoan() {
    arrNeedLoan.value = [
      CommonModel(code: "0", description: "Yes"),
      CommonModel(code: "1", description: "No"),
    ];
  }

  Future<RxList<CommonModel>> retrieveConfiguration() async {
    arrConfiguration = RxList([]);
    Map<String, dynamic> data = { };

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
      //apiMethod: ApiMethod.post
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
/*
  Future<bool> addEditSvFormDetails(SVFormType type) async {
    bool isValid = false;

    appLoader(Get.context!);
    try {
      var data = {
        "project_description":commonSelectedProject.value.projectDescription,
        "first_name": txtFirstName.text,
        "last_name": txtLastName.text,
        "mobile_no": txtMobileNo.text,
        "permanentaddress_pincode": txtPinCode.text,
        "mobile_country_code": "+91",
        "personaldetails_mobileno_countrycodetext": "IN",
        "personaldetails_alternatemobileno": txtResAlternate.text,
        "personaldetails_alternatemobileno_countrycode": " +91",
        "personaldetails_alternatemobileno_countrycodetext": "IN",
        "email": txtEmail.text.toLowerCase(),
        if (txtAgeGroup.text.isNotEmpty)
          "personaldetails_age_code": arrAgeGroup
              .singleWhere((e) => e.description == txtAgeGroup.text,
                  orElse: () => AgeGroupModel())
              .code,
        if (txtAgeGroup.text.isNotEmpty)
          "personaldetails_age": txtAgeGroup.text,
        "personaldetails_telephonenumber": txtTelephoneNo.text,
        "purchasedetails_purpose": txtPurchasePurpose.text,
        "purchasedetails_purpose_code": arrPurpose
            .singleWhere((e) => e.description == txtPurchasePurpose.text,
                orElse: () => CommonModel())
            .code,
        "purchasedetails_question": "No",
        "svattendee": txtSVAttendee.text,
        "svattendee_code": arrAttendee
            .singleWhere((e) => e.description == txtSVAttendee.text,
                orElse: () => CommonModel())
            .code,
        if (txtConfiguration.text.isNotEmpty)
          "TypeOfFlat_KUT": arrConfiguration
              .singleWhere((e) => e.description == txtConfiguration.text,
                  orElse: () => CommonModel())
              .code,
        if (txtConfiguration.text.isNotEmpty)
          "TypeOfFlat_KUTText": txtConfiguration.text,
        "sitecode": kLocationCode,
        if (scanId.value.isNotEmpty) "scanid": scanId.value,
        //"latlong": [live_latlang.latitude, live_latlang.longitude],
        "source_description": txtBookingSource.text,
        "purchasedetails_source_code": arrSource
            .singleWhere((e) => e.description == txtBookingSource.text,
                orElse: () => CommonModel())
            .code
      };

      dynamic professionalDetails;
      professionalDetails = {
        if (txtOccupation.text.isNotEmpty)
          "OccupationCode": arrOccupation
              .singleWhere((e) => e.description == txtOccupation.text,
                  orElse: () => CommonModel())
              .code,
        if (txtOccupation.text.isNotEmpty) "OccupationText": txtOccupation.text,
        if (txtIndustry.text.isNotEmpty)
          "professionaldetails_industry": txtIndustry.text.trim(),
        if (txtIndustry.text.isNotEmpty)
          "professionaldetails_industry_code": arrIndustry
              .singleWhere((e) => e.description == txtIndustry.text,
                  orElse: () => CommonModel())
              .code,
        if (txtDesignation.text.isNotEmpty)
          "current_designation_text": txtDesignation.text,
        if (txtFunction.text.isNotEmpty)
          "professionaldetails_function": txtFunction.text.trim(),
        if (txtFunction.text.isNotEmpty)
          "professionaldetails_function_code": arrFunction
              .singleWhere((e) => e.description == txtFunction.text,
                  orElse: () => CommonModel())
              .code,
        if (txtCompanyName.text.isNotEmpty)
          "professionaldetails_companyname": txtCompanyName.text.trim(),
        if (txtCompanyLocation.text.isNotEmpty)
          "professionaldetails_companyloction": txtCompanyLocation.text.trim(),
        if (txtCompanyAddress.text.isNotEmpty)
          "professionaldetails_officeaddress": txtCompanyAddress.text.trim(),
        if (txtOfficeTelephone.text.isNotEmpty)
          "professionaldetails_officetelephone": txtOfficeTelephone.text.trim(),
        if (txtAnnualIncome.text.isNotEmpty)
          "professionaldetails_annualincome": txtAnnualIncome.text,
        if (txtAnnualIncome.text.isNotEmpty)
          "professionaldetails_annualincome_code": arrAnnualIncome
              .singleWhere((e) => e.description == txtAnnualIncome.text,
                  orElse: () => CommonModel())
              .code,
      };

      if (type == SVFormType.professionalDetails) {
        data.addAll(professionalDetails);
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }
      *//*if (txtSourcingManager.text.isNotEmpty) {
      List smList = [objSelectedSourcingManager.toJson()];
      data.addAll({"SourcingManagerList": smList});
    }*//*

      var sourceData = {
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerMobile.text != "")
          "referral_customer_mobile": txtCustomerMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerName.text != "")
          "referral_customer_name": txtCustomerName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerId.text != "")
          "referral_customer_id": txtCustomerId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerUnitNo.text != "")
          "referral_customer_unit_no": txtCustomerUnitNo.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtProjectName.text != "")
          "referral_customer_project_name": txtProjectName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeId.text != "")
          "referral_employee_id": txtEmployeeId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeName.text != "")
          "referral_employee_name": txtEmployeeName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeMobile.text != "")
          "referral_employee_mobile": txtEmployeeMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeEmail.text != "")
          "referral_employee_email": txtEmployeeEmail.text.trim().toLowerCase(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPVendorId.text != "")
          "referral_vendor_id": txtCPVendorId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPExecutive.text != "")
          "referral_cp_executive": txtCPExecutive.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPExecutiveMobile.text != "")
          "referral_cp_executive_mobile": txtCPExecutiveMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCP.text != "")
          "referral_cp_name": txtCP.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPCompanyName.text != "")
          "referral_cp_company_name": txtCPCompanyName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPRERANo.text != "")
          "referral_cp_rera_no": txtCPRERANo.text.trim(),
        "purchasedetails_source": txtBookingSource.text,
        "purchasedetails_source_code": arrSource
            .singleWhere((e) => e.description == txtBookingSource.text,
                orElse: () => CommonModel())
            .code,
      };
      data.addAll(sourceData);

      dynamic leadSourceData;

      if (txtBookingSource.text.toLowerCase() == "customer reference") {
        leadSourceData = {
          "first_lead_referral_customer_mobile": txtCustomerMobile.text.trim(),
          "first_lead_referral_customer_name": txtCustomerName.text.trim(),
          "first_lead_referral_customer_id": txtCustomerId.text.trim(),
          "first_lead_referral_customer_unit_no": txtCustomerUnitNo.text.trim(),
          "first_lead_referral_customer_project_name":
              txtProjectName.text.trim(),
        };
      }
      if (txtBookingSource.text.toLowerCase() == "employee reference") {
        leadSourceData = {
          "first_lead_referral_employee_id": txtEmployeeId.text.trim(),
          "first_lead_referral_employee_name": txtEmployeeName.text.trim(),
          "first_lead_referral_employee_mobile": txtEmployeeMobile.text.trim(),
          "first_lead_referral_employee_email":
              txtEmployeeEmail.text.trim().toLowerCase(),
        };
      }
      if (txtBookingSource.text.toLowerCase() == "channel partner") {
        leadSourceData = {
          "first_lead_referral_vendor_id": txtCPVendorId.text.trim(),
          "first_lead_referral_cp_executive": txtCPExecutive.text.trim(),
          "first_lead_referral_cp_executive_mobile":
              txtCPExecutiveMobile.text.trim(),
          "first_lead_referral_cp_name": txtCPCompanyName.text.trim(),
          "first_lead_referral_cp_company_name": txtCPCompanyName.text.trim(),
          "first_lead_referral_cp_rera_no": txtCPRERANo.text.trim(),
        };
      }

      if (leadSourceData != null) data.addAll(leadSourceData);
      if (txtBookingSource.text.isNotEmpty) {
        data.addAll({
          "first_lead_souce_text": txtBookingSource.text,
          "first_lead_source_code": arrSource
              .singleWhere((e) => e.description == txtBookingSource.text)
              .code
        });
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }
      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: svFormId.isNotEmpty && scanId.isNotEmpty
              ? Api.apiSvFormUpdate
              : Api.apiSvFormCreate,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: svFormId.isNotEmpty && scanId.isNotEmpty
              ? ApiMethod.put
              : ApiMethod.post);
      Map<String, dynamic>? responseData = await response.getResponse();
      log(" Data----$data");
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
              scanId.value = data1[0]["scanid"];

              //formDataModel.value = SvFormDataModel.fromJson(data1[0]);
              token.value = data1[0]["svtoken"].toString();
              waitListNumber.value = data1[0]["svwaitlistnumber"].toString();
              //formDataModel.refresh();
              //fillSvFormDetails();
            }
            *//*svFormId.refresh();
            svToken.refresh();
            scanId.refresh();
            svWaitListNumber.refresh();
            isNewSv.value = false;
            disableSource.value = true;
            disableSourceDetail.value = true;*//*
          }
        } catch (ex, x) {
          log("exception====$ex");
          log("at=====$x");
        }
        *//*if (objBookingSource.value.code != null &&
            objBookingSource.value.code != "") {}
        SuccessMsg(responseData['message']);
        navigateToNextScreen(item);
        progressBarProcess('NEXT');*//*
      } else {
        showError(responseData['message']);
        removeAppLoader(Get.context!);
      }
    } catch (e, stack) {
      removeAppLoader(Get.context!);
      log("exception---$e---${stack}");
    }

    return isValid;
  }*/
  Future<bool> addEditSvFormDetails(SVFormType type) async {
    bool isValid = false;

    appLoader(Get.context!);
    try {
      var data = {
        // "SalesOwnerPartyID": kOwnerPartyID,
        // "SalesOwnerPartyName": kOwnerPartyName,
        //"personaldetails_profilepic": uploadPhotoUrl.value,
        "scanfrom": "preosssalesapp",
        "title_name": txtTitle.text,
        "title_code": arrTitle
            .singleWhere((e) => e.description == txtTitle.text,
                orElse: () => TitleModel())
            .code,
        "first_name": txtFirstName.text,
        "last_name": txtLastName.text,
        "mobile_no": txtMobileNo.text,
        // "permanentaddress_pincode": txtPinCode.text,
        "mobile_country_code": "+91",
        // "personaldetails_mobileno_countrycodetext": "IN",
        "alt_mobile_no": txtResAlternate.text,
        "alt_mobile_country_code": " +91",
        // "personaldetails_alternatemobileno_countrycodetext": "IN",
        "email": txtEmail.text.toLowerCase(),
        if (txtAgeGroup.text.isNotEmpty)
          "age_group_code": arrAgeGroup
              .singleWhere((e) => e.description == txtAgeGroup.text,
                  orElse: () => AgeGroupModel())
              .code,
        if (txtAgeGroup.text.isNotEmpty)
          "age_group_description": txtAgeGroup.text,
        "residential_telephone_no": txtTelephoneNo.text,
        "residential_telephone_no_country_code": "+91",
        "purpose_of_purchase_description": txtPurchasePurpose.text,
        "purpose_of_purchase_code": arrPurpose
            .singleWhere((e) => e.description == txtPurchasePurpose.text,
                orElse: () => CommonModel())
            .code,
        // "purchasedetails_question": "No",
        "sourcing_manager_list":[
          {
            "owner_emp_id":txtSVAttendee.text,
            "owner_emp_name":arrAttendee
            .singleWhere((e) => e.description == txtSVAttendee.text,
                orElse: () => CommonModel())
            .code,
          }
        ],
        "svattendee": txtSVAttendee.text,
        "svattendee_code": arrAttendee
            .singleWhere((e) => e.description == txtSVAttendee.text,
                orElse: () => CommonModel())
            .code,
        if (txtConfiguration.text.isNotEmpty)
          "configuration_code": arrConfiguration
              .singleWhere((e) => e.description == txtConfiguration.text,
                  orElse: () => CommonModel())
              .code,
        if (txtConfiguration.text.isNotEmpty)
          "configuration_description": txtConfiguration.text,
        "project_code": commonSelectedProject.value.projectCode,
        if (scanId.value.isNotEmpty) "scanid": scanId.value,
        //"latlong": [live_latlang.latitude, live_latlang.longitude],
        "source_description": txtBookingSource.text,
        "source_code": arrSource
            .singleWhere((e) => e.description == txtBookingSource.text,
                orElse: () => CommonModel())
            .code
      };

      dynamic professionalDetails;
      professionalDetails = {
        if (txtOccupation.text.isNotEmpty)
          "occupation_code": arrOccupation
              .singleWhere((e) => e.description == txtOccupation.text,
                  orElse: () => CommonModel())
              .code,
        if (txtOccupation.text.isNotEmpty) "occupation_description": txtOccupation.text,
        if (txtIndustry.text.isNotEmpty)
          "industry_description": txtIndustry.text.trim(),
        if (txtIndustry.text.isNotEmpty)
          "industry_code": arrIndustry
              .singleWhere((e) => e.description == txtIndustry.text,
                  orElse: () => CommonModel())
              .code,
        // ------------------todo: add designation list-------------------------
        /// if (txtDesignation.text.isNotEmpty)
        ///   "current_designation_text": txtDesignation.text,
        if (txtFunction.text.isNotEmpty)
          "function_description": txtFunction.text.trim(),
        if (txtFunction.text.isNotEmpty)
          "function_code": arrFunction
              .singleWhere((e) => e.description == txtFunction.text,
                  orElse: () => CommonModel())
              .code,
        if (txtCompanyName.text.isNotEmpty)
          "company_name": txtCompanyName.text.trim(),
        if (txtCompanyLocation.text.isNotEmpty)
          "company_location": txtCompanyLocation.text.trim(),
        if (txtCompanyAddress.text.isNotEmpty)
          "company_address": txtCompanyAddress.text.trim(),
        if (txtOfficeTelephone.text.isNotEmpty)
          "office_telephone": txtOfficeTelephone.text.trim(),
        if (txtAnnualIncome.text.isNotEmpty)
          "annual_income_description": txtAnnualIncome.text,
        if (txtAnnualIncome.text.isNotEmpty)
          "annual_income_code": arrAnnualIncome
              .singleWhere((e) => e.description == txtAnnualIncome.text,
                  orElse: () => CommonModel())
              .code,
      };

      if (type == SVFormType.professionalDetails) {
        data.addAll(professionalDetails);
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }
      /*if (txtSourcingManager.text.isNotEmpty) {
      List smList = [objSelectedSourcingManager.toJson()];
      data.addAll({"SourcingManagerList": smList});
    }*/

      var sourceData = {
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerMobile.text != "")
          "referral_customer_mobile": txtCustomerMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerName.text != "")
          "referral_customer_name": txtCustomerName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerId.text != "")
          "referral_customer_id": txtCustomerId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerUnitNo.text != "")
          "referral_customer_unit_no": txtCustomerUnitNo.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtProjectName.text != "")
          "referral_customer_project_name": txtProjectName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeId.text != "")
          "referral_employee_id": txtEmployeeId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeName.text != "")
          "referral_employee_name": txtEmployeeName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeMobile.text != "")
          "referral_employee_mobile": txtEmployeeMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeEmail.text != "")
          "referral_employee_email": txtEmployeeEmail.text.trim().toLowerCase(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPVendorId.text != "")
          "referral_vendor_id": txtCPVendorId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPExecutive.text != "")
          "referral_cp_executive": txtCPExecutive.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPExecutiveMobile.text != "")
          "referral_cp_executive_mobile": txtCPExecutiveMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCP.text != "")
          "referral_cp_name": txtCP.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPCompanyName.text != "")
          "referral_cp_company_name": txtCPCompanyName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPRERANo.text != "")
          "referral_cp_rera_no": txtCPRERANo.text.trim(),
        "purchasedetails_source": txtBookingSource.text,
        "purchasedetails_source_code": arrSource
            .singleWhere((e) => e.description == txtBookingSource.text,
                orElse: () => CommonModel())
            .code,
      };
      data.addAll(sourceData);

      dynamic leadSourceData;

      if (txtBookingSource.text.toLowerCase() == "customer reference") {
        leadSourceData = {
          "first_lead_referral_customer_mobile": txtCustomerMobile.text.trim(),
          "first_lead_referral_customer_name": txtCustomerName.text.trim(),
          "first_lead_referral_customer_id": txtCustomerId.text.trim(),
          "first_lead_referral_customer_unit_no": txtCustomerUnitNo.text.trim(),
          "first_lead_referral_customer_project_name":
              txtProjectName.text.trim(),
        };
      }
      if (txtBookingSource.text.toLowerCase() == "employee reference") {
        leadSourceData = {
          "first_lead_referral_employee_id": txtEmployeeId.text.trim(),
          "first_lead_referral_employee_name": txtEmployeeName.text.trim(),
          "first_lead_referral_employee_mobile": txtEmployeeMobile.text.trim(),
          "first_lead_referral_employee_email":
              txtEmployeeEmail.text.trim().toLowerCase(),
        };
      }
      if (txtBookingSource.text.toLowerCase() == "channel partner") {
        leadSourceData = {
          "first_lead_referral_vendor_id": txtCPVendorId.text.trim(),
          "first_lead_referral_cp_executive": txtCPExecutive.text.trim(),
          "first_lead_referral_cp_executive_mobile":
              txtCPExecutiveMobile.text.trim(),
          "first_lead_referral_cp_name": txtCPCompanyName.text.trim(),
          "first_lead_referral_cp_company_name": txtCPCompanyName.text.trim(),
          "first_lead_referral_cp_rera_no": txtCPRERANo.text.trim(),
        };
      }

      if (leadSourceData != null) data.addAll(leadSourceData);
      if (txtBookingSource.text.isNotEmpty) {
        data.addAll({
          "first_lead_souce_text": txtBookingSource.text,
          "first_lead_source_code": arrSource
              .singleWhere((e) => e.description == txtBookingSource.text)
              .code
        });
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }
      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: svFormId.isNotEmpty && scanId.isNotEmpty
              ? Api.apiSvFormUpdate
              : Api.apiSvFormCreate,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: svFormId.isNotEmpty && scanId.isNotEmpty
              ? ApiMethod.put
              : ApiMethod.post);
      Map<String, dynamic>? responseData = await response.getResponse();
      log(" Data----$data");
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
              scanId.value = data1[0]["scanid"];

              //formDataModel.value = SvFormDataModel.fromJson(data1[0]);
              token.value = data1[0]["svtoken"].toString();
              waitListNumber.value = data1[0]["svwaitlistnumber"].toString();
              //formDataModel.refresh();
              //fillSvFormDetails();
            }
            /*svFormId.refresh();
            svToken.refresh();
            scanId.refresh();
            svWaitListNumber.refresh();
            isNewSv.value = false;
            disableSource.value = true;
            disableSourceDetail.value = true;*/
          }
        } catch (ex, x) {
          log("exception====$ex");
          log("at=====$x");
        }
        /*if (objBookingSource.value.code != null &&
            objBookingSource.value.code != "") {}
        SuccessMsg(responseData['message']);
        navigateToNextScreen(item);
        progressBarProcess('NEXT');*/
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
  Future<bool> addEditSvFormDetailsOld(SVFormType type) async {
    bool isValid = false;

    appLoader(Get.context!);
    try {
      var data = {
        "SalesOwnerPartyID": kOwnerPartyID,
        "SalesOwnerPartyName": kOwnerPartyName,
        //"personaldetails_profilepic": uploadPhotoUrl.value,
        "scanfrom": "preosssalesapp",
        "personaldetails_title": txtTitle.text,
        "personaldetails_title_code": arrTitle
            .singleWhere((e) => e.description == txtTitle.text,
                orElse: () => TitleModel())
            .code,
        "personaldetails_firstname": txtFirstName.text,
        "personaldetails_lastname": txtLastName.text,
        "personaldetails_mobileno": txtMobileNo.text,
        "permanentaddress_pincode": txtPinCode.text,
        "personaldetails_mobileno_countrycode": "+91",
        "personaldetails_mobileno_countrycodetext": "IN",
        "personaldetails_alternatemobileno": txtResAlternate.text,
        "personaldetails_alternatemobileno_countrycode": " +91",
        "personaldetails_alternatemobileno_countrycodetext": "IN",
        "personaldetails_email": txtEmail.text.toLowerCase(),
        if (txtAgeGroup.text.isNotEmpty)
          "personaldetails_age_code": arrAgeGroup
              .singleWhere((e) => e.description == txtAgeGroup.text,
                  orElse: () => AgeGroupModel())
              .code,
        if (txtAgeGroup.text.isNotEmpty)
          "personaldetails_age": txtAgeGroup.text,
        "personaldetails_telephonenumber": txtTelephoneNo.text,
        "purchasedetails_purpose": txtPurchasePurpose.text,
        "purchasedetails_purpose_code": arrPurpose
            .singleWhere((e) => e.description == txtPurchasePurpose.text,
                orElse: () => CommonModel())
            .code,
        "purchasedetails_question": "No",
        "svattendee": txtSVAttendee.text,
        "svattendee_code": arrAttendee
            .singleWhere((e) => e.description == txtSVAttendee.text,
                orElse: () => CommonModel())
            .code,
        if (txtConfiguration.text.isNotEmpty)
          "TypeOfFlat_KUT": arrConfiguration
              .singleWhere((e) => e.description == txtConfiguration.text,
                  orElse: () => CommonModel())
              .code,
        if (txtConfiguration.text.isNotEmpty)
          "TypeOfFlat_KUTText": txtConfiguration.text,
        "sitecode": kLocationCode,
        if (scanId.value.isNotEmpty) "scanid": scanId.value,
        //"latlong": [live_latlang.latitude, live_latlang.longitude],
        "purchasedetails_source": txtBookingSource.text,
        "purchasedetails_source_code": arrSource
            .singleWhere((e) => e.description == txtBookingSource.text,
                orElse: () => CommonModel())
            .code
      };

      dynamic professionalDetails;
      professionalDetails = {
        if (txtOccupation.text.isNotEmpty)
          "OccupationCode": arrOccupation
              .singleWhere((e) => e.description == txtOccupation.text,
                  orElse: () => CommonModel())
              .code,
        if (txtOccupation.text.isNotEmpty) "OccupationText": txtOccupation.text,
        if (txtIndustry.text.isNotEmpty)
          "professionaldetails_industry": txtIndustry.text.trim(),
        if (txtIndustry.text.isNotEmpty)
          "professionaldetails_industry_code": arrIndustry
              .singleWhere((e) => e.description == txtIndustry.text,
                  orElse: () => CommonModel())
              .code,
        if (txtDesignation.text.isNotEmpty)
          "current_designation_text": txtDesignation.text,
        if (txtFunction.text.isNotEmpty)
          "professionaldetails_function": txtFunction.text.trim(),
        if (txtFunction.text.isNotEmpty)
          "professionaldetails_function_code": arrFunction
              .singleWhere((e) => e.description == txtFunction.text,
                  orElse: () => CommonModel())
              .code,
        if (txtCompanyName.text.isNotEmpty)
          "professionaldetails_companyname": txtCompanyName.text.trim(),
        if (txtCompanyLocation.text.isNotEmpty)
          "professionaldetails_companyloction": txtCompanyLocation.text.trim(),
        if (txtCompanyAddress.text.isNotEmpty)
          "professionaldetails_officeaddress": txtCompanyAddress.text.trim(),
        if (txtOfficeTelephone.text.isNotEmpty)
          "professionaldetails_officetelephone": txtOfficeTelephone.text.trim(),
        if (txtAnnualIncome.text.isNotEmpty)
          "professionaldetails_annualincome": txtAnnualIncome.text,
        if (txtAnnualIncome.text.isNotEmpty)
          "professionaldetails_annualincome_code": arrAnnualIncome
              .singleWhere((e) => e.description == txtAnnualIncome.text,
                  orElse: () => CommonModel())
              .code,
      };

      if (type == SVFormType.professionalDetails) {
        data.addAll(professionalDetails);
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }
      /*if (txtSourcingManager.text.isNotEmpty) {
      List smList = [objSelectedSourcingManager.toJson()];
      data.addAll({"SourcingManagerList": smList});
    }*/

      var sourceData = {
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerMobile.text != "")
          "referral_customer_mobile": txtCustomerMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerName.text != "")
          "referral_customer_name": txtCustomerName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerId.text != "")
          "referral_customer_id": txtCustomerId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtCustomerUnitNo.text != "")
          "referral_customer_unit_no": txtCustomerUnitNo.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "customer reference" &&
            txtProjectName.text != "")
          "referral_customer_project_name": txtProjectName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeId.text != "")
          "referral_employee_id": txtEmployeeId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeName.text != "")
          "referral_employee_name": txtEmployeeName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeMobile.text != "")
          "referral_employee_mobile": txtEmployeeMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "employee reference" &&
            txtEmployeeEmail.text != "")
          "referral_employee_email": txtEmployeeEmail.text.trim().toLowerCase(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPVendorId.text != "")
          "referral_vendor_id": txtCPVendorId.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPExecutive.text != "")
          "referral_cp_executive": txtCPExecutive.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPExecutiveMobile.text != "")
          "referral_cp_executive_mobile": txtCPExecutiveMobile.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCP.text != "")
          "referral_cp_name": txtCP.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPCompanyName.text != "")
          "referral_cp_company_name": txtCPCompanyName.text.trim(),
        if (txtBookingSource.text.toLowerCase() == "channel partner" &&
            txtCPRERANo.text != "")
          "referral_cp_rera_no": txtCPRERANo.text.trim(),
        "purchasedetails_source": txtBookingSource.text,
        "purchasedetails_source_code": arrSource
            .singleWhere((e) => e.description == txtBookingSource.text,
                orElse: () => CommonModel())
            .code,
      };
      data.addAll(sourceData);

      dynamic leadSourceData;

      if (txtBookingSource.text.toLowerCase() == "customer reference") {
        leadSourceData = {
          "first_lead_referral_customer_mobile": txtCustomerMobile.text.trim(),
          "first_lead_referral_customer_name": txtCustomerName.text.trim(),
          "first_lead_referral_customer_id": txtCustomerId.text.trim(),
          "first_lead_referral_customer_unit_no": txtCustomerUnitNo.text.trim(),
          "first_lead_referral_customer_project_name":
              txtProjectName.text.trim(),
        };
      }
      if (txtBookingSource.text.toLowerCase() == "employee reference") {
        leadSourceData = {
          "first_lead_referral_employee_id": txtEmployeeId.text.trim(),
          "first_lead_referral_employee_name": txtEmployeeName.text.trim(),
          "first_lead_referral_employee_mobile": txtEmployeeMobile.text.trim(),
          "first_lead_referral_employee_email":
              txtEmployeeEmail.text.trim().toLowerCase(),
        };
      }
      if (txtBookingSource.text.toLowerCase() == "channel partner") {
        leadSourceData = {
          "first_lead_referral_vendor_id": txtCPVendorId.text.trim(),
          "first_lead_referral_cp_executive": txtCPExecutive.text.trim(),
          "first_lead_referral_cp_executive_mobile":
              txtCPExecutiveMobile.text.trim(),
          "first_lead_referral_cp_name": txtCPCompanyName.text.trim(),
          "first_lead_referral_cp_company_name": txtCPCompanyName.text.trim(),
          "first_lead_referral_cp_rera_no": txtCPRERANo.text.trim(),
        };
      }

      if (leadSourceData != null) data.addAll(leadSourceData);
      if (txtBookingSource.text.isNotEmpty) {
        data.addAll({
          "first_lead_souce_text": txtBookingSource.text,
          "first_lead_source_code": arrSource
              .singleWhere((e) => e.description == txtBookingSource.text)
              .code
        });
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }
      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: svFormId.isNotEmpty && scanId.isNotEmpty
              ? Api.apiSvFormUpdate
              : Api.apiSvFormCreate,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: svFormId.isNotEmpty && scanId.isNotEmpty
              ? ApiMethod.put
              : ApiMethod.post);
      Map<String, dynamic>? responseData = await response.getResponse();
      log(" Data----$data");
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
              scanId.value = data1[0]["scanid"];

              //formDataModel.value = SvFormDataModel.fromJson(data1[0]);
              token.value = data1[0]["svtoken"].toString();
              waitListNumber.value = data1[0]["svwaitlistnumber"].toString();
              //formDataModel.refresh();
              //fillSvFormDetails();
            }
            /*svFormId.refresh();
            svToken.refresh();
            scanId.refresh();
            svWaitListNumber.refresh();
            isNewSv.value = false;
            disableSource.value = true;
            disableSourceDetail.value = true;*/
          }
        } catch (ex, x) {
          log("exception====$ex");
          log("at=====$x");
        }
        /*if (objBookingSource.value.code != null &&
            objBookingSource.value.code != "") {}
        SuccessMsg(responseData['message']);
        navigateToNextScreen(item);
        progressBarProcess('NEXT');*/
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
}

enum SVFormType {
  personalDetails,
  professionalDetails,
}
