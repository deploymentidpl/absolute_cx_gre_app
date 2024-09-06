class SourceWiseDataBaseModel {
  late bool success;
  late String message;
  late List<SourceWiseDataModel> data;

  SourceWiseDataBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  SourceWiseDataBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <SourceWiseDataModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(SourceWiseDataModel.fromJson(v));
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

class SourceWiseDataModel {
  late String source;
  late int count;
  late double percentage;
  late String code;

  SourceWiseDataModel() {
    source = "";
    count = 0;
    percentage = 0.0;
    code = "";
  }

  SourceWiseDataModel.fromJson(Map<String, dynamic> json) {
    source = json['Source'] ?? "";
    count = json['Count'] ?? 0;
    percentage = double.parse((json['Percentage'] ?? 0.0).toString());
    code = json['Code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Source'] = source;
    data['Count'] = count;
    data['Percentage'] = percentage;
    data['Code'] = code;
    return data;
  }
}
