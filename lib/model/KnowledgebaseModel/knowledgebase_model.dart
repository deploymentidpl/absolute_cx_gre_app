class KnowledgebaseBaseModel {
  late List<KnowledgebaseModel> data;

  KnowledgebaseBaseModel() {
    data = [];
  }

  KnowledgebaseBaseModel.fromJson(Map<String, dynamic> json) {
    data = <KnowledgebaseModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(KnowledgebaseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class KnowledgebaseModel {
  late String url;
  late String title;
  late String description;

  KnowledgebaseModel() {
    url = "";
    title = "";
    description = "";
  }

  KnowledgebaseModel.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
