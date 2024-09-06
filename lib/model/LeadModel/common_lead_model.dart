class CommonLeadBaseModel {
  late bool success;
  late String message;
  late List<CommonLeadModel> data;

  CommonLeadBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  CommonLeadBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <CommonLeadModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(CommonLeadModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class CommonLeadModel {
  late String id;
  late String customerId;
  late String leadId;
  late String leadTypeCode;
  late String leadTypeDescription;
  late List<CommonLeadRequirements> leadRequirements;
  late String projectCode;
  late String projectName;
  late String projectDescription;
  late String projectLocationCode;
  late String projectLocationDescription;
  late String industryCode;
  late String industryDescription;
  late String presalesOwnerEmpId;
  late String presalesOwnerEmpName;
  late String salesOwnerEmpId;
  late String salesOwnerEmpName;
  late String leadStatusCode;
  late String leadStatusDescription;
  late List<CommonSiteVisitObject> siteVisitObject;
  late List<dynamic> leadFollowupObject;
  late int totalSitevisitCount;
  late String purposeOfPurchaseCode;
  late String purposeOfPurchaseDescription;
  late List<dynamic> leadNotes;
  late List<CommonSourcingManager> sourcingManagerList;
  late String createdByEmpId;
  late String createdByEmpName;
  late String updatedByEmpId;
  late String updatedByEmpName;
  late String isDirectFromSv;
  late String isFlagged;
  late String flagNote;
  late String flagByEmpId;
  late String flagByEmpName;
  late String flagAtDate;
  late String firstName;
  late String middleName;
  late String lastName;
  late String email;
  late String genderTitleCode;
  late String genderTitleDescription;
  late String cityCode;
  late String cityDescription;
  late String mobileNo;
  late String mobileCountryCode;
  late String mobileCountryDescription;
  late String mobileMasking;
  late String countryCode;
  late String countryDescription;
  late String whatsappNo;
  late String whatsappCountryCode;
  late String whatsappCountryDescription;
  late String isWhatsappAvailable;
  late String roleCode;
  late String roleDescription;
  late String titleCode;
  late String titleDescription;
  late String languageCode;
  late String languageDescription;
  late String birthDate;
  late String professionCode;
  late String professionDescription;
  late String stateCode;
  late String stateDescription;
  late String careOfName;
  late String addressLine1;
  late String addressLine2;
  late String addressLine3;
  late String addressLine4;
  late String customerType;
  late String houseNumber;
  late String additionalHouseNumber;
  late String district;
  late String countyCode;
  late String countyDescription;
  late String phone;
  late String anniversaryDate;
  late String bloodGroup;
  late String bloodGroupDescription;
  late String ageGroupCode;
  late String ageGroupDescription;
  late String occupationCode;
  late String occupationDescription;
  late String functionCode;
  late String functionDescription;
  late String annualIncomeCode;
  late String annualIncomeDescription;
  late String currentResidence;
  late String currentDesignation;
  late String officeTelephoneCountryCode;
  late String officeTelephoneNumber;
  late String officeTelephoneCountryDescription;
  late String pincode;
  late String companyLocation;
  late String companyName;
  late String companyAddress;
  late String existingAbsolutecxCustomer;
  late String existingAbsolutecxCustomerDescription;
  late String referralCustomerIsoCode;
  late String referralCustomerDialCode;
  late String referralCustomerCountryname;
  late String referralCustomerId;
  late String referralCustomerMobile;
  late String referralCustomerName;
  late String referralCustomerEmail;
  late String referralCustomerUnitNo;
  late String referralCustomerProjectName;
  late String referralCustomerProjectId;
  late String referralEmployeeId;
  late String referralEmployeeName;
  late String referralEmployeeMobile;
  late String referralEmployeeEmail;
  late String referralVendorId;
  late String referralCpCompanyName;
  late String referralCpName;
  late String referralCpReraNo;
  late String referralCpExecutive;
  late String referralCpExecutiveMobile;
  late List<dynamic> triggers;
  late List<dynamic> barriers;
  late String leadCreatedFrom;
  late String greEmpId;
  late String greEmpName;
  late List<dynamic> closingManagerList;
  late String createdAt;
  late String updatedAt;
  late int version;
  late String siteVisitDateTime;
  late String startDateTime;
  late String siteVisitSourceCode;

  CommonLeadModel() {
    id = "";
    customerId = "";
    leadId = "";
    leadTypeCode = "";
    leadTypeDescription = "";
    leadRequirements = [];
    projectCode = "";
    projectName = "";
    projectDescription = "";
    projectLocationCode = "";
    projectLocationDescription = "";
    industryCode = "";
    industryDescription = "";
    presalesOwnerEmpId = "";
    presalesOwnerEmpName = "";
    salesOwnerEmpId = "";
    salesOwnerEmpName = "";
    leadStatusCode = "";
    leadStatusDescription = "";
    siteVisitObject = [];
    leadFollowupObject = [];
    totalSitevisitCount = 0;
    purposeOfPurchaseCode = "";
    purposeOfPurchaseDescription = "";
    leadNotes = [];
    sourcingManagerList = [];
    createdByEmpId = "";
    createdByEmpName = "";
    updatedByEmpId = "";
    updatedByEmpName = "";
    isDirectFromSv = "";
    isFlagged = "";
    flagNote = "";
    flagByEmpId = "";
    flagByEmpName = "";
    flagAtDate = "";
    firstName = "";
    middleName = "";
    lastName = "";
    email = "";
    genderTitleCode = "";
    genderTitleDescription = "";
    cityCode = "";
    cityDescription = "";
    mobileNo = "";
    mobileCountryCode = "";
    mobileCountryDescription = "";
    mobileMasking = "";
    countryCode = "";
    countryDescription = "";
    whatsappNo = "";
    whatsappCountryCode = "";
    whatsappCountryDescription = "";
    isWhatsappAvailable = "";
    roleCode = "";
    roleDescription = "";
    titleCode = "";
    titleDescription = "";
    languageCode = "";
    languageDescription = "";
    birthDate = "";
    professionCode = "";
    professionDescription = "";
    stateCode = "";
    stateDescription = "";
    careOfName = "";
    addressLine1 = "";
    addressLine2 = "";
    addressLine3 = "";
    addressLine4 = "";
    customerType = "";
    houseNumber = "";
    additionalHouseNumber = "";
    district = "";
    countyCode = "";
    countyDescription = "";
    phone = "";
    anniversaryDate = "";
    bloodGroup = "";
    bloodGroupDescription = "";
    ageGroupCode = "";
    ageGroupDescription = "";
    occupationCode = "";
    occupationDescription = "";
    functionCode = "";
    functionDescription = "";
    annualIncomeCode = "";
    annualIncomeDescription = "";
    currentResidence = "";
    currentDesignation = "";
    officeTelephoneCountryCode = "";
    officeTelephoneNumber = "";
    officeTelephoneCountryDescription = "";
    pincode = "";
    companyLocation = "";
    companyName = "";
    companyAddress = "";
    existingAbsolutecxCustomer = "";
    existingAbsolutecxCustomerDescription = "";
    referralCustomerIsoCode = "";
    referralCustomerDialCode = "";
    referralCustomerCountryname = "";
    referralCustomerId = "";
    referralCustomerMobile = "";
    referralCustomerName = "";
    referralCustomerEmail = "";
    referralCustomerUnitNo = "";
    referralCustomerProjectName = "";
    referralCustomerProjectId = "";
    referralEmployeeId = "";
    referralEmployeeName = "";
    referralEmployeeMobile = "";
    referralEmployeeEmail = "";
    referralVendorId = "";
    referralCpCompanyName = "";
    referralCpName = "";
    referralCpReraNo = "";
    referralCpExecutive = "";
    referralCpExecutiveMobile = "";
    triggers = [];
    barriers = [];
    leadCreatedFrom = "";
    greEmpId = "";
    greEmpName = "";
    closingManagerList = [];
    createdAt = "";
    updatedAt = "";
    version = 0;
    siteVisitDateTime = "";
    startDateTime = "";
    siteVisitSourceCode = "";
  }

  CommonLeadModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    customerId = json['customer_id'] ?? "";
    leadId = json['lead_id'] ?? "";
    leadTypeCode = json['lead_type_code'] ?? "";
    leadTypeDescription = json['lead_type_description'] ?? "";
    leadRequirements = (json['lead_requirements'] as List)
        .map((e) => CommonLeadRequirements.fromJson(e))
        .toList();
    projectCode = json['project_code'] ?? "";
    projectName = json['project_name'] ?? "";
    projectDescription = json['project_description'] ?? "";
    projectLocationCode = json['project_location_code'] ?? "";
    projectLocationDescription = json['project_location_description'] ?? "";
    industryCode = json['industry_code'] ?? "";
    industryDescription = json['industry_description'] ?? "";
    presalesOwnerEmpId = json['presales_owner_emp_id'] ?? "";
    presalesOwnerEmpName = json['presales_owner_emp_name'] ?? "";
    salesOwnerEmpId = json['sales_owner_emp_id'] ?? "";
    salesOwnerEmpName = json['sales_owner_emp_name'] ?? "";
    leadStatusCode = json['lead_status_code'] ?? "";
    leadStatusDescription = json['lead_status_description'] ?? "";
    siteVisitObject = (json['site_visit_object'] as List)
        .map((e) => CommonSiteVisitObject.fromJson(e))
        .toList();
    leadFollowupObject = json['lead_followup_object'] ?? [];
    totalSitevisitCount = json['total_sitevisit_count'] ?? 0;
    purposeOfPurchaseCode = json['purpose_of_purchase_code'] ?? "";
    purposeOfPurchaseDescription =
        json['purpose_of_purchase_description'] ?? "";
    leadNotes = json['lead_notes'] ?? [];
    sourcingManagerList = (json['sourcing_manager_list'] as List)
        .map((e) => CommonSourcingManager.fromJson(e))
        .toList();
    createdByEmpId = json['created_by_emp_id'] ?? "";
    createdByEmpName = json['created_by_emp_name'] ?? "";
    updatedByEmpId = json['updated_by_emp_id'] ?? "";
    updatedByEmpName = json['updated_by_emp_name'] ?? "";
    isDirectFromSv = json['is_direct_from_sv'] ?? "";
    isFlagged = json['is_flagged'] ?? "";
    flagNote = json['flag_note'] ?? "";
    flagByEmpId = json['flag_by_emp_id'] ?? "";
    flagByEmpName = json['flag_by_emp_name'] ?? "";
    flagAtDate = json['flag_at_date'] ?? "";
    firstName = json['first_name'] ?? "";
    middleName = json['middle_name'] ?? "";
    lastName = json['last_name'] ?? "";
    email = json['email'] ?? "";
    genderTitleCode = json['gender_title_code'] ?? "";
    genderTitleDescription = json['gender_title_description'] ?? "";
    cityCode = json['city_code'] ?? "";
    cityDescription = json['city_description'] ?? "";
    mobileNo = json['mobile_no'] ?? "";
    mobileCountryCode = json['mobile_country_code'] ?? "";
    mobileCountryDescription = json['mobile_country_description'] ?? "";
    mobileMasking = json['mobile_masking'] ?? "";
    countryCode = json['country_code'] ?? "";
    countryDescription = json['country_description'] ?? "";
    whatsappNo = json['whatsapp_no'] ?? "";
    whatsappCountryCode = json['whatsapp_country_code'] ?? "";
    whatsappCountryDescription = json['whatsapp_country_description'] ?? "";
    isWhatsappAvailable = json['is_whatsapp_available'] ?? "";
    roleCode = json['role_code'] ?? "";
    roleDescription = json['role_description'] ?? "";
    titleCode = json['title_code'] ?? "";
    titleDescription = json['title_description'] ?? "";
    languageCode = json['language_code'] ?? "";
    languageDescription = json['language_description'] ?? "";
    birthDate = json['birth_date'] ?? "";
    professionCode = json['profession_code'] ?? "";
    professionDescription = json['profession_description'] ?? "";
    stateCode = json['state_code'] ?? "";
    stateDescription = json['state_description'] ?? "";
    careOfName = json['care_of_name'] ?? "";
    addressLine1 = json['address_line1'] ?? "";
    addressLine2 = json['address_line2'] ?? "";
    addressLine3 = json['address_line3'] ?? "";
    addressLine4 = json['address_line4'] ?? "";
    customerType = json['customer_type'] ?? "";
    houseNumber = json['house_number'] ?? "";
    additionalHouseNumber = json['additional_house_number'] ?? "";
    district = json['district'] ?? "";
    countyCode = json['county_code'] ?? "";
    countyDescription = json['county_description'] ?? "";
    phone = json['phone'] ?? "";
    anniversaryDate = json['anniversary_date'] ?? "";
    bloodGroup = json['blood_group'] ?? "";
    bloodGroupDescription = json['blood_group_description'] ?? "";
    ageGroupCode = json['age_group_code'] ?? "";
    ageGroupDescription = json['age_group_description'] ?? "";
    occupationCode = json['occupation_code'] ?? "";
    occupationDescription = json['occupation_description'] ?? "";
    functionCode = json['function_code'] ?? "";
    functionDescription = json['function_description'] ?? "";
    annualIncomeCode = json['annual_income_code'] ?? "";
    annualIncomeDescription = json['annual_income_description'] ?? "";
    currentResidence = json['current_residence'] ?? "";
    currentDesignation = json['current_designation'] ?? "";
    officeTelephoneCountryCode = json['office_telephone_country_code'] ?? "";
    officeTelephoneNumber = json['office_telephone_number'] ?? "";
    officeTelephoneCountryDescription =
        json['office_telephone_country_description'] ?? "";
    pincode = json['pincode'] ?? "";
    companyLocation = json['company_location'] ?? "";
    companyName = json['company_name'] ?? "";
    companyAddress = json['company_address'] ?? "";
    existingAbsolutecxCustomer = json['existing_absolutecx_customer'] ?? "";
    existingAbsolutecxCustomerDescription =
        json['existing_absolutecx_customer_description'] ?? "";
    referralCustomerIsoCode = json['referral_customer_iso_code'] ?? "";
    referralCustomerDialCode = json['referral_customer_dial_code'] ?? "";
    referralCustomerCountryname = json['referral_customer_countryname'] ?? "";
    referralCustomerId = json['referral_customer_id'] ?? "";
    referralCustomerMobile = json['referral_customer_mobile'] ?? "";
    referralCustomerName = json['referral_customer_name'] ?? "";
    referralCustomerEmail = json['referral_customer_email'] ?? "";
    referralCustomerUnitNo = json['referral_customer_unit_no'] ?? "";
    referralCustomerProjectName = json['referral_customer_project_name'] ?? "";
    referralCustomerProjectId = json['referral_customer_project_id'] ?? "";
    referralEmployeeId = json['referral_employee_id'] ?? "";
    referralEmployeeName = json['referral_employee_name'] ?? "";
    referralEmployeeMobile = json['referral_employee_mobile'] ?? "";
    referralEmployeeEmail = json['referral_employee_email'] ?? "";
    referralVendorId = json['referral_vendor_id'] ?? "";
    referralCpCompanyName = json['referral_cp_company_name'] ?? "";
    referralCpName = json['referral_cp_name'] ?? "";
    referralCpReraNo = json['referral_cp_rera_no'] ?? "";
    referralCpExecutive = json['referral_cp_executive'] ?? "";
    referralCpExecutiveMobile = json['referral_cp_executive_mobile'] ?? "";
    triggers = json['triggers'] ?? [];
    barriers = json['barriers'] ?? [];
    leadCreatedFrom = json['lead_created_from'] ?? "";
    greEmpId = json['gre_emp_id'] ?? "";
    greEmpName = json['gre_emp_name'] ?? "";
    closingManagerList = json['closing_manager_list'] ?? [];
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    version = json['__v'] ?? 0;
    siteVisitDateTime = json['site_visit_date_time'] ?? "";
    startDateTime = json['start_date_time'] ?? "";
    siteVisitSourceCode = json['site_visit_source_code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['customer_id'] = customerId;
    data['lead_id'] = leadId;
    data['lead_type_code'] = leadTypeCode;
    data['lead_type_description'] = leadTypeDescription;
    data['lead_requirements'] =
        leadRequirements.map((v) => v.toJson()).toList();
    data['project_code'] = projectCode;
    data['project_name'] = projectName;
    data['project_description'] = projectDescription;
    data['project_location_code'] = projectLocationCode;
    data['project_location_description'] = projectLocationDescription;
    data['industry_code'] = industryCode;
    data['industry_description'] = industryDescription;
    data['presales_owner_emp_id'] = presalesOwnerEmpId;
    data['presales_owner_emp_name'] = presalesOwnerEmpName;
    data['sales_owner_emp_id'] = salesOwnerEmpId;
    data['sales_owner_emp_name'] = salesOwnerEmpName;
    data['lead_status_code'] = leadStatusCode;
    data['lead_status_description'] = leadStatusDescription;
    data['site_visit_object'] = siteVisitObject.map((v) => v.toJson()).toList();
    data['lead_followup_object'] = leadFollowupObject;
    data['total_sitevisit_count'] = totalSitevisitCount;
    data['purpose_of_purchase_code'] = purposeOfPurchaseCode;
    data['purpose_of_purchase_description'] = purposeOfPurchaseDescription;
    data['lead_notes'] = leadNotes;
    data['sourcing_manager_list'] =
        sourcingManagerList.map((v) => v.toJson()).toList();
    data['created_by_emp_id'] = createdByEmpId;
    data['created_by_emp_name'] = createdByEmpName;
    data['updated_by_emp_id'] = updatedByEmpId;
    data['updated_by_emp_name'] = updatedByEmpName;
    data['is_direct_from_sv'] = isDirectFromSv;
    data['is_flagged'] = isFlagged;
    data['flag_note'] = flagNote;
    data['flag_by_emp_id'] = flagByEmpId;
    data['flag_by_emp_name'] = flagByEmpName;
    data['flag_at_date'] = flagAtDate;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gender_title_code'] = genderTitleCode;
    data['gender_title_description'] = genderTitleDescription;
    data['city_code'] = cityCode;
    data['city_description'] = cityDescription;
    data['mobile_no'] = mobileNo;
    data['mobile_country_code'] = mobileCountryCode;
    data['mobile_country_description'] = mobileCountryDescription;
    data['mobile_masking'] = mobileMasking;
    data['country_code'] = countryCode;
    data['country_description'] = countryDescription;
    data['whatsapp_no'] = whatsappNo;
    data['whatsapp_country_code'] = whatsappCountryCode;
    data['whatsapp_country_description'] = whatsappCountryDescription;
    data['is_whatsapp_available'] = isWhatsappAvailable;
    data['role_code'] = roleCode;
    data['role_description'] = roleDescription;
    data['title_code'] = titleCode;
    data['title_description'] = titleDescription;
    data['language_code'] = languageCode;
    data['language_description'] = languageDescription;
    data['birth_date'] = birthDate;
    data['profession_code'] = professionCode;
    data['profession_description'] = professionDescription;
    data['state_code'] = stateCode;
    data['state_description'] = stateDescription;
    data['care_of_name'] = careOfName;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['address_line3'] = addressLine3;
    data['address_line4'] = addressLine4;
    data['customer_type'] = customerType;
    data['house_number'] = houseNumber;
    data['additional_house_number'] = additionalHouseNumber;
    data['district'] = district;
    data['county_code'] = countyCode;
    data['county_description'] = countyDescription;
    data['phone'] = phone;
    data['anniversary_date'] = anniversaryDate;
    data['blood_group'] = bloodGroup;
    data['blood_group_description'] = bloodGroupDescription;
    data['age_group_code'] = ageGroupCode;
    data['age_group_description'] = ageGroupDescription;
    data['occupation_code'] = occupationCode;
    data['occupation_description'] = occupationDescription;
    data['function_code'] = functionCode;
    data['function_description'] = functionDescription;
    data['annual_income_code'] = annualIncomeCode;
    data['annual_income_description'] = annualIncomeDescription;
    data['current_residence'] = currentResidence;
    data['current_designation'] = currentDesignation;
    data['office_telephone_country_code'] = officeTelephoneCountryCode;
    data['office_telephone_number'] = officeTelephoneNumber;
    data['office_telephone_country_description'] =
        officeTelephoneCountryDescription;
    data['pincode'] = pincode;
    data['company_location'] = companyLocation;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['existing_absolutecx_customer'] = existingAbsolutecxCustomer;
    data['existing_absolutecx_customer_description'] =
        existingAbsolutecxCustomerDescription;
    data['referral_customer_iso_code'] = referralCustomerIsoCode;
    data['referral_customer_dial_code'] = referralCustomerDialCode;
    data['referral_customer_countryname'] = referralCustomerCountryname;
    data['referral_customer_id'] = referralCustomerId;
    data['referral_customer_mobile'] = referralCustomerMobile;
    data['referral_customer_name'] = referralCustomerName;
    data['referral_customer_email'] = referralCustomerEmail;
    data['referral_customer_unit_no'] = referralCustomerUnitNo;
    data['referral_customer_project_name'] = referralCustomerProjectName;
    data['referral_customer_project_id'] = referralCustomerProjectId;
    data['referral_employee_id'] = referralEmployeeId;
    data['referral_employee_name'] = referralEmployeeName;
    data['referral_employee_mobile'] = referralEmployeeMobile;
    data['referral_employee_email'] = referralEmployeeEmail;
    data['referral_vendor_id'] = referralVendorId;
    data['referral_cp_company_name'] = referralCpCompanyName;
    data['referral_cp_name'] = referralCpName;
    data['referral_cp_rera_no'] = referralCpReraNo;
    data['referral_cp_executive'] = referralCpExecutive;
    data['referral_cp_executive_mobile'] = referralCpExecutiveMobile;
    data['triggers'] = triggers;
    data['barriers'] = barriers;
    data['lead_created_from'] = leadCreatedFrom;
    data['gre_emp_id'] = greEmpId;
    data['gre_emp_name'] = greEmpName;
    data['closing_manager_list'] = closingManagerList;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = version;
    data['site_visit_date_time'] = siteVisitDateTime;
    data['start_date_time'] = startDateTime;
    data['site_visit_source_code'] = siteVisitSourceCode;
    return data;
  }
}

class CommonLeadRequirements {
  late String requirementTypeCode;
  late String requirementTypeDescription;
  late String propertyTypeCode;
  late String propertyTypeDescription;
  late String requirementId;
  late String statusCode;
  late String statusDescription;
  late String isUnitIdentified;
  late String createdBy;
  late String createdDate;
  late String updatedBy;
  late String updatedDate;
  late String propertyName;
  late String propertyLocationCode;
  late String propertyLocationDescription;
  late String propertyCode;
  late String requirementCode;
  late String preferredProject;

  CommonLeadRequirements() {
    requirementTypeCode = "";
    requirementTypeDescription = "";
    propertyTypeCode = "";
    propertyTypeDescription = "";
    requirementId = "";
    statusCode = "";
    statusDescription = "";
    isUnitIdentified = "";
    createdBy = "";
    createdDate = "";
    updatedBy = "";
    updatedDate = "";
    propertyName = "";
    propertyLocationCode = "";
    propertyLocationDescription = "";
    propertyCode = "";
    requirementCode = "";
    preferredProject = "";
  }

  CommonLeadRequirements.fromJson(Map<String, dynamic> json) {
    requirementTypeCode = json['requirement_type_code'] ?? "";
    requirementTypeDescription = json['requirement_type_description'] ?? "";
    propertyTypeCode = json['property_type_code'] ?? "";
    propertyTypeDescription = json['property_type_description'] ?? "";
    requirementId = json['requirement_id'] ?? "";
    statusCode = json['status_code'] ?? "";
    statusDescription = json['status_description'] ?? "";
    isUnitIdentified = json['is_unit_identified'] ?? "";
    createdBy = json['created_by'] ?? "";
    createdDate = json['created_date'] ?? "";
    updatedBy = json['updated_by'] ?? "";
    updatedDate = json['updated_date'] ?? "";
    propertyName = json['property_name'] ?? "";
    propertyLocationCode = json['property_location_code'] ?? "";
    propertyLocationDescription = json['property_location_description'] ?? "";
    propertyCode = json['property_code'] ?? "";
    requirementCode = json['requirement_code'] ?? "";
    preferredProject = json['preferred_project'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requirement_type_code'] = requirementTypeCode;
    data['requirement_type_description'] = requirementTypeDescription;
    data['property_type_code'] = propertyTypeCode;
    data['property_type_description'] = propertyTypeDescription;
    data['requirement_id'] = requirementId;
    data['status_code'] = statusCode;
    data['status_description'] = statusDescription;
    data['is_unit_identified'] = isUnitIdentified;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['updated_by'] = updatedBy;
    data['updated_date'] = updatedDate;
    data['property_name'] = propertyName;
    data['property_location_code'] = propertyLocationCode;
    data['property_location_description'] = propertyLocationDescription;
    data['property_code'] = propertyCode;
    data['requirement_code'] = requirementCode;
    data['preferred_project'] = preferredProject;
    return data;
  }
}

class CommonSiteVisitObject {
  late String visitDate;
  late String startTime;
  late String endTime;
  late String empId;
  late String empName;
  late String location;
  late String purposeOfVisit;
  late String leadStatus;
  late String notes;
  late String project;

  CommonSiteVisitObject() {
    visitDate = "";
    startTime = "";
    endTime = "";
    empId = "";
    empName = "";
    location = "";
    purposeOfVisit = "";
    leadStatus = "";
    notes = "";
    project = "";
  }

  CommonSiteVisitObject.fromJson(Map<String, dynamic> json) {
    visitDate = json['visit_date'] ?? "";
    startTime = json['start_time'] ?? "";
    endTime = json['end_time'] ?? "";
    empId = json['emp_id'] ?? "";
    empName = json['emp_name'] ?? "";
    location = json['location'] ?? "";
    purposeOfVisit = json['purpose_of_visit'] ?? "";
    leadStatus = json['lead_status'] ?? "";
    notes = json['notes'] ?? "";
    project = json['project'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visit_date'] = visitDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['emp_id'] = empId;
    data['emp_name'] = empName;
    data['location'] = location;
    data['purpose_of_visit'] = purposeOfVisit;
    data['lead_status'] = leadStatus;
    data['notes'] = notes;
    data['project'] = project;
    return data;
  }
}

class CommonSourcingManager {
  late String empId;
  late String empName;
  late String empEmail;
  late String empMobile;
  late String locationCode;
  late String locationDescription;

  CommonSourcingManager() {
    empId = "";
    empName = "";
    empEmail = "";
    empMobile = "";
    locationCode = "";
    locationDescription = "";
  }

  CommonSourcingManager.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'] ?? "";
    empName = json['emp_name'] ?? "";
    empEmail = json['emp_email'] ?? "";
    empMobile = json['emp_mobile'] ?? "";
    locationCode = json['location_code'] ?? "";
    locationDescription = json['location_description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp_id'] = empId;
    data['emp_name'] = empName;
    data['emp_email'] = empEmail;
    data['emp_mobile'] = empMobile;
    data['location_code'] = locationCode;
    data['location_description'] = locationDescription;
    return data;
  }
}
