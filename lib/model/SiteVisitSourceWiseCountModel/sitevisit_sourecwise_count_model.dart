class SiteVisitSourceWiseCountModel {
  String? source;
  int? count;
  double? percentage;
  String? code;

  SiteVisitSourceWiseCountModel(
      {this.source, this.count, this.percentage, this.code});

  SiteVisitSourceWiseCountModel.fromJson(Map<String, dynamic> json) {
    source = json['Source'];
    count = json['Count'];
    percentage = json['Percentage'];
    code = json['Code'];
  }
}
