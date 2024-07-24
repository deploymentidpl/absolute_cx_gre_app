//  for common file changes
// Future<bool> addEditSvFormDetails(SVFormType type) async {
//   bool isValid = false;
//
//   appLoader(Get.context!);
//   try {
//     var data = {
//
//       "first_name": txtFirstName.text,
//       "last_name": txtLastName.text,
//       "mobile_country_code":  objCountry.code.toString(),
//       "mobile_no": txtMobileNo.text,
//       "alt_mobile_country_code": objResCountry.code.toString(),
//       "residential_telephone_no_country_code":  objTelCountry.code.toString(),
//       "residential_telephone_no": txtTelephoneNo.text,
//       "email": txtEmail.text.toLowerCase(),
//       "title_code": arrTitle
//           .singleWhere((e) => e.description == txtTitle.text,
//           orElse: () => TitleModel())
//           .code,
//       "title_name": txtTitle.text,
//       "current_residence_location":  txtCurrentResidence.text,
//       "pincode": txtPinCode.text,    "age_group_code": arrAgeGroup
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
//       //todo: add values
//       "budget_code":"",
//       "budget_description":"",
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
//       //todo: add value
//       "designation_code":"",
//       "designation_description":"",
//       "company_name": txtCompanyName.text.trim(),
//       "project_code": kSelectedProject.value.projectCode,
//       //todo:checllllll
//       "project_name": kSelectedProject.value.projectName,
//     "site_visit_source_code": arrSource
//         .where((p0) => p0.description == txtBookingSource.text)
//         .toList()
//         .isNotEmpty
//     ? arrSource
//         .where((p0) => p0.description == txtBookingSource.text)
//         .toList()
//         .first
//         .code
//         : ""
//     "site_visit_source_description": txtBookingSource.text,
//   //todo: add customer and employee refral code
//
//
//
//
//
//       ///old------------------------------------------------------------------
//
//
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
//       "alt_mobile_no": txtResAlternate.text,
//       "alt_mobile_country_code": " +91",
//       "email": txtEmail.text.toLowerCase(),
//
//       "residential_telephone_no": txtTelephoneNo.text,
//       "residential_telephone_no_country_code": "+91",
//
//       /*if (txtSourcingManager.text.isNotEmpty) {
//       List smList = [objSelectedSourcingManager.toJson()];
//       data.addAll({"SourcingManagerList": smList});
//     }*/
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
//       //"latlong": [live_latlang.latitude, live_latlang.longitude],
//
//     };
//
//     dynamic professionalDetails;
//     professionalDetails = {
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
//       if (txtCompanyLocation.text.isNotEmpty)
//         "company_location": txtCompanyLocation.text.trim(),
//       if (txtCompanyAddress.text.isNotEmpty)
//         "company_address": txtCompanyAddress.text.trim(),
//       if (txtOfficeTelephone.text.isNotEmpty)
//         "office_telephone": txtOfficeTelephone.text.trim(),
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