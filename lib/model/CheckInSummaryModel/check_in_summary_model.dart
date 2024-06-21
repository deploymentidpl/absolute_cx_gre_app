class CheckInSummaryBaseModel {
  late int status;
  late String message;
  late List<CheckInSummaryModel> data;

  CheckInSummaryBaseModel() {
    status = 0;
    message = "";
    data = [];
  }

  CheckInSummaryBaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? "";
    data = <CheckInSummaryModel>[];
    if (json['checkInSummary'] != null) {
      json['checkInSummary'].forEach((v) {
        data.add(CheckInSummaryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['checkInSummary'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class CheckInSummaryModel {
  late String checkIn;
  late String checkOut;
  late String time;

  CheckInSummaryModel() {
    checkIn = "";
    checkOut = "";
    time = "";
  }

  CheckInSummaryModel.fromJson(Map<String, dynamic> json) {
    checkIn = json['checkIn'] ?? "";
    checkOut = json['checkOut'] ?? "";
    time = json['time'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkIn'] = checkIn;
    data['checkOut'] = checkOut;
    data['time'] = time;
    return data;
  }
}
