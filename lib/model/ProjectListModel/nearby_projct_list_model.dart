class NearbyProjectBaseModel {
  late bool success;
  late String message;
  late List<NearbyProjectModel> data;

  NearbyProjectBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  NearbyProjectBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <NearbyProjectModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(NearbyProjectModel.fromJson(v));
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

class NearbyProjectModel {
  late String id;
  late String projectCode;
  late String projectDescription;
  late String isAvailable;
  late String latitude;
  late String longitude;
  late String displayDistance;
  late String type;
  late String createdAt;
  late String updatedAt;
  late int displayOrder;
  late int v;

  NearbyProjectModel() {
    id = "";
    projectCode = "";
    projectDescription = "";
    isAvailable = "";
    latitude = "";
    longitude = "";
    displayDistance = "";
    type = "";
    createdAt = "";
    updatedAt = "";
    displayOrder = 0;
    v = 0;
  }

  NearbyProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    projectCode = json['project_code'] ?? "";
    projectDescription = json['project_description'] ?? "";
    isAvailable = json['is_available'] ?? "";
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
    displayDistance = json['display_distance'] ?? "";
    type = json['type'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    displayOrder = json['display_order'] ?? 0;
    v = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['project_code'] = projectCode;
    data['project_description'] = projectDescription;
    data['is_available'] = isAvailable;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['display_distance'] = displayDistance;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['display_order'] = displayOrder;
    data['__v'] = v;
    return data;
  }
}
