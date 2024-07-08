import 'dart:developer';

import 'package:get/get.dart';

import '../../model/common_model.dart';
import '../utils/api_constant.dart';
import '../utils/constant.dart';
import 'api_response.dart';


Future<RxList<CommonModel>> retrieveCountry() async {
  arrCountry = RxList([]);
  var data = {'': ''};

  ApiResponse response = ApiResponse(
      data: data,
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