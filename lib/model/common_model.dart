class CommonModel {
  String? sId;
  bool? isSys;
  bool? isDel;
  String? code;
  String? countryCode;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isAvailable;

  CommonModel(
      {this.sId,
      this.isSys,
      this.isDel,
      this.code,
      this.countryCode,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isAvailable});

  CommonModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isSys = json['is_sys'].toString() == "1";
    isDel = json['is_del'].toString() == "1";
    code = json['code'];
    countryCode = json['country_code_number'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isAvailable = json['is_available'].toString() == "1";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_sys'] = isSys;
    data['is_del'] = isDel;
    data['code'] = code;
    data['country_code_number'] = countryCode;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['is_available'] = isAvailable;
    return data;
  }

  @override
  String toString() {
    return "$description";
  }
}

class CustomerRefUnitModel {
  String? sId;
  String? customerMobileNo;
  String? customerName;
  String? project;
  String? materialID;
  String? unitNo;

  CustomerRefUnitModel(
      {this.sId,
      this.customerMobileNo,
      this.customerName,
      this.project,
      this.materialID,
      this.unitNo});

  CustomerRefUnitModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerMobileNo = json['customerMobileNo'];
    customerName = json['customerName'];
    project = json['Project'];
    materialID = json['MaterialID'];
    unitNo = json['UnitNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['Project'] = project;
    data['MaterialID'] = materialID;
    data['UnitNo'] = unitNo;
    return data;
  }

  @override
  String toString() {
    return "$materialID";
  }
}

class EmployeeReferenceModel {
  String? employeeId;
  String? employeeName;
  String? employeeMobile;
  String? employeeEmail;

  EmployeeReferenceModel(
      {this.employeeId,
      this.employeeName,
      this.employeeMobile,
      this.employeeEmail});
}

class ChannelPartnerModel {
  String? id;
  String? text;
  String? city;
  String? rerano;

  ChannelPartnerModel({this.id, this.text, this.city, this.rerano});

  ChannelPartnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    city = json['City'];
    rerano = json['Rera_Number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['City'] = city;
    data['Rera_Number'] = rerano;
    return data;
  }
}

class BarrierTriggerModel {
  String? sId;
  String? type;
  String? description;
  bool? isAvailable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BarrierTriggerModel(
      {this.sId,
      this.type,
      this.description,
      this.isAvailable,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BarrierTriggerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['Type'];
    description = json['Description'];
    isAvailable = json['is_available'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['Type'] = type;
    data['Description'] = description;
    data['is_available'] = isAvailable;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class PopupModel {
  String? name;
  String? key;
  bool? isSelected;

  PopupModel({this.name, this.key, this.isSelected = false});
}

class DateFilterModel {
  String? filter;
  DateTime? fromDate;
  DateTime? toDate;
  bool? isSelected;

  DateFilterModel(
      {this.filter, this.fromDate, this.toDate, this.isSelected = false});
}
