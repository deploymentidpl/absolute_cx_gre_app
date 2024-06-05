class IconTitleBaseModel {
  late int status;
  late String message;
  late List<IconTitleModel> data;

  IconTitleBaseModel() {
    status = 0;
    message = "";
    data = [];
  }

  IconTitleBaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? "";
    data = <IconTitleModel>[];
    if (json['Data'] != null) {
      json['Data'].forEach((v) {
        data.add(IconTitleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class IconTitleModel {
  late String icon;
  late String title;

  IconTitleModel() {
    icon = "";
    title = "";
  }

  IconTitleModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'] ?? "";
    title = json['title'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    return data;
  }
}
