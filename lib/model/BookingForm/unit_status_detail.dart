import 'dart:developer';

class UnitTowerModel {
  String towerId = '';
  String towerName = '';
  List<FloorModel> floors = List.empty(growable: true);

  UnitTowerModel();

  UnitTowerModel.fromJson(Map<String, dynamic> jsonData) {
    try {
      towerId = jsonData['towerId'] ?? '';
      towerName = jsonData['towerName'] ?? '';
      floors = FloorModel.fromJsonList(jsonData['floors']);
    } catch (e) {
      log(jsonData['emp_id']);
    }
  }
}

class FloorModel {
  String floorId = '';
  List<UnitStatusDetail> units = List.empty(growable: true);

  FloorModel() ;

  FloorModel.fromJson(Map<String, dynamic> jsonData) {
    try {
      floorId = jsonData['floorId'] ?? '';
      units = UnitStatusDetail.fromJsonList(jsonData['units']);
    } catch (e) {
      log(jsonData['emp_id']);
    }
  }

  static List<FloorModel> fromJsonList(List<dynamic> jsonData) {
    List<FloorModel> list = List.empty(growable: true);
    try {
      list = jsonData.map((e) => FloorModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());}
    return list;
  }
}

class UnitStatusDetail {
  String unitId = '';
  String status = '';

  UnitStatusDetail();

  UnitStatusDetail.fromJson(Map<String, dynamic> jsonData) {
    try {
      unitId = jsonData['unitId'] ?? '';
      status = jsonData['status'] ?? '';
    } catch (e) {
      log(jsonData['emp_id']);
    }
  }

  static List<UnitStatusDetail> fromJsonList(List<dynamic> jsonData) {
    List<UnitStatusDetail> list = List.empty(growable: true);
    try {
      list = jsonData.map((e) => UnitStatusDetail.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
    }
    return list;
  }
}
