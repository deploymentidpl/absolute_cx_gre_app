class SVExistingDetail {

  SVExistingDetail({this.sId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.mobileCountryCode,
    this.mobileNo,
    this.altMobileCountryCode,
    this.altMobileNo,
    this.residentialTelephoneNoCountryCode,
    this.residentialTelephoneNo,
    this.email,
    this.titleCode,
    this.titleName,
    this.currentResidenceLocation,
    this.pincode,
    this.ageGroupCode,
    this.ageGroupDescription,
    this.occupationCode,
    this.occupationDescription,
    this.purposeOfPurchaseCode,
    this.purposeOfPurchaseDescription,
    this.configurationCode,
    this.configurationDescription,
    this.industryCode,
    this.industryDescription,
    this.budgetCode,
    this.budgetDescription,
    this.functionCode,
    this.functionDescription,
    this.annualIncomeCode,
    this.annualIncomeDescription,
    this.designationCode,
    this.designationDescription,
    this.companyName,
    this.companyAddress,
    this.companyLocation,
    this.siteVisitDateTime,
    this.cityCode,
    this.cityDescription,
    this.countryCode,
    this.countryDescription,
    this.whatsappNo,
    this.whatsappCountryCode,
    this.whatsappCountryDescription,
    this.isWhatsappAvailable,
    this.sourceDescription,
    this.locationCode,
    this.locationDescription,
    this.locationText,
    this.customerId,
    this.createdByEmpId,
    this.createdByEmpName,
    this.greEmpId,
    this.greEmpName,
    this.updatedByEmpId,
    this.updatedByEmpName,
    this.createdAt,
    this.updatedAt,
    this.officeTelephoneNumber,
    this.leadId,
    this.sitevisitId,
    this.svformId,
    this.currentVisitToken,
    this.projectCode,
    this.projectName,
    this.sourceCode,
    this.leadStatusCode,
    this.leadStatusDescription,
    this.siteVisitSourceCode,
    this.siteVisitSourceDescription,
    this.referralCustomerIsoCode,
    this.referralCustomerId,
    this.referralCustomerDialCode,
    this.referralCustomerCountryname,
    this.referralCustomerMobile,
    this.referralCustomerName,
    this.referralCustomerEmail,
    this.referralCustomerUnitNo,
    this.referralCustomerProjectName,
    this.referralCustomerProjectId,
    this.referralEmployeeId,
    this.referralEmployeeName,
    this.referralEmployeeMobile,
    this.referralEmployeeEmail,
    this.referralVendorId,
    this.referralCpName,
    this.referralCpCompanyName,
    this.referralCpReraNo,
    this.referralCpExecutive,
    this.referralCpExecutiveMobile,
    this.sourcingManagerList,
    this.svWaitListNumber,
    this.svAttendeeCode,
    this.svAttendeeDescription,
    this.isAvailable,
    this.isSys,
    this.isDel,
    this.isUpdate,
    this.isTokenUpdated,
    this.svOwnerId,
    this.svOwnerName});

  SVExistingDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    mobileCountryCode = json['mobile_country_code'];
    mobileNo = json['mobile_no'];
    altMobileCountryCode = json['alt_mobile_country_code'];
    altMobileNo = json['alt_mobile_no'];
    residentialTelephoneNoCountryCode =
    json['residential_telephone_no_country_code'];
    residentialTelephoneNo = json['residential_telephone_no'];
    email = json['email'];
    titleCode = json['title_code'];
    titleName = json['title_description'];
    currentResidenceLocation = json['current_residence'];
    pincode = json['pincode'];
    ageGroupCode = json['age_group_code'];
    ageGroupDescription = json['age_group_description'];
    occupationCode = json['occupation_code'];
    occupationDescription = json['occupation_description'];
    purposeOfPurchaseCode = json['purpose_of_purchase_code'];
    purposeOfPurchaseDescription = json['purpose_of_purchase_description'];
    configurationCode = json['configuration_code'];
    configurationDescription = json['configuration_description'];
    industryCode = json['industry_code'];
    industryDescription = json['industry_description'];
    budgetCode = json['budget_code'];
    budgetDescription = json['budget_description'];
    functionCode = json['function_code'];
    functionDescription = json['function_description'];
    annualIncomeCode = json['annual_income_code'];
    annualIncomeDescription = json['annual_income_description'];
    designationCode = json['designation_code'];
    designationDescription = json['current_designation'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyLocation = json['company_location'];
    siteVisitDateTime = json['site_visit_date_time'];
    cityCode = json['city_code'];
    cityDescription = json['city_description'];
    countryCode = json['country_code'];
    countryDescription = json['country_description'];
    whatsappNo = json['whatsapp_no'];
    whatsappCountryCode = json['whatsapp_country_code'];
    whatsappCountryDescription = json['whatsapp_country_description'];
    isWhatsappAvailable = json['is_whatsapp_available'];
    sourceDescription = json['source_description'];
    locationCode = json['location_code'];
    locationDescription = json['location_description'];
    locationText = json['location_text'];
    customerId = json['customer_id'];
    createdByEmpId = json['created_by_emp_id'];
    createdByEmpName = json['created_by_emp_name'];
    greEmpId = json['gre_emp_id'];
    greEmpName = json['gre_emp_name'];
    updatedByEmpId = json['updated_by_emp_id'];
    updatedByEmpName = json['updated_by_emp_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    officeTelephoneNumber = json['office_telephone_number'];
    leadId = json['lead_id'];
    sitevisitId = json['sitevisit_id'];
    svformId = json['svform_id'];
    currentVisitToken = json['current_visit_token'];
    projectCode = json['project_code'];
    projectName = json['project_name'];
    sourceCode = json['source_code'];
    leadStatusCode = json['lead_status_code'];
    leadStatusDescription = json['lead_status_description'];
    siteVisitSourceCode = json['site_visit_source_code'];
    siteVisitSourceDescription = json['site_visit_source_description'];
    referralCustomerIsoCode = json['referral_customer_iso_code'];
    referralCustomerId = json['referral_customer_id'];
    referralCustomerDialCode = json['referral_customer_dial_code'];
    referralCustomerCountryname = json['referral_customer_countryname'];
    referralCustomerMobile = json['referral_customer_mobile'];
    referralCustomerName = json['referral_customer_name'];
    referralCustomerEmail = json['referral_customer_email'];
    referralCustomerUnitNo = json['referral_customer_unit_no'];
    referralCustomerProjectName = json['referral_customer_project_name'];
    referralCustomerProjectId = json['referral_customer_project_id'];
    referralEmployeeId = json['referral_employee_id'];
    referralEmployeeName = json['referral_employee_name'];
    referralEmployeeMobile = json['referral_employee_mobile'];
    referralEmployeeEmail = json['referral_employee_email'];
    referralVendorId = json['referral_vendor_id'];
    referralCpName = json['referral_cp_name'];
    referralCpCompanyName = json['referral_cp_company_name'];
    referralCpReraNo = json['referral_cp_rera_no'];
    referralCpExecutive = json['referral_cp_executive'];
    referralCpExecutiveMobile = json['referral_cp_executive_mobile'];
    if (json['sourcing_manager_list'] != null) {
      sourcingManagerList = <SourcingManagerList>[];
      json['sourcing_manager_list'].forEach((v) {
        sourcingManagerList!.add(SourcingManagerList.fromJson(v));
      });
    }
    svWaitListNumber = json['sv_wait_list_number'];
    svAttendeeCode = json['sv_attendee_code'];
    svAttendeeDescription = json['sv_attendee_description'];
    isAvailable = json['is_available'];
    isSys = json['is_sys'];
    isDel = json['is_del'];
    isUpdate = json['is_update'];
    isTokenUpdated = json['is_token_updated'];
    svOwnerId = json['sv_owner_id'];
    svOwnerName = json['sv_owner_name'];
  }
  String? sId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobileCountryCode;
  String? mobileNo;
  String? altMobileCountryCode;
  String? altMobileNo;
  String? residentialTelephoneNoCountryCode;
  String? residentialTelephoneNo;
  String? email;
  String? titleCode;
  String? titleName;
  String? currentResidenceLocation;
  String? pincode;
  String? ageGroupCode;
  String? ageGroupDescription;
  String? occupationCode;
  String? occupationDescription;
  String? purposeOfPurchaseCode;
  String? purposeOfPurchaseDescription;
  String? configurationCode;
  String? configurationDescription;
  String? industryCode;
  String? industryDescription;
  String? budgetCode;
  String? budgetDescription;
  String? functionCode;
  String? functionDescription;
  String? annualIncomeCode;
  String? annualIncomeDescription;
  String? designationCode;
  String? designationDescription;
  String? companyName;
  String? companyAddress;
  String? companyLocation;
  String? siteVisitDateTime;
  String? cityCode;
  String? cityDescription;
  String? countryCode;
  String? countryDescription;
  String? whatsappNo;
  String? whatsappCountryCode;
  String? whatsappCountryDescription;
  String? isWhatsappAvailable;
  String? sourceDescription;
  String? locationCode;
  String? locationDescription;
  String? locationText;
  String? customerId;
  String? createdByEmpId;
  String? createdByEmpName;
  String? greEmpId;
  String? greEmpName;
  String? updatedByEmpId;
  String? updatedByEmpName;
  String? createdAt;
  String? updatedAt;
  String? officeTelephoneNumber;
  String? leadId;
  String? sitevisitId;
  String? svformId;
  int? currentVisitToken;
  String? projectCode;
  String? projectName;
  String? sourceCode;
  String? leadStatusCode;
  String? leadStatusDescription;
  String? siteVisitSourceCode;
  String? siteVisitSourceDescription;
  String? referralCustomerIsoCode;
  String? referralCustomerId;
  String? referralCustomerDialCode;
  String? referralCustomerCountryname;
  String? referralCustomerMobile;
  String? referralCustomerName;
  String? referralCustomerEmail;
  String? referralCustomerUnitNo;
  String? referralCustomerProjectName;
  String? referralCustomerProjectId;
  String? referralEmployeeId;
  String? referralEmployeeName;
  String? referralEmployeeMobile;
  String? referralEmployeeEmail;
  String? referralVendorId;
  String? referralCpName;
  String? referralCpCompanyName;
  String? referralCpReraNo;
  String? referralCpExecutive;
  String? referralCpExecutiveMobile;
  List<SourcingManagerList>? sourcingManagerList;
  int? svWaitListNumber;
  String? svAttendeeCode;
  String? svAttendeeDescription;
  String? isAvailable;
  String? isSys;
  String? isDel;
  String? isUpdate;
  String? isTokenUpdated;
  String? svOwnerId;
  String? svOwnerName;
}

class SourcingManagerList {

  SourcingManagerList({this.ownerEmpId,
    this.ownerEmpName,
    this.sId,
    this.createdAt,
    this.updatedAt});

  SourcingManagerList.fromJson(Map<String, dynamic> json) {
    ownerEmpId = json['owner_emp_id'];
    ownerEmpName = json['owner_emp_name'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? ownerEmpId;
  String? ownerEmpName;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['owner_emp_id'] = ownerEmpId;
    data['owner_emp_name'] = ownerEmpName;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

  