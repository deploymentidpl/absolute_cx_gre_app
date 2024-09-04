class Api {
  // static const baseUrl = "http://143.110.252.51";
  static const baseUrl = "https://devapi.absolutecx.com";

  //new apis
  static const String projectList = "$baseUrl/projects/v1/list";
  static const String nearbyProjectList =
      "$baseUrl/projectnearbylocation/v1/list";
  static const String apiTitleList = "$baseUrl/title/v1/list";
  static const String apiBudgetList = '$baseUrl/budget/v1/list';
  static const String apiDesignationList = '$baseUrl/designation/v1/list';

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
  static const String apiCheckInHistory =
      "$baseUrl/employee/v1/showemployeehistory";

  ///login
  static const String apiLoginOld = "$baseUrl/employee/v1/gre/checkin/checkout";
  static const String apiLogin = "$baseUrl/employee/v1/grelogin";
  static const String apiVerifyPin = "$baseUrl/employee/v1/verify/pin";
  static const String apiLogout = "$baseUrl/employee/v1/logout";
  static const String apiCheckIn = "$baseUrl/employee/v1/checkin/checkout";
  static const String apiChangeEmpPin =
      "$baseUrl/employee/v1/changeemployeepin";

  /// site visit form
  static const String apiSvFormSendOTP = "$baseUrl/svform/v1/sendotp";
  static const String apiSvFormVerifyOTP = "$baseUrl/svform/v1/verifyotp";
  static const String apiAttendeeList = "$baseUrl/sv_attendee_type/v1/list";
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

  // Assigned-UnAssigned
  // static const String apiUnAssignedList = "$baseUrl/sitevisit/v1/unassignlist";
  static const String apiUnAssignedList =
      "$baseUrl/dashboard/v1/gre/sv/unassign/list";
  static const String apiAssignedList =
      "$baseUrl/dashboard/v1/gre/sv/owned/list";
  static const String apiReAssign = "$baseUrl/sitevisit/v1/reassign";

  ///Channel Partner
  static const String channelPartnerListUrl = '$baseUrl/channelpartner/v1/list';

  //sales
  static const String apiViewLeadSVDoneUrl = '$baseUrl/sitevisit/v1/list';

  static const String apiLanguageList = '$baseUrl/language/v1/list';
  static const String apiRoleWiseEmployeeList =
      '$baseUrl/employee/v1/filterbyrole';

  static const String employeeSearchUrl = '$baseUrl/employee/v1/list';
  static const String apiNotificationCount = '$baseUrl/notification/v1/count';
  static const String apiCityList = '$baseUrl/city/v1/list';
  static const String apiCustomerLeadDetails = '$baseUrl/customer/v1/list';
  static String siteVisitPerHourCount =
      '$baseUrl/dashboard/v1/gre/sv/perhour/count';
  static String siteVisitPerHourClickDetail =
      '$baseUrl/dashboard/v1/gre/sv/perhour/clickdetail';
  static String sourceWiseSVCount =
      '$baseUrl/dashboard/v1/gre/sv/sourcewise/count/and/percentage';
  static String siteVisitCount = '$baseUrl/dashboard/v1/gre/sv/count';
  static String siteVisitSourceCount =
      '$baseUrl/dashboard/v1/gre/sv/sourcewise/count/and/percentage';
  static String sVWaitListCount = '$baseUrl/dashboard/v1/gre/sv/waiting/count';
}
