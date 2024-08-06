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
  late String sourceCode;
  late String sourceName;
  late int count;

  SourceWiseSVCountModel() {
    sourceCode = "";
    sourceName = "";
    count = 0;
  }

  SourceWiseSVCountModel.fromJson(Map<String, dynamic> json) {
    sourceCode = json['SourceCode'] ?? "";
    sourceName = json['SourceName'] ?? "";
    count = json['Count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SourceCode'] = sourceCode;
    data['SourceName'] = sourceName;
    data['Count'] = count;
    return data;
  }
}