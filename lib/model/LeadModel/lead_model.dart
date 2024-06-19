class LeadBaseModel {
  late int status;
  late String message;
  late List<LeadModel> data;

  LeadBaseModel() {
    status = 0;
    message = "";
    data = [];
  }

  LeadBaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? "";
    data = <LeadModel>[];
    if (json['Data'] != null) {
      json['Data'].forEach((v) {
        data.add(LeadModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class LeadModel {
  late String name;
  late int age;
  late String location;
  late String created;
  late String updated;
  late int waitlistNumber;
  late String scheduleTime;
  late String exam;
  late String propertyType;
  late String priceRange;
  late String company;
  late String source;
  late String status;
  late bool isAssigned;

  LeadModel() {
    name = "";
    age = 0;
    location = "";
    created = "";
    updated = "";
    waitlistNumber = 0;
    scheduleTime = "";
    exam = "";
    propertyType = "";
    priceRange = "";
    company = "";
    source = "";
    status = "";
    isAssigned = false;
  }

  LeadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    age = json['age'] ?? 0;
    location = json['location'] ?? "";
    created = json['created'] ?? "";
    updated = json['updated'] ?? "";
    waitlistNumber = json['waitlist_number'] ?? 0;
    scheduleTime = json['schedule_time'] ?? "";
    exam = json['exam'] ?? "";
    propertyType = json['property_type'] ?? "";
    priceRange = json['price_range'] ?? "";
    company = json['company'] ?? "";
    source = json['source'] ?? "";
    status = json['status'] ?? "";
    isAssigned = json['isAssigned'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    data['location'] = location;
    data['created'] = created;
    data['updated'] = updated;
    data['waitlist_number'] = waitlistNumber;
    data['schedule_time'] = scheduleTime;
    data['exam'] = exam;
    data['property_type'] = propertyType;
    data['price_range'] = priceRange;
    data['company'] = company;
    data['source'] = source;
    data['status'] = status;
    data['isAssigned'] = isAssigned;
    return data;
  }
}
