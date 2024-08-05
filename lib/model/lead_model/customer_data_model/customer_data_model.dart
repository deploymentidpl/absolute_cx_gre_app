class CustomerDataFetchModel {

  CustomerDataFetchModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    roleCode = json['role_code'];
    roleDescription = json['role_description'];
    titleCode = json['title_code'];
    titleDescription = json['title_description'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    genderTitleCode = json['gender_title_code'];
    genderTitleDescription = json['gender_title_description'];
    pincode = json['pincode'];
    languageCode = json['language_code'];
    languageDescription = json['language_description'];
    birthDate = json['birth_date'];
    professionCode = json['profession_code'];
    professionDescription = json['profession_description'];
    countryDescription = json['country_description'];
    stateCode = json['state_code'];
    stateDescription = json['state_description'];
    careOfName = json['care_of_name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    addressLine4 = json['address_line4'];
    customerType = json['customer_type'];
    existingAbsolutecxCustomer = json['existing_absolutecx_customer'];
    existingAbsolutecxCustomerDescription =
        json['existing_absolutecx_customer_description'];
    houseNumber = json['house_number'];
    additionalHouseNumber = json['additional_house_number'];
    street = json['street'];
    district = json['district'];
    cityCode = json['city_code'];
    cityDescription = json['city_description'];
    streetPostalCode = json['street_postal_code'];
    countyCode = json['county_code'];
    countyDescription = json['county_description'];
    phone = json['phone'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    mobileCountryCode = json['mobile_country_code'];
    mobileCountryDescription = json['mobile_country_description'];
    whatsappNo = json['whatsapp_no'];
    whatsappCountryCode = json['whatsapp_country_code'];
    whatsappCountryDescription = json['whatsapp_country_description'];
    isWhatsappAvailable = json['is_whatsapp_available'];
    companyLocation = json['company_location'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    officeTelephoneCountryCode = json['office_telephone_country_code'];
    officeTelephoneNumber = json['office_telephone_number'];
    officeTelephoneCountryDescription =
        json['office_telephone_country_description'];
    anniversaryDate = json['anniversary_date'];
    bloodGroup = json['blood_group'];
    bloodGroupDescription = json['blood_group_description'];
    createdByEmpId = json['created_by_emp_id'];
    createdByEmpName = json['created_by_emp_name'];
    updatedByEmpId = json['updated_by_emp_id'];
    updatedByEmpName = json['updated_by_emp_name'];
    ageGroupCode = json['age_group_code'];
    ageGroupDescription = json['age_group_description'];
    occupationCode = json['occupation_code'];
    occupationDescription = json['occupation_description'];
    functionCode = json['function_code'];
    functionDescription = json['function_description'];
    annualIncomeCode = json['annual_income_code'];
    annualIncomeDescription = json['annual_income_description'];
    currentResidence = json['current_residence'];
    currentDesignation = json['current_designation'];
    industryCode = json['industry_code'];
    industryDescription = json['industry_description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    displayOrder = json['display_order'];
    iV = json['__v'];
    unitNo = json['unit_no'];
    unitName = json['unit_name'];
  }

  CustomerDataFetchModel(
      {this.sId,
      this.customerId,
      this.roleCode,
      this.roleDescription,
      this.titleCode,
      this.titleDescription,
      this.firstName,
      this.lastName,
      this.genderTitleCode,
      this.genderTitleDescription,
      this.pincode,
      this.languageCode,
      this.languageDescription,
      this.birthDate,
      this.professionCode,
      this.professionDescription,
      this.countryDescription,
      this.stateCode,
      this.stateDescription,
      this.careOfName,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.addressLine4,
      this.customerType,
      this.existingAbsolutecxCustomer,
      this.existingAbsolutecxCustomerDescription,
      this.houseNumber,
      this.additionalHouseNumber,
      this.street,
      this.district,
      this.cityCode,
      this.cityDescription,
      this.streetPostalCode,
      this.countyCode,
      this.countyDescription,
      this.phone,
      this.email,
      this.mobileNo,
      this.mobileCountryCode,
      this.mobileCountryDescription,
      this.whatsappNo,
      this.whatsappCountryCode,
      this.whatsappCountryDescription,
      this.isWhatsappAvailable,
      this.companyLocation,
      this.companyName,
      this.companyAddress,
      this.officeTelephoneCountryCode,
      this.officeTelephoneNumber,
      this.officeTelephoneCountryDescription,
      this.anniversaryDate,
      this.bloodGroup,
      this.bloodGroupDescription,
      this.createdByEmpId,
      this.createdByEmpName,
      this.updatedByEmpId,
      this.updatedByEmpName,
      this.ageGroupCode,
      this.ageGroupDescription,
      this.occupationCode,
      this.occupationDescription,
      this.functionCode,
      this.functionDescription,
      this.annualIncomeCode,
      this.annualIncomeDescription,
      this.currentResidence,
      this.currentDesignation,
      this.industryCode,
      this.industryDescription,
      this.createdAt,
      this.updatedAt,
      this.displayOrder,
      this.iV,
      this.unitNo,
      this.unitName});
  String? sId;
  String? customerId;
  String? roleCode;
  String? roleDescription;
  String? titleCode;
  String? titleDescription;
  String? firstName;
  String? lastName;
  String? genderTitleCode;
  String? genderTitleDescription;
  String? pincode;
  String? languageCode;
  String? languageDescription;
  String? birthDate;
  String? professionCode;
  String? professionDescription;
  String? countryDescription;
  String? stateCode;
  String? stateDescription;
  String? careOfName;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? addressLine4;
  String? customerType;
  String? existingAbsolutecxCustomer;
  String? existingAbsolutecxCustomerDescription;
  String? houseNumber;
  String? additionalHouseNumber;
  String? street;
  String? district;
  String? cityCode;
  String? cityDescription;
  String? streetPostalCode;
  String? countyCode;
  String? countyDescription;
  String? phone;
  String? email;
  String? mobileNo;
  String? mobileCountryCode;
  String? mobileCountryDescription;
  String? whatsappNo;
  String? whatsappCountryCode;
  String? whatsappCountryDescription;
  String? isWhatsappAvailable;
  String? companyLocation;
  String? companyName;
  String? companyAddress;
  String? officeTelephoneCountryCode;
  String? officeTelephoneNumber;
  String? officeTelephoneCountryDescription;
  String? anniversaryDate;
  String? bloodGroup;
  String? bloodGroupDescription;
  String? createdByEmpId;
  String? createdByEmpName;
  String? updatedByEmpId;
  String? updatedByEmpName;
  String? ageGroupCode;
  String? ageGroupDescription;
  String? occupationCode;
  String? occupationDescription;
  String? functionCode;
  String? functionDescription;
  String? annualIncomeCode;
  String? annualIncomeDescription;
  String? currentResidence;
  String? currentDesignation;
  String? industryCode;
  String? industryDescription;
  String? createdAt;
  String? updatedAt;
  int? displayOrder;
  int? iV;
  String? unitNo;
  String? unitName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['customer_id'] = customerId;
    data['role_code'] = roleCode;
    data['role_description'] = roleDescription;
    data['title_code'] = titleCode;
    data['title_description'] = titleDescription;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender_title_code'] = genderTitleCode;
    data['gender_title_description'] = genderTitleDescription;
    data['pincode'] = pincode;
    data['language_code'] = languageCode;
    data['language_description'] = languageDescription;
    data['birth_date'] = birthDate;
    data['profession_code'] = professionCode;
    data['profession_description'] = professionDescription;
    data['country_description'] = countryDescription;
    data['state_code'] = stateCode;
    data['state_description'] = stateDescription;
    data['care_of_name'] = careOfName;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['address_line3'] = addressLine3;
    data['address_line4'] = addressLine4;
    data['customer_type'] = customerType;
    data['existing_absolutecx_customer'] = existingAbsolutecxCustomer;
    data['existing_absolutecx_customer_description'] =
        existingAbsolutecxCustomerDescription;
    data['house_number'] = houseNumber;
    data['additional_house_number'] = additionalHouseNumber;
    data['street'] = street;
    data['district'] = district;
    data['city_code'] = cityCode;
    data['city_description'] = cityDescription;
    data['street_postal_code'] = streetPostalCode;
    data['county_code'] = countyCode;
    data['county_description'] = countyDescription;
    data['phone'] = phone;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['mobile_country_code'] = mobileCountryCode;
    data['mobile_country_description'] = mobileCountryDescription;
    data['whatsapp_no'] = whatsappNo;
    data['whatsapp_country_code'] = whatsappCountryCode;
    data['whatsapp_country_description'] = whatsappCountryDescription;
    data['is_whatsapp_available'] = isWhatsappAvailable;
    data['company_location'] = companyLocation;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['office_telephone_country_code'] = officeTelephoneCountryCode;
    data['office_telephone_number'] = officeTelephoneNumber;
    data['office_telephone_country_description'] =
        officeTelephoneCountryDescription;
    data['anniversary_date'] = anniversaryDate;
    data['blood_group'] = bloodGroup;
    data['blood_group_description'] = bloodGroupDescription;
    data['created_by_emp_id'] = createdByEmpId;
    data['created_by_emp_name'] = createdByEmpName;
    data['updated_by_emp_id'] = updatedByEmpId;
    data['updated_by_emp_name'] = updatedByEmpName;
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
    data['industry_code'] = industryCode;
    data['industry_description'] = industryDescription;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['display_order'] = displayOrder;
    data['__v'] = iV;
    data['unit_no'] = unitNo;
    data['unit_name'] = unitName;
    return data;
  }
}
