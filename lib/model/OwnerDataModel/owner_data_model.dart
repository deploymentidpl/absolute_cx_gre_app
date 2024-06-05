class OwnerDataBaseModel {
  late bool success;
  late String message;
  late List<OwnerDataListModel> data;

  OwnerDataBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  OwnerDataBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <OwnerDataListModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(OwnerDataListModel.fromJson(v));
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

class OwnerDataListModel {
  late List<OwnerDataModel> ownerData;
  late List<int> count;

  OwnerDataListModel() {
    ownerData = [];
    count = [];
  }

  OwnerDataListModel.fromJson(Map<String, dynamic> json) {
    ownerData = <OwnerDataModel>[];
    if (json['ownerdata'] != null) {
      json['ownerdata'].forEach((v) {
        ownerData.add(OwnerDataModel.fromJson(v));
      });
    }
    count = json['count']?.cast<int>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ownerdata'] = ownerData.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class OwnerDataModel {
  late String id;
  late String name;

  OwnerDataModel() {
    id = "";
    name = "";
  }

  OwnerDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
