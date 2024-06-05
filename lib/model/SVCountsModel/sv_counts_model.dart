class SVCountsBaseModel {
  late bool success;
  late String message;
  late List<SVCountsModel> data;

  SVCountsBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  SVCountsBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <SVCountsModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(SVCountsModel.fromJson(v));
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

class SVCountsModel {
  late List<String> lable;
  late List<int> count;

  SVCountsModel() {
    lable = [];
    count = [];
  }

  SVCountsModel.fromJson(Map<String, dynamic> json) {
    lable = json['Lable'] != null ? List<String>.from(json['Lable']) : [];
    count = json['Count'] != null ? List<int>.from(json['Count']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Lable'] = lable;
    data['Count'] = count;
    return data;
  }
}
