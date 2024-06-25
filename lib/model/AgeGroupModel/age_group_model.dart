class AgeGroupBaseModel {
  late bool success;
  late String message;
  late List<AgeGroupModel> data;

  AgeGroupBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  AgeGroupBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <AgeGroupModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(AgeGroupModel.fromJson(v));
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

class AgeGroupModel {
  late String id;
  late String code;
  late String description;
  late String isAvailable;
  late int displayOrder;
  late String createdAt;
  late String updatedAt;
  late int v;

  AgeGroupModel() {
    id = "";
    code = "";
    description = "";
    isAvailable = "";
    displayOrder = 0;
    createdAt = "";
    updatedAt = "";
    v = 0;
  }

  AgeGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    code = json['code'] ?? "";
    description = json['description'] ?? "";
    isAvailable = json['is_available'] ?? "";
    displayOrder = json['display_order'] ?? 0;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    v = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['is_available'] = isAvailable;
    data['display_order'] = displayOrder;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}
