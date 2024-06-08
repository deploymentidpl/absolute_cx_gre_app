class SourceWiseSVCountBaseModel {
  late bool success;
  late String message;
  late List<SourceWiseSVCountModel> data;

  SourceWiseSVCountBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  SourceWiseSVCountBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <SourceWiseSVCountModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(SourceWiseSVCountModel.fromJson(v));
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

class SourceWiseSVCountModel {
  late String source;
  late int count;
  late int percentage;
  late String code;

  SourceWiseSVCountModel() {
    source = "";
    count = 0;
    percentage = 0;
    code = "";
  }

  SourceWiseSVCountModel.fromJson(Map<String, dynamic> json) {
    source = json['Source'] ?? "";
    count = json['Count'] ?? 0;
    percentage = json['Percentage'] ?? 0;
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
