
import 'package:get/get.dart';

class CommonModal {
  String? id;
  String? code;
  String? description;
  String? countryCodeNumber;
  String? stateName;
  String? stateCode;
  String? countryCode;
  String? createdAt;
  String? updatedAt;
  String? v;
  bool? isAvailable;
  String? displayOrder;

  CommonModal({
    this.id,
    this.code,
    this.countryCodeNumber,
    this.stateName,
    this.stateCode,
    this.countryCode,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isAvailable,
    this.displayOrder,
  });

  CommonModal.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    code = json['code'].toString();
    countryCodeNumber = json['country_code_number'] ?? "";
    stateName = json['state_name'] ?? "";
    countryCode = json['country_code'] ?? "";
    stateCode = json['state_code'] ?? "";
    description = json['description'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['updatedAt'].toString();
    v = json['__v'].toString();
    isAvailable = json['is_available'] ?? false;
    displayOrder = json['display_order'].toString();

  }


  @override
  String toString() {

    return "$description".capitalizeFirst.toString();
  }
}
