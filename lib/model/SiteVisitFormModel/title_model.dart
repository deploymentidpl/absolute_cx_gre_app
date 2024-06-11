class TitleModel {
  String? sId;
  bool? isSys;
  bool? isDel;
  String? description;
  String? code;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isAvailable;
  bool? isCorporate;
  int? displayOrder;
  String? isVisible;

  TitleModel(
      {this.sId,
        this.isSys,
        this.isDel,
        this.description,
        this.code,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isAvailable,
        this.isCorporate,
        this.displayOrder,
        this.isVisible});

  TitleModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isSys = json['is_sys'];
    isDel = json['is_del'];
    description = json['description'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isAvailable = json['is_available'];
    isCorporate = json['is_corporate'];
    displayOrder = json['Display_Order'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['is_sys'] = this.isSys;
    data['is_del'] = this.isDel;
    data['description'] = this.description;
    data['code'] = this.code;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['is_available'] = this.isAvailable;
    data['is_corporate'] = this.isCorporate;
    data['Display_Order'] = this.displayOrder;
    data['is_visible'] = this.isVisible;
    return data;
  }
}