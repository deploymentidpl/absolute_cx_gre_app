class TitleBaseModel {
  late bool success;
  late String message;
  late List<TitleModel> data;

  TitleBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  TitleBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <TitleModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(TitleModel.fromJson(v));
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

class TitleModel {
  late String id;
  late String code;
  late String description;
  late String isAvailable;
  late int displayOrder;
  late String createdAt;
  late String updatedAt;
  late int version;

  TitleModel() {
    id = "";
    code = "";
    description = "";
    isAvailable = "1";
    displayOrder = 0;
    createdAt = "";
    updatedAt = "";
    version = 0;
  }

  TitleModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    code = json['code'] ?? "";
    description = json['description'] ?? "";
    isAvailable = json['is_available'] ?? "1";
    displayOrder = json['display_order'] ?? 0;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    version = json['__v'] ?? 0;
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
    data['__v'] = version;
    return data;
  }
}
