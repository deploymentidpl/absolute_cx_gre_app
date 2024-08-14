class SVWaitListBaseModel {
  late bool success;
  late String message;
  late List<SVWaitListModel> data;

  SVWaitListBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  SVWaitListBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <SVWaitListModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(SVWaitListModel.fromJson(v));
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

class SVWaitListModel {
  late List<SVOwnerDataModel> svownerdata;
  late List<int> count;

  SVWaitListModel() {
    svownerdata = [];
    count = [];
  }

  SVWaitListModel.fromJson(Map<String, dynamic> json) {
    svownerdata = <SVOwnerDataModel>[];
    if (json['svownerdata'] != null) {
      json['svownerdata'].forEach((v) {
        svownerdata.add(SVOwnerDataModel.fromJson(v));
      });
    }
    count = List<int>.from(json['count'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['svownerdata'] = svownerdata.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class SVOwnerDataModel {
  late String id;
  late String name;

  SVOwnerDataModel() {
    id = "";
    name = "";
  }

  SVOwnerDataModel.fromJson(Map<String, dynamic> json) {
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
