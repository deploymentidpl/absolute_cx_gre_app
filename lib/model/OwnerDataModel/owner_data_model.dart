// class SVWaitlistBaseModel {
//   late bool success;
//   late String message;
//   late List<SVWaitlistModel> data;
//
//   SVWaitlistBaseModel() {
//     success = false;
//     message = "";
//     data = [];
//   }
//
//   SVWaitlistBaseModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'] ?? false;
//     message = json['message'] ?? "";
//     data = <SVWaitlistModel>[];
//     if (json['data'] != null) {
//       json['data'].forEach((v) {
//         data.add(SVWaitlistModel.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     data['data'] = this.data.map((v) => v.toJson()).toList();
//     return data;
//   }
// }
//
// class SVWaitlistModel {
//   late List<SVOwnerDataModel> svownerdata;
//   late List<int> count;
//
//   SVWaitlistModel() {
//     svownerdata = [];
//     count = [];
//   }
//
//   SVWaitlistModel.fromJson(Map<String, dynamic> json) {
//     svownerdata = <SVOwnerDataModel>[];
//     if (json['svownerdata'] != null) {
//       json['svownerdata'].forEach((v) {
//         svownerdata.add(SVOwnerDataModel.fromJson(v));
//       });
//     }
//     count = List<int>.from(json['count'] ?? []);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['svownerdata'] = svownerdata.map((v) => v.toJson()).toList();
//     data['count'] = count;
//     return data;
//   }
// }
//
// class SVOwnerDataModel {
//   late String id;
//   late String name;
//
//   SVOwnerDataModel() {
//     id = "";
//     name = "";
//   }
//
//   SVOwnerDataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? "";
//     name = json['name'] ?? "";
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }
