import 'dart:developer';

import 'package:get/get.dart';

import '../../model/common_model.dart';
import '../utils/api_constant.dart';
import '../utils/constant.dart';
import 'api_response.dart';
import 'function.dart';

Future retrieveSVCount({bool? isOwnedCount}) async {
  int statusCount = 0;
  /*SharedPreferences sp = await SharedPreferences.getInstance();
  Map<String, dynamic> sessionData =
  json.decode(sp.getString(SESSION_EMPLOYEEDETAILS) ?? "");
  BUSINESS_PARTNER_ID = sessionData["BusinessPartnerID"];
  LEAD_MASKING = sessionData["LeadMasking"];*/

  var data = {
    "date": getTodayDate(),
    "SiteVisitLocationCode": kLocationCode,
    if (isOwnedCount == true) "OwnerPartyID": kOwnerPartyID,
  };
  log("SV COUNT DATA=====================$isOwnedCount=====$data");
  ApiResponse response = ApiResponse(
    data: data,
    baseUrl: Api.apiSvCount,
    apiHeaderType: ApiHeaderType.content,
  );

  Map<String, dynamic>? responseData = await response.getResponse();
  log("SV COUNT API RESPONSE ========$isOwnedCount===$responseData");
  if (responseData!['success'] == true) {
    try {
      statusCount = responseData['data'][0]['count'];
      if (isOwnedCount == true) {
        svOwnedCount.value = statusCount;
      } else {
        svWaitCount.value = statusCount;
      }
    } catch (e) {
      log("error================$e");
    }
  } else {
    log(responseData['message']);
  }
}

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