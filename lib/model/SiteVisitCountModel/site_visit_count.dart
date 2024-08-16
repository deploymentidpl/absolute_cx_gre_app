class SiteVisitCountModel {
  int? svcount;

  SiteVisitCountModel({this.svcount});

  SiteVisitCountModel.fromJson(Map<String, dynamic> json) {
    svcount = json['svcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['svcount'] = svcount;
    return data;
  }
}
