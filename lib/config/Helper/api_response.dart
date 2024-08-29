import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;

import 'package:greapp/config/utils/preference_controller.dart';

import '../../routes/route_name.dart';
import '../shared_pref.dart';
import '../utils/constant.dart';

class ApiResponse {
  Map<String, dynamic> data;
  String baseUrl;
  String apiKeys;
  ApiHeaderType apiHeaderType;
  ApiMethod? apiMethod;
  bool? isFormData;
  Map<String, dynamic>? headers;

  ApiResponse(
      {required this.data,
      required this.baseUrl,
      this.apiKeys = apiKey,
      required this.apiHeaderType,
      this.apiMethod,
      this.headers,
      this.isFormData = false});

  Future<Map<String, dynamic>> _header() async {
    String platform = "2";
    Map<String, dynamic> header = {};
    if (apiHeaderType == ApiHeaderType.none) {
    } else if (apiHeaderType == ApiHeaderType.login) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'PHPSESSID=d6eearqkiu3c6j5qtl4qbc12nm; mastertype=0',
        'platform': platform
      };
    } else if (apiHeaderType == ApiHeaderType.content) {
      header = {
        'Authorization': PreferenceController.getString(
          SharedPref.loginToken,
        ),
      };
    }
    if (headers != null && headers!.isNotEmpty) {
      header.addAll(headers!);
    }
    return header;
  }

  Future<Map<String, dynamic>> _addDeviceData() async {
    Map<String, dynamic> device = {};
    device.addAll(data);

    return device;
  }

  Future<Map<String, dynamic>?> getResponse({bool printAPI = false}) async {
    Map<String, dynamic> headers = await _header();
    Map<String, dynamic> data = await _addDeviceData();
    Dio dio = Dio();
    Response response;
    try {
      if (apiMethod == ApiMethod.put) {
        response = await dio.put(baseUrl,
            options: Options(
              headers: headers,
              contentType: 'application/json',
              validateStatus: (status) {
                return status! <= 500;
              },
            ),
            data: isFormData! ? FormData.fromMap(data) : json.encode(data));
      } else {
        response = await dio.post(baseUrl,
            options: Options(
              headers: headers,
              contentType: 'application/json',
              validateStatus: (status) {
                return status! <= 500;
              },
            ),
            data: isFormData! ? FormData.fromMap(data) : json.encode(data));
      }
    } catch (error) {
      if (kDebugMode) {
        print("error----$error");
      }
      rethrow;
    }
    if (printAPI) {
      log("API--->$baseUrl");
      log("Data--->$data");
      log("Response--->$response");
    }

    try {
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 400) {
        return response.data;
      } else if (response.statusCode! == 403) {
        PreferenceController.clearLoginCredential();
        PreferenceController.setBool(SharedPref.isUserLogin, false);
        getx.Get.toNamed(RouteNames.kLogin);
        return response.data;
      } else if (response.statusCode! <= 500) {
        return response.data;
      } else {
        final error = response.data.errors[0] ?? "Error";
        if (kDebugMode) {
          print("Server Not Responding \n$error");
        }
        throw Exception(error);
      }
    } catch (e) {
      if (e is DioException) {
        if (DioExceptionType.receiveTimeout == e.type ||
            DioExceptionType.connectionTimeout == e.type) {
          commonMessage =
              "Oops! No Internet!\nServer is not reachable. Please verify your internet connection and try again";
        } else if (DioExceptionType.badResponse == e.type) {
          commonMessage = "Something Went Wrong";
        } else if (DioExceptionType.unknown == e.type) {
          if (e.message!.contains('SocketException')) {
            commonMessage = "Make sure your network connection is on";
          }
        } else {
          commonMessage = "Problem connecting to the server. Please try again.";
        }
      }
    } finally {}
    return null;
  }
}

enum ApiHeaderType {
  login,
  content,
  none,
}

enum ApiMethod { get, post, put, delete, none }
