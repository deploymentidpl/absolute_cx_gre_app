class Api {
  // static const baseUrl = "https://cpidev.preoss.in";
  // static const baseUrl = "http://143.110.252.51";
  static const baseUrl = "https://devapi.absolutecx.com";

  //new apis
  static const String projectList = "$baseUrl/projects/v1/list";
  static const String nearbyProjectList =
      "$baseUrl/projectnearbylocation/v1/list";
  static const String apiTitleList = "$baseUrl/title/v1/list";
  static const String apiAgeGroupList = "$baseUrl/agegroup/v1/list";
  static const String apiSourcingManagerList = "$baseUrl/employee/v1/list";
  static const String apiSourceList = "$baseUrl/source/v1/list";
  static const String apiPurchasePurposeList =
      "$baseUrl/purposeofpurchase/v1/list";
  static const String apiConfigurationList = "$baseUrl/configuration/v1/list";
  static const String apiOccupationList = "$baseUrl/occupation/v1/list";
  static const String apiIndustryList = "$baseUrl/industry/v1/list";
  static const String apiFunctionList = "$baseUrl/function/v1/list";
  static const String apiAnnualIncomeList = "$baseUrl/annualincome/v1/list";

  /// site visit form
  static const String apiSvFormSendOTP = "$baseUrl/svform/v1/sendotp";
 // static const String apiSvFormSendOTP = "$baseUrl/lead/v1/sendotp";
  static const String apiSvFormVerifyOTP = "$baseUrl/svform/v1/verifyotp";
  // static const String apiSvFormVerifyOTP = "$baseUrl/lead/v1/verifyotp";

  // static const String apiTitleList = "$baseUrl/lead/v1/title/list";
  // static const String apiAgeGroupList = "$baseUrl/lead/v1/agegroup/list";
  // static const String apiSourcingManagerList = "$baseUrl/employee/v1/roleandsearchfilterlist";
  // static const String apiSourceList = "$baseUrl/lead/v1/source/list";
  // static const String apiPurchasePurposeList = "$baseUrl/lead/v1/purposeofpurchase/list";
  static const String apiAttendeeList =
      "$baseUrl/sv_attendee_type/v1/list";
  // static const String apiAttendeeList =
  //     "$baseUrl/lead/v1/sales/svattendee/list";

  // static const String apiConfigurationList = "$baseUrl/lead/v1/propertytype/list";
  // static const String apiOccupationList = "$baseUrl/lead/v1/occupation/list";
  // static const String apiIndustryList = "$baseUrl/lead/v1/industry/list";
  // static const String apiFunctionList = "$baseUrl/lead/v1/function/list";
  // static const String apiAnnualIncomeList = "$baseUrl/lead/v1/annualincome/list";
  static const String apiSvFormCreate = "$baseUrl/svform/v1/create";
  static const String apiSvFormUpdate = "$baseUrl/svform/v1/update";
  // static const String apiSvFormCreate = "$baseUrl/lead/v1/svform/create";
  // static const String apiSvFormUpdate = "$baseUrl/lead/v1/svform/update";
  static const String apiCalenderLabel =
      "$baseUrl/employee/v1/event/label/list";
  static const String apiCalenderEventList = "$baseUrl/employee/v1/event/list";
  static const String apiSvCount = "$baseUrl/lead/v1/svlist/count";
  static const String apiCalenderCreateEvent =
      "$baseUrl/employee/v1/event/create";
  static const String apiCalenderUpdateEvent =
      "$baseUrl/employee/v1/event/update";
  static const String apiEmployeeList = "$baseUrl/employee/v1/activelist";
  static const String apiCountryList = "$baseUrl/country/v1/list";
  // static const String apiCountryList = "$baseUrl/lead/v1/countrycode/list";
  static const String apiCustomerRefUnitList =
      "$baseUrl/lead/v1/item360/unit/list";
  static const String apiCustomerRefSearchList =
      "$baseUrl/lead/v1/item360/phonenumber/list";
  static const String apiEmployeeDetailList =
      "$baseUrl/employee/v1/head/employee/list";
  static const String apiCPSearch = "$baseUrl/lead/v1/channelpartner/search";

  //site visit
  static const String apiSvOwnedList = "$baseUrl/lead/v1/ownedsvlist";
  static const String apiSvWaitList = "$baseUrl/lead/v1/svlist";
  static const String apiSVMissedList =
      "$baseUrl/lead/v1/past/missingorunclaimsvlist";
  static const String apiSVStart =
      "$baseUrl/lead/v1/sales/startsvdetails/update";
  static const String apiSVEnd = "$baseUrl/lead/v1/sales/endsvdetails/update";
  static const String apiBarrierTriggerList =
      "$baseUrl/lead/v1/triggerbarriers/list";

  /// view lead
  static const String timeLineLeadView = "$baseUrl/lead/v1/activity/timeline";
  static const String viewLeadUrl = "$baseUrl/lead/v1/retrieve";
  static const String viewLeadTodoUrl = '$baseUrl/lead/v1/todo';
  static const String viewLeadSVDoneUrl = '$baseUrl/lead/v1/sitevisites/list';
  static const String viewLeadNoteUrl = '$baseUrl/lead/v1/note/retrieve';
  static const String viewLeadFollowUpUrl =
      '$baseUrl/lead/v1/followup/retrieve';
  static const String viewLeadChangeManager =
      '$baseUrl/lead/v1/sales/sourcingmangerupdate';
  static const String viewLeadManagerSearchUrl =
      '$baseUrl/employee/v1/roleandsearchfilterlist';
  static const String viewLeadActiveEmployeeList =
      '$baseUrl/employee/v1/salesexecutivelist/list';
  static const String viewLeadAllEmployeeList =
      '$baseUrl/employee/v1/activelist';
  static const String viewLeadChangeLeadOwnerUrl =
      '$baseUrl/lead/v1/sent/sales/owner/change/request/generate';
  static const String viewLeadChangeOwnerUrl =
      '$baseUrl/lead/v1/owner/change/sticky';
  static const String viewLeadTodoPinnedUrl =
      '$baseUrl/leadl/v1/todo/stared/pinned';
  static const String viewLeadPreferredProject =
      '$baseUrl/lead/project/v1/list';
  static const String viewLeadCloneLead = '$baseUrl/lead/v1/clonelead';
  static const String viewLeadCommunicationTypeSend =
      '$baseUrl/lead/v1/leadactivity/communicatetype/create';
  static const String leadActivities = '$baseUrl/lead/v1/leadactivities/list';

  /// chat
  static const String chatSendWpMsg = '$baseUrl/bot/gupshup/whatsapp/v1/send';
  static const String chatSendMsgUrl = '$baseUrl/bot/v1/message';
  static const String chatRestartUrl = '$baseUrl/bot/v1/contact/save';
  static const String chatInitiateUrl = '$baseUrl/bot/whatsapp/initiate/chat';
  static const String chatCannedMsgList = '$baseUrl/bot/v1/cannedmessage/list';
  static const String chatUrl = '$baseUrl/bot/v1/contact/chat';
  static const String chatProjectPriceBrochureUrl =
      '$baseUrl/lead/v1/project/priceandbrochure/list';
  static const String chatSendCollateral = '$baseUrl/bot/v1/send/collateral';
  static const String getMediaMimetypeUrl =
      '$baseUrl/lead/v1/uploadmedia/mimetype';
  static const String chatSendProjectDocument =
      '$baseUrl/bot/v1/gupshup/whatsapp/multipledoc/send';

  static const String chatListUrl = '$baseUrl/bot/v1/contact';
  static const String chatAdvanceSearchUrl =
      '$baseUrl/lead/v1/search/nameornumber';
  static const String chatUpdateStatusCount =
      '$baseUrl/bot/v1/update/readstatusandcount';
  static const String chaConversation = '$baseUrl/bot/v1/conversation/close';
  static const String chaPrivateMsgUrl = '$baseUrl/bot/v1/privatemessage';
  static const String chatSearchFilterUrl =
      '$baseUrl/lead/v1/dashboard/chat/lead/list';
  static const String chatBroadcastTemplateListUrl =
      '$baseUrl/export/v1/gupshuptemplate/list';
  static const String chatLeadUrl =
      '$baseUrl/bot/whatsapp/startchat/messagetemplate';

  /// analytics
  static const String chartProjectSVURL =
      '$baseUrl/lead/v2/sales/sitevisitchartcount';
  static const String chartOccurrenceURL =
      '$baseUrl/lead/v2/sales/projectandsv/graph';
  static const String chartSVPerHourURL = '$baseUrl/lead/v2/sales/svperhour';
  static const String chartSVBookingURL =
      '$baseUrl/lead/v2/sales/sourcewisebookingcount';
  static const String chartCPSVCountURL =
      '$baseUrl//lead/v1/sales/channelparnter/sitevisitecount';
}
