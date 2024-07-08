class Api {
  // static const baseUrl = "http://143.110.252.51";
  static const baseUrl = "https://devapi.absolutecx.com";

  //new apis
  static const String projectList = "$baseUrl/projects/v1/list";
  static const String nearbyProjectList =
      "$baseUrl/projectnearbylocation/v1/list";
  static const String apiTitleList = "$baseUrl/title/v1/list";
  static const String apiAgeGroupList = "$baseUrl/agegroup/v1/list";
  static const String apiEmployeeList = "$baseUrl/employee/v1/list";
  static const String apiSourceList = "$baseUrl/source/v1/list";
  static const String apiPurchasePurposeList =
      "$baseUrl/purposeofpurchase/v1/list";
  static const String apiConfigurationList = "$baseUrl/configuration/v1/list";
  static const String apiOccupationList = "$baseUrl/occupation/v1/list";
  static const String apiIndustryList = "$baseUrl/industry/v1/list";
  static const String apiFunctionList = "$baseUrl/function/v1/list";
  static const String apiAnnualIncomeList = "$baseUrl/annualincome/v1/list";

  ///login
  static const String apiLoginOld = "$baseUrl/employee/v1/gre/checkin/checkout";
  static const String apiLogin = "$baseUrl/employee/v1/grelogin";
  static const String apiLogout = "$baseUrl/employee/v1/logout";


  /// site visit form
  static const String apiSvFormSendOTP = "$baseUrl/svform/v1/sendotp";
  static const String apiSvFormVerifyOTP = "$baseUrl/svform/v1/verifyotp";
  static const String apiAttendeeList =
      "$baseUrl/sv_attendee_type/v1/list";
  static const String apiSvFormCreate = "$baseUrl/svform/v1/create";
  static const String apiSvFormUpdate = "$baseUrl/svform/v1/update";
  static const String apiCountryList = "$baseUrl/country/v1/list";
  static const String apiCustomerRefUnitList =
      "$baseUrl/lead/v1/item360/unit/list";
  static const String apiCustomerRefSearchList =
      "$baseUrl/lead/v1/item360/phonenumber/list";
  static const String apiEmployeeDetailList =
      "$baseUrl/employee/v1/head/employee/list";
  static const String apiCPSearch = "$baseUrl/lead/v1/channelpartner/search";

}
