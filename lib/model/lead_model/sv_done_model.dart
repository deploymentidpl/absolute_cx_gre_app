class SiteVisitDataModel {
  SiteVisitDataModel({
    this.sId,
    this.leadId,
    this.projectCode,
    this.projectDescription,
    this.siteVisitStatus,
    this.leadStatusCode,
    this.leadStatusDescription,
    this.leadSourceCode,
    this.leadSourceCodeDescription,
    this.siteVisitSourceCode,
    this.siteVisitSourceDescription,
    this.siteVisitDateTime,
    this.startDateTime,
    this.endDateTime,
    this.startOwnerEmpId,
    this.startOwnerEmpName,
    this.endOwnerEmpId,
    this.endOwnerEmpName,
    this.startSitevisit,
    this.endSitevisit,
    this.endSvNote,
    this.isConfirmByEmployee,
    this.employeeName,
    this.isConfirmByCustomer,
    this.referralCustomerIsoCode,
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
    this.referralCpReraNo,
    this.referralCpExecutive,
    this.referralCpExecutiveMobile,
    this.createdByEmpId,
    this.createdByEmpName,
    this.svOwnerId,
    this.svOwnerName,
    this.claimByOwnerId,
    this.claimByOwnerName,
    this.updatedByEmpId,
    this.updatedByEmpName,
    this.isAvailable,
    this.isSys,
    this.isDel,
    this.isDirectFromSv,
    this.sourcingManagerList,
    this.closingManager,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.feedbackCode,
  });

  SiteVisitDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    leadId = json['lead_id'];
    projectCode = json['project_code'];
    projectDescription = json['project_description'];
    siteVisitStatus = json['site_visit_status'];
    leadStatusCode = json['lead_status_code'];
    leadStatusDescription = json['lead_status_description'];
    leadSourceCode = json['lead_source_code'];
    leadSourceCodeDescription = json['lead_source_code_description'];
    siteVisitSourceCode = json['site_visit_source_code'];
    siteVisitSourceDescription = json['site_visit_source_description'];
    siteVisitDateTime = json['site_visit_date_time'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
    startOwnerEmpId = json['start_owner_emp_id'];
    startOwnerEmpName = json['start_owner_emp_name'];
    endOwnerEmpId = json['end_owner_emp_id'];
    endOwnerEmpName = json['end_owner_emp_name'];
    startSitevisit = json['start_sitevisit'];
    endSitevisit = json['end_sitevisit'];
    endSvNote = json['end_sv_note'];
    isConfirmByEmployee = json['is_confirm_by_employee'];
    employeeName = json['employee_name'];
    isConfirmByCustomer = json['is_confirm_by_customer'];
    referralCustomerIsoCode = json['referral_customer_iso_code'];
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
    referralCpReraNo = json['referral_cp_rera_no'];
    referralCpExecutive = json['referral_cp_executive'];
    referralCpExecutiveMobile = json['referral_cp_executive_mobile'];
    createdByEmpId = json['created_by_emp_id'];
    createdByEmpName = json['created_by_emp_name'];
    svOwnerId = json['sv_owner_id'];
    svOwnerName = json['sv_owner_name'];
    claimByOwnerId = json['claim_by_owner_id'];
    claimByOwnerName = json['claim_by_owner_name'];
    updatedByEmpId = json['updated_by_emp_id'];
    updatedByEmpName = json['updated_by_emp_name'];
    isAvailable = json['is_available'];
    isSys = json['is_sys'];
    isDel = json['is_del'];
    isDirectFromSv = json['is_direct_from_sv'];
    if (json['sourcing_manager_list'] != null) {
      sourcingManagerList = <SourcingManagerList>[];
      json['sourcing_manager_list'].forEach((v) {
        sourcingManagerList!.add(SourcingManagerList.fromJson(v));
      });
    }
    if (json['closing_manager'] != null) {
      closingManager = <ClosingManagerList>[];
      json['closing_manager'].forEach((v) {
        closingManager!.add(ClosingManagerList.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    feedbackCode = json['site_visit_feedback_by_emp'];
  }

  String? sId;
  String? leadId;
  String? projectCode;
  String? projectDescription;
  String? siteVisitStatus;
  String? leadStatusCode;
  String? leadStatusDescription;
  String? leadSourceCode;
  String? leadSourceCodeDescription;
  String? siteVisitSourceCode;
  String? siteVisitSourceDescription;
  String? siteVisitDateTime;
  String? startDateTime;
  String? endDateTime;
  String? startOwnerEmpId;
  String? startOwnerEmpName;
  String? endOwnerEmpId;
  String? endOwnerEmpName;
  String? startSitevisit;
  String? endSitevisit;
  String? endSvNote;
  String? isConfirmByEmployee;
  String? employeeName;
  String? isConfirmByCustomer;
  String? referralCustomerIsoCode;
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
  String? referralCpReraNo;
  String? referralCpExecutive;
  String? referralCpExecutiveMobile;
  String? createdByEmpId;
  String? createdByEmpName;
  String? svOwnerId;
  String? svOwnerName;
  String? claimByOwnerId;
  String? claimByOwnerName;
  String? updatedByEmpId;
  String? updatedByEmpName;
  String? isAvailable;
  String? isSys;
  String? isDel;
  String? isDirectFromSv;
  List<SourcingManagerList>? sourcingManagerList;
  List<ClosingManagerList>? closingManager;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? feedbackCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['lead_id'] = leadId;
    data['project_code'] = projectCode;
    data['project_description'] = projectDescription;
    data['site_visit_status'] = siteVisitStatus;
    data['lead_status_code'] = leadStatusCode;
    data['lead_status_description'] = leadStatusDescription;
    data['lead_source_code'] = leadSourceCode;
    data['lead_source_code_description'] = leadSourceCodeDescription;
    data['site_visit_source_code'] = siteVisitSourceCode;
    data['site_visit_source_description'] = siteVisitSourceDescription;
    data['site_visit_date_time'] = siteVisitDateTime;
    data['start_date_time'] = startDateTime;
    data['end_date_time'] = endDateTime;
    data['start_owner_emp_id'] = startOwnerEmpId;
    data['start_owner_emp_name'] = startOwnerEmpName;
    data['end_owner_emp_id'] = endOwnerEmpId;
    data['end_owner_emp_name'] = endOwnerEmpName;
    data['start_sitevisit'] = startSitevisit;
    data['end_sitevisit'] = endSitevisit;
    data['end_sv_note'] = endSvNote;
    data['is_confirm_by_employee'] = isConfirmByEmployee;
    data['employee_name'] = employeeName;
    data['is_confirm_by_customer'] = isConfirmByCustomer;
    data['referral_customer_iso_code'] = referralCustomerIsoCode;
    data['referral_customer_dial_code'] = referralCustomerDialCode;
    data['referral_customer_countryname'] = referralCustomerCountryname;
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
    data['referral_cp_name'] = referralCpName;
    data['referral_cp_rera_no'] = referralCpReraNo;
    data['referral_cp_executive'] = referralCpExecutive;
    data['referral_cp_executive_mobile'] = referralCpExecutiveMobile;
    data['created_by_emp_id'] = createdByEmpId;
    data['created_by_emp_name'] = createdByEmpName;
    data['sv_owner_id'] = svOwnerId;
    data['sv_owner_name'] = svOwnerName;
    data['claim_by_owner_id'] = claimByOwnerId;
    data['claim_by_owner_name'] = claimByOwnerName;
    data['updated_by_emp_id'] = updatedByEmpId;
    data['updated_by_emp_name'] = updatedByEmpName;
    data['is_available'] = isAvailable;
    data['is_sys'] = isSys;
    data['is_del'] = isDel;
    data['is_direct_from_sv'] = isDirectFromSv;
    if (sourcingManagerList != null) {
      data['sourcing_manager_list'] =
          sourcingManagerList!.map((v) => v.toJson()).toList();
    }
    if (closingManager != null) {
      data['closing_manager'] = closingManager!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['site_visit_feedback_by_emp'] = feedbackCode;
    return data;
  }
}

class SourcingManagerList {
  SourcingManagerList(
      {this.ownerPartyID,
      this.ownerPartyName,
      this.sId,
      this.createdAt,
      this.updatedAt});

  SourcingManagerList.fromJson(Map<String, dynamic> json) {
    ownerPartyID = json['OwnerPartyID'];
    ownerPartyName = json['OwnerPartyName'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  String? ownerPartyID;
  String? ownerPartyName;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OwnerPartyID'] = ownerPartyID;
    data['OwnerPartyName'] = ownerPartyName;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ClosingManagerList {
  ClosingManagerList(
      {this.ownerPartyID,
      this.ownerPartyName,
      this.sId,
      this.updatedAt,
      this.createdAt});

  ClosingManagerList.fromJson(Map<String, dynamic> json) {
    ownerPartyID = json['OwnerPartyID'];
    ownerPartyName = json['OwnerPartyName'];
    sId = json['_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  String? ownerPartyID;
  String? ownerPartyName;
  String? sId;
  String? updatedAt;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OwnerPartyID'] = ownerPartyID;
    data['OwnerPartyName'] = ownerPartyName;
    data['_id'] = sId;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
