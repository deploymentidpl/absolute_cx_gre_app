class CheckInSummaryBaseModel {
  late bool success;
  late String message;
  late List<CheckInSummaryModel> data;

  CheckInSummaryBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  CheckInSummaryBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <CheckInSummaryModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(CheckInSummaryModel.fromJson(v));
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

class CheckInSummaryModel {
  late String id;
  late String firstName;
  late String middleName;
  late String lastName;
  late String empFormattedName;
  late String mobileNo;
  late String mobileCountryCode;
  late String email;
  late String employeePassword;
  late String employeeId;
  late String genderCode;
  late String genderDescription;
  late String isAvailable;
  late String dateOfBirth;
  late String whatsappCountryCode;
  late String whatsappNo;
  late String roleCode;
  late String roleDescription;
  late String slug;
  late String type;
  late String checkInTime;
  late String? checkOutTime;
  late String pin;
  late String? verifyPinExpiry;
  late String absoluteAccess;
  late String greAppAccess;
  late String availableForChat;
  late String availableForCall;
  late String isScreenlogout;
  late String leadMasking;
  late String occupationCode;
  late String occupationDescription;
  late String cityCode;
  late String cityDescription;
  late String stateCode;
  late String stateDescription;
  late String countryCode;
  late String countryDescription;
  late String createdBy;
  late String updatedBy;
  late List<String> deviceInfo;
  late String createdAt;
  late String updatedAt;
  late int displayOrder;
  late int v;
  late String totalseconds;
  late List<CheckinCheckoutHistoryModel> checkinCheckoutHistory;

  CheckInSummaryModel() {
    id = "";
    firstName = "";
    middleName = "";
    lastName = "";
    empFormattedName = "";
    mobileNo = "";
    mobileCountryCode = "";
    email = "";
    employeePassword = "";
    employeeId = "";
    genderCode = "";
    genderDescription = "";
    isAvailable = "";
    dateOfBirth = "";
    whatsappCountryCode = "";
    whatsappNo = "";
    roleCode = "";
    roleDescription = "";
    slug = "";
    type = "";
    checkInTime = "";
    checkOutTime = null;
    pin = "";
    verifyPinExpiry = null;
    absoluteAccess = "";
    greAppAccess = "";
    availableForChat = "";
    availableForCall = "";
    isScreenlogout = "";
    leadMasking = "";
    occupationCode = "";
    occupationDescription = "";
    cityCode = "";
    cityDescription = "";
    stateCode = "";
    stateDescription = "";
    countryCode = "";
    countryDescription = "";
    createdBy = "";
    updatedBy = "";
    deviceInfo = [];
    createdAt = "";
    updatedAt = "";
    displayOrder = 0;
    v = 0;
    totalseconds = "";
    checkinCheckoutHistory = [];
  }

  CheckInSummaryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['first_name'] ?? "";
    middleName = json['middle_name'] ?? "";
    lastName = json['last_name'] ?? "";
    empFormattedName = json['emp_formatted_name'] ?? "";
    mobileNo = json['mobile_no'] ?? "";
    mobileCountryCode = json['mobile_country_code'] ?? "";
    email = json['email'] ?? "";
    employeePassword = json['employee_password'] ?? "";
    employeeId = json['employee_id'] ?? "";
    genderCode = json['gender_code'] ?? "";
    genderDescription = json['gender_description'] ?? "";
    isAvailable = json['is_available'] ?? "";
    dateOfBirth = json['date_of_birth'] ?? "";
    whatsappCountryCode = json['whatsapp_country_code'] ?? "";
    whatsappNo = json['whatsapp_no'] ?? "";
    roleCode = json['role_code'] ?? "";
    roleDescription = json['role_description'] ?? "";
    slug = json['slug'] ?? "";
    type = json['type'] ?? "";
    checkInTime = json['check_in_time'] ?? "";
    checkOutTime = json['check_out_time'];
    pin = json['pin'] ?? "";
    verifyPinExpiry = json['verify_pin_expiry'];
    absoluteAccess = json['absolute_access'] ?? "";
    greAppAccess = json['gre_app_access'] ?? "";
    availableForChat = json['available_for_chat'] ?? "";
    availableForCall = json['available_for_call'] ?? "";
    isScreenlogout = json['is_screenlogout'] ?? "";
    leadMasking = json['lead_masking'] ?? "";
    occupationCode = json['occupation_code'] ?? "";
    occupationDescription = json['occupation_description'] ?? "";
    cityCode = json['city_code'] ?? "";
    cityDescription = json['city_description'] ?? "";
    stateCode = json['state_code'] ?? "";
    stateDescription = json['state_description'] ?? "";
    countryCode = json['country_code'] ?? "";
    countryDescription = json['country_description'] ?? "";
    createdBy = json['created_by'] ?? "";
    updatedBy = json['updated_by'] ?? "";
    deviceInfo = List<String>.from(json['device_info'] ?? []);
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    displayOrder = json['display_order'] ?? 0;
    v = json['__v'] ?? 0;
    totalseconds = json['totalseconds'] ?? "0";
    checkinCheckoutHistory = <CheckinCheckoutHistoryModel>[];
    if (json['CheckinCheckoutHistory'] != null) {
      json['CheckinCheckoutHistory'].forEach((v) {
        checkinCheckoutHistory.add(CheckinCheckoutHistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['emp_formatted_name'] = empFormattedName;
    data['mobile_no'] = mobileNo;
    data['mobile_country_code'] = mobileCountryCode;
    data['email'] = email;
    data['employee_password'] = employeePassword;
    data['employee_id'] = employeeId;
    data['gender_code'] = genderCode;
    data['gender_description'] = genderDescription;
    data['is_available'] = isAvailable;
    data['date_of_birth'] = dateOfBirth;
    data['whatsapp_country_code'] = whatsappCountryCode;
    data['whatsapp_no'] = whatsappNo;
    data['role_code'] = roleCode;
    data['role_description'] = roleDescription;
    data['slug'] = slug;
    data['type'] = type;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    data['pin'] = pin;
    data['verify_pin_expiry'] = verifyPinExpiry;
    data['absolute_access'] = absoluteAccess;
    data['gre_app_access'] = greAppAccess;
    data['available_for_chat'] = availableForChat;
    data['available_for_call'] = availableForCall;
    data['is_screenlogout'] = isScreenlogout;
    data['lead_masking'] = leadMasking;
    data['occupation_code'] = occupationCode;
    data['occupation_description'] = occupationDescription;
    data['city_code'] = cityCode;
    data['city_description'] = cityDescription;
    data['state_code'] = stateCode;
    data['state_description'] = stateDescription;
    data['country_code'] = countryCode;
    data['country_description'] = countryDescription;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['device_info'] = deviceInfo;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['display_order'] = displayOrder;
    data['__v'] = v;
    data['totalseconds'] = totalseconds;
    data['CheckinCheckoutHistory'] =
        checkinCheckoutHistory.map((v) => v.toJson()).toList();
    return data;
  }
}

class CheckinCheckoutHistoryModel {
  late String id;
  late String status;
  late String employeeId;
  late String type;
  late String checkInTime;
  late String? checkOutTime;
  late int totalTime;
  late String punchLocation;
  late String deviceId;
  late int breakTime;
  late List<String> checkInLatLong;
  late String createdAt;
  late String updatedAt;
  late int v;
  late String result;

  CheckinCheckoutHistoryModel() {
    id = "";
    status = "";
    employeeId = "";
    type = "";
    checkInTime = "";
    checkOutTime = null;
    totalTime = 0;
    punchLocation = "";
    deviceId = "";
    breakTime = 0;
    checkInLatLong = [];
    createdAt = "";
    updatedAt = "";
    v = 0;
    result = "";
  }

  CheckinCheckoutHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    status = json['status'] ?? "";
    employeeId = json['employee_id'] ?? "";
    type = json['type'] ?? "";
    checkInTime = json['check_in_time'] ?? "";
    checkOutTime = json['check_out_time'];
    totalTime = json['total_time'] ?? 0;
    punchLocation = json['punch_location'] ?? "";
    deviceId = json['device_id'] ?? "";
    breakTime = json['break_time'] ?? 0;
    checkInLatLong = List<String>.from(json['check_in_latlong'] ?? []);
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    v = json['__v'] ?? 0;
    result = json['result'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['status'] = status;
    data['employee_id'] = employeeId;
    data['type'] = type;
    data['check_in_time'] = checkInTime;
    data['check_out_time'] = checkOutTime;
    data['total_time'] = totalTime;
    data['punch_location'] = punchLocation;
    data['device_id'] = deviceId;
    data['break_time'] = breakTime;
    data['check_in_latlong'] = checkInLatLong;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    data['result'] = result;
    return data;
  }
}
