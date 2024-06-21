import 'package:get/get.dart';

import '../../config/utils/app_constant.dart';
import '../../model/BookingForm/unit_status_detail.dart';

class BlockUnitSelectionController extends GetxController {
  Rx<String> selectedFilter = ''.obs;
  Rx<UnitTowerModel> filterList = UnitTowerModel().obs;
  UnitTowerModel tower = UnitTowerModel();

  BlockUnitSelectionController() {
    getAllTower();
  }

  Future<void> getAllTower() async {
    for (int i = 0; i <= 12; i++) {
      FloorModel floor = FloorModel();
      floor.floorId = 'Z${41 - (i)}';
      for (int j = 0; j <= 12; j++) {
        UnitStatusDetail unit = UnitStatusDetail();
        unit.unitId = '${40000 + j}';
        unit.status = AppConstant.unitStatus[0];
        floor.units.add(unit);
      }

      floor.units[i].status = AppConstant.unitStatus[i];
      tower.floors.add(floor);
    }
    addAll();
  }

  void addAll({bool filter = false}) {
    filterList.value.floors.clear();
    for (int i = 0; i < tower.floors.length; i++) {
      FloorModel floor = FloorModel();
      floor.floorId = tower.floors[i].floorId;
      for (int j = 0; j < tower.floors[i].units.length; j++) {
        UnitStatusDetail unit = UnitStatusDetail();
        unit.unitId = tower.floors[i].units[j].unitId;
        unit.status = tower.floors[i].units[j].status;
        floor.units.add(unit);
      }
      floor.units[i].status = AppConstant.unitStatus[i];
      filterList.value.floors.add(floor);
    }
    filterList.refresh();
  }

  void applyFilter({required String type}) {
    if (selectedFilter.value == type) {
      selectedFilter.value = '';
      addAll(filter: true);
    } else {
      selectedFilter.value = type;
      filterList.value.floors.clear();
      for (int i = 0; i < tower.floors.length; i++) {
        final List<UnitStatusDetail> temp =
            tower.floors[i].units.where((e) => e.status == type).toList();

        if (temp.isNotEmpty) {
          FloorModel temp1 = FloorModel();
          temp1.floorId = tower.floors[i].floorId;
          temp1.units = temp;
          if (temp.isNotEmpty) {
            filterList.value.floors.add(temp1);
          }
        }
      }
    }
    filterList.refresh();
  }
}
