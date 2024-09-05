import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../config/Helper/api_response.dart';
import '../../config/Helper/device_data.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/api_constant.dart';
import '../../config/utils/constant.dart';
import '../../config/utils/preference_controller.dart';
import '../../model/common_model.dart';

class CommonController extends GetxController {
  Future<Position> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<RxList<CommonModel>> retrieveCountry() async {
    arrCountry = RxList([]);

    ApiResponse response = ApiResponse(
        data:  {},
        baseUrl: Api.apiCountryList,
        apiHeaderType: ApiHeaderType.content);
    Map<String, dynamic>? responseData = await response.getResponse();

    if (responseData!['success'] == true) {
      List result = responseData['data'];

      arrCountry.value = List.from(result.map((e) => CommonModel.fromJson(e)));
      arrCountry.refresh();
    }

    return arrCountry;
  }

  Future<bool> logout() async {
    try {
      Map<String, dynamic> deviceInfo = await DeviceData().getDeviceData();

      Map<String, dynamic> data = {
        "employee_id": PreferenceController.getString(SharedPref.employeeID),
        "device_info": deviceInfo
      };

      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.apiLogout,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData = await response.getResponse() ?? {};

      log(responseData.toString());

      if (responseData['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }
}
