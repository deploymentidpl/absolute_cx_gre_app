
class ChannelModel {

  ChannelModel(
      {this.sId,
        this.vendorId,
        this.firstName,
        this.lastName,
        this.middleName,
        this.mobileNo,
        this.mobileCountryCode,
        this.email,
        this.whatsappNo,
        this.whatsappCountryCode,
        this.countryCode,
        this.countryDescription,
        this.cityCode,
        this.cityDescription,
        this.stateCode,
        this.stateDescription,
        this.companyCode,
        this.companyDescription,
        this.isWhatsappAvailable,
        this.status,
        this.pincode,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.reraNumber,
        this.reraStartDate,
        this.reraEndDate,
        this.isSys,
        this.isDel,
        this.createdAt,
        this.updatedAt,
        this.displayOrder,
        this.iV});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendorId = json['vendor_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    mobileNo = json['mobile_no'];
    mobileCountryCode = json['mobile_country_code'];
    email = json['email'];
    whatsappNo = json['whatsapp_no'];
    whatsappCountryCode = json['whatsapp_country_code'];
    countryCode = json['country_code'];
    countryDescription = json['country_description'];
    cityCode = json['city_code'];
    cityDescription = json['city_description'];
    stateCode = json['state_code'];
    stateDescription = json['state_description'];
    companyCode = json['company_code'];
    companyDescription = json['company_description'];
    isWhatsappAvailable = json['is_whatsapp_available'];
    status = json['status'];
    pincode = json['pincode'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    reraNumber = json['rera_number'];
    reraStartDate = json['rera_start_date'];
    reraEndDate = json['rera_end_date'];
    isSys = json['is_sys'];
    isDel = json['is_del'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    displayOrder = json['display_order'];
    iV = json['__v'];
  }
  String? sId;
  String? vendorId;
  String? firstName;
  String? lastName;
  String? middleName;
  String? mobileNo;
  String? mobileCountryCode;
  String? email;
  String? whatsappNo;
  String? whatsappCountryCode;
  String? countryCode;
  String? countryDescription;
  String? cityCode;
  String? cityDescription;
  String? stateCode;
  String? stateDescription;
  String? companyCode;
  String? companyDescription;
  String? isWhatsappAvailable;
  String? status;
  String? pincode;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? reraNumber;
  String? reraStartDate;
  String? reraEndDate;
  String? isSys;
  String? isDel;
  String? createdAt;
  String? updatedAt;
  int? displayOrder;
  int? iV;

}
