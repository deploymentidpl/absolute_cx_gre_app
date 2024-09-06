class ProfileModel {
  String? sId;
  String? type;
  String? employeeHeadID;
  bool? autoDialer;
  String? autoDialerStatus;
  bool? availableForCall;
  String? teamName;
  String? mobileNo;
  String? mobileCountryCode;
  String? objectID;
  String? eTag;
  String? employeeID;
  String? employeeUUID;
  String? userID;
  String? technicalUserID;
  String? identityUUID;
  String? businessPartnerID;
  String? businessPartnerFormattedName;
  String? departmentName;
  String? companyName;
  String? managerName;
  String? emailURI;
  String? decimalFormatCode;
  String? decimalFormatCodeText;
  String? dateFormatCode;
  String? dateFormatCodeText;
  String? timeFormatCode;
  String? timeFormatCodeText;
  String? timeZoneCode;
  String? timeZoneCodeText;
  String? preossTimeFormatCodeText;
  String? logonLanguageCode;
  String? logonLanguageCodeText;
  String? userValidityStartDate;
  String? userValidityEndDate;
  bool? userLockedIndicator;
  bool? userCountedIndicator;
  String? passwordPolicyCode;
  String? passwordPolicyCodeText;
  bool? passwordInactiveIndicator;
  bool? passwordLockedIndicator;
  String? userAccountTypeCode;
  String? userAccountTypeCodeText;
  String? createdOn;
  String? userCreatedBy;
  String? entityLastChangedOn;
  String? userChangedBy;
  String? userChangedOn;
  String? normalisedMobilePhoneNumber;
  String? mobilePhoneNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? genderCode;
  String? genderCodeText;
  String? uUID;
  String? userChangedOnISODateTime;
  String? entityLastChangedOnISODateTime;
  String? createdOnISODateTime;
  String? userValidityEndDateISODateTime;
  String? eTagISODateTime;
  String? userValidityStartDateISODateTime;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? checkInTime;
  String? checkOutTime;
  bool? autoFollowup;
  String? role;
  bool? leadMasking;
  bool? preossAccess;
  String? pIN;
  String? landlineNumber;
  bool? agentOccupyStatus;
  String? callProviders;
  String? outboundCallNumber;
  bool? availableForChat;
  int? autoDialerWaitingTime;
  int? inboundCallWaitingTime;

  ProfileModel(
      {this.sId,
      this.type,
      this.employeeHeadID,
      this.autoDialer,
      this.autoDialerStatus,
      this.availableForCall,
      this.teamName,
      this.mobileNo,
      this.mobileCountryCode,
      this.objectID,
      this.eTag,
      this.employeeID,
      this.employeeUUID,
      this.userID,
      this.technicalUserID,
      this.identityUUID,
      this.businessPartnerID,
      this.businessPartnerFormattedName,
      this.departmentName,
      this.companyName,
      this.managerName,
      this.emailURI,
      this.decimalFormatCode,
      this.decimalFormatCodeText,
      this.dateFormatCode,
      this.dateFormatCodeText,
      this.timeFormatCode,
      this.timeFormatCodeText,
      this.timeZoneCode,
      this.timeZoneCodeText,
      this.preossTimeFormatCodeText,
      this.logonLanguageCode,
      this.logonLanguageCodeText,
      this.userValidityStartDate,
      this.userValidityEndDate,
      this.userLockedIndicator,
      this.userCountedIndicator,
      this.passwordPolicyCode,
      this.passwordPolicyCodeText,
      this.passwordInactiveIndicator,
      this.passwordLockedIndicator,
      this.userAccountTypeCode,
      this.userAccountTypeCodeText,
      this.createdOn,
      this.userCreatedBy,
      this.entityLastChangedOn,
      this.userChangedBy,
      this.userChangedOn,
      this.normalisedMobilePhoneNumber,
      this.mobilePhoneNumber,
      this.firstName,
      this.middleName,
      this.lastName,
      this.genderCode,
      this.genderCodeText,
      this.uUID,
      this.userChangedOnISODateTime,
      this.entityLastChangedOnISODateTime,
      this.createdOnISODateTime,
      this.userValidityEndDateISODateTime,
      this.eTagISODateTime,
      this.userValidityStartDateISODateTime,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.checkInTime,
      this.checkOutTime,
      this.autoFollowup,
      this.role,
      this.leadMasking,
      this.preossAccess,
      this.pIN,
      this.landlineNumber,
      this.agentOccupyStatus,
      this.callProviders,
      this.outboundCallNumber,
      this.availableForChat,
      this.autoDialerWaitingTime,
      this.inboundCallWaitingTime});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['Type'];
    employeeHeadID = json['Employee_Head_ID'];
    autoDialer = json['AutoDialer'];
    autoDialerStatus = json['AutoDialerStatus'];
    availableForCall = json['Available_For_Call'];
    teamName = json['TeamName'];
    mobileNo = json['Mobile_No'];
    mobileCountryCode = json['Mobile_CountryCode'];
    objectID = json['ObjectID'];
    eTag = json['ETag'];
    employeeID = json['EmployeeID'];
    employeeUUID = json['EmployeeUUID'];
    userID = json['UserID'];
    technicalUserID = json['TechnicalUserID'];
    identityUUID = json['IdentityUUID'];
    businessPartnerID = json['BusinessPartnerID'];
    businessPartnerFormattedName = json['BusinessPartnerFormattedName'];
    departmentName = json['DepartmentName'];
    companyName = json['CompanyName'];
    managerName = json['ManagerName'];
    emailURI = json['EmailURI'];
    decimalFormatCode = json['DecimalFormatCode'];
    decimalFormatCodeText = json['DecimalFormatCodeText'];
    dateFormatCode = json['DateFormatCode'];
    dateFormatCodeText = json['DateFormatCodeText'];
    timeFormatCode = json['TimeFormatCode'];
    timeFormatCodeText = json['TimeFormatCodeText'];
    timeZoneCode = json['TimeZoneCode'];
    timeZoneCodeText = json['TimeZoneCodeText'];
    preossTimeFormatCodeText = json['PreossTimeFormatCodeText'];
    logonLanguageCode = json['LogonLanguageCode'];
    logonLanguageCodeText = json['LogonLanguageCodeText'];
    userValidityStartDate = json['UserValidityStartDate'];
    userValidityEndDate = json['UserValidityEndDate'];
    userLockedIndicator = json['UserLockedIndicator'];
    userCountedIndicator = json['UserCountedIndicator'];
    passwordPolicyCode = json['PasswordPolicyCode'];
    passwordPolicyCodeText = json['PasswordPolicyCodeText'];
    passwordInactiveIndicator = json['PasswordInactiveIndicator'];
    passwordLockedIndicator = json['PasswordLockedIndicator'];
    userAccountTypeCode = json['UserAccountTypeCode'];
    userAccountTypeCodeText = json['UserAccountTypeCodeText'];
    createdOn = json['CreatedOn'];
    userCreatedBy = json['UserCreatedBy'];
    entityLastChangedOn = json['EntityLastChangedOn'];
    userChangedBy = json['UserChangedBy'];
    userChangedOn = json['UserChangedOn'];
    normalisedMobilePhoneNumber = json['NormalisedMobilePhoneNumber'];
    mobilePhoneNumber = json['MobilePhoneNumber'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    genderCode = json['GenderCode'];
    genderCodeText = json['GenderCodeText'];
    uUID = json['UUID'];
    userChangedOnISODateTime = json['UserChangedOn_ISODateTime'];
    entityLastChangedOnISODateTime = json['EntityLastChangedOn_ISODateTime'];
    createdOnISODateTime = json['CreatedOn_ISODateTime'];
    userValidityEndDateISODateTime = json['UserValidityEndDate_ISODateTime'];
    eTagISODateTime = json['ETag_ISODateTime'];
    userValidityStartDateISODateTime =
        json['UserValidityStartDate_ISODateTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    checkInTime = json['CheckInTime'];
    checkOutTime = json['CheckOutTime'];
    autoFollowup = json['AutoFollowup'];
    role = json['Role'];
    leadMasking = json['LeadMasking'];
    preossAccess = json['Preoss_Access'];
    pIN = json['PIN'];
    landlineNumber = json['LandlineNumber'];
    agentOccupyStatus = json['Agent_Occupy_Status'];
    callProviders = json['CallProviders'];
    outboundCallNumber = json['OutboundCallNumber'];

    availableForChat = json['Available_For_Chat'];
    autoDialerWaitingTime = json['AutoDialerWaitingTime'];
    inboundCallWaitingTime = json['InboundCallWaitingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OwnerPartyID'] = businessPartnerID;
    data['OwnerPartyName'] = businessPartnerFormattedName;
    return data;
  }

  @override
  String toString() {
    return "$businessPartnerFormattedName";
  }
}
