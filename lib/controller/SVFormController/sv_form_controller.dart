import 'dart:async';
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
import '../../model/CustomerDialogViewModel/CustomerDialogViewModel.dart';
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
    retrieveSourcingManager(searchText: AppConstant.roleCodeSalesManager);
    retrievePurchasePurpose();
    retrieveSVAttendeeData();
    retrieveConfiguration();
    retrieveOccupation();
    retrieveIndustry();
    retrieveFunction();
    retrieveAnnualIncome();
    CommonController().retrieveCountry().whenComplete(() {
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

  Future<bool> addEditSvFormDetails(SVFormType type) async {
    bool isValid = false;

    appLoader(Get.context!);
    try {
      var data = {
        "lead_created_from":isWeb? "ACX GRE WEB":"ACX GRE APP",
        "svform_id": svFormId,
        "scanvisitlocation_id": scanVisitId,
        "created_by_emp_id":
        PreferenceController.getString(
            SharedPref.employeeID),
        "title_name": txtTitle.text,
        "title_code": arrTitle
            .singleWhere((e) => e.description == txtTitle.text,
            orElse: () => TitleModel())
            .code,
        "first_name": txtFirstName.text,
        "last_name": txtLastName.text,
        "mobile_no": txtMobileNo.text,
        "pincode": txtPinCode.text,
        "mobile_country_code": "+91",
        "alt_mobile_no": txtResAlternate.text,
        "alt_mobile_country_code": " +91",
        "email": txtEmail.text.toLowerCase(),
        if (txtAgeGroup.text.isNotEmpty)
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
        if (txtAgeGroup.text.isNotEmpty)
          "age_group_description": txtAgeGroup.text,
        "residential_telephone_no": txtTelephoneNo.text,
        "residential_telephone_no_country_code": "+91",
        "purpose_of_purchase_description": txtPurchasePurpose.text,
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
        /*if (txtSourcingManager.text.isNotEmpty) {
      List smList = [objSelectedSourcingManager.toJson()];
      data.addAll({"SourcingManagerList": smList});
    }*/

        "sourcing_manager_list": List.generate(
            arrManager.length,
                (index) => {
              "owner_emp_id": arrManager[index].employeeId,
              "owner_emp_name": arrManager[index].empFormattedName,
            }),
        "svattendee": txtSVAttendee.text,
        "svattendee_code": arrAttendee
            .where((p0) => p0.description == txtSVAttendee.text)
            .toList()
            .isNotEmpty
            ? arrAttendee
            .where((p0) => p0.description == txtSVAttendee.text)
            .toList()
            .first
            .code
            : "",
        if (txtConfiguration.text.isNotEmpty)
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
        if (txtConfiguration.text.isNotEmpty)
          "configuration_description": txtConfiguration.text,
        "project_code": kSelectedProject.value.projectCode,
        //"latlong": [live_latlang.latitude, live_latlang.longitude],
        "site_visit_source_description": txtBookingSource.text,
        "site_visit_source_code": arrSource
            .where((p0) => p0.description == txtBookingSource.text)
            .toList()
            .isNotEmpty
            ? arrSource
            .where((p0) => p0.description == txtBookingSource.text)
            .toList()
            .first
            .code
            : ""
      };

      dynamic professionalDetails;
      professionalDetails = {
        if (txtOccupation.text.isNotEmpty)
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
        if (txtOccupation.text.isNotEmpty)
          "occupation_description": txtOccupation.text,
        if (txtIndustry.text.isNotEmpty)
          "industry_description": txtIndustry.text.trim(),
        if (txtIndustry.text.isNotEmpty)
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
        // ------------------todo: add designation list-------------------------
        /// if (txtDesignation.text.isNotEmpty)
        ///   "current_designation_text": txtDesignation.text,
        if (txtFunction.text.isNotEmpty)
          "function_description": txtFunction.text.trim(),
        if (txtFunction.text.isNotEmpty)
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
              .where((p0) => p0.description == txtAnnualIncome.text)
              .toList()
              .isNotEmpty
              ? arrAnnualIncome
              .where((p0) => p0.description == txtAnnualIncome.text)
              .toList()
              .first
              .code
              : "",
      };

      if (type == SVFormType.professionalDetails) {
        data.addAll(professionalDetails);
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }

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
            .where((p0) => p0.description == txtBookingSource.text)
            .toList()
            .isNotEmpty
            ? arrSource
            .where((p0) => p0.description == txtBookingSource.text)
            .toList()
            .first
            .code
            : "",
      };
      data.addAll(sourceData);

      if (txtBookingSource.text.isNotEmpty) {
        data.addAll({
          "first_lead_souce_text": txtBookingSource.text,
          "first_lead_source_code": arrSource
              .where((p0) => p0.description == txtBookingSource.text)
              .toList()
              .isNotEmpty
              ? arrSource
              .where((p0) => p0.description == txtBookingSource.text)
              .toList()
              .first
              .code
              : ""
        });
      }

      if (svFormId.isNotEmpty) {
        data.addAll({"_id": svFormId});
      }
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

              svFormId = data1[0]["scanVisitLocation"][0]["svform_id"];
              scanVisitId = data1[0]["scanVisitLocation"][0]["_id"];

              token.value = data1[0]["scanVisitLocation"][0]
              ["current_visit_token"]
                  .toString();
              waitListNumber.value = data1[0]["scanVisitLocation"][0]
              ["sv_wait_list_number"]
                  .toString();
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
      "country_code":objCountry.countryCode.toString(),
      "mobile_country_code": objCountry.code.toString(),
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
        "created_by_emp_id":PreferenceController.getString(SharedPref.employeeID)
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
