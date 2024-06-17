import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBsb3llZUlEIjoiVTJGc2RHVmtYMTlVWlZEYWZnUW1JczVhelBxNzY3NGpmWVNML1VmeHQ4MD0iLCJPYmplY3RJRCI6IlUyRnNkR1ZrWDErWWtHVTE4RmRpazJBbGFLUFRnS051WittdlNTUmM5UUU1dlRpZitZZHZ4UkVWdWFUNjFCS0ciLCJPVFAiOiJVMkZzZEdWa1gxOTNKSzZJRk54d2RMU1EwWWRaZWRERlJHaUkyTFREeHVRPSIsImlzX2RlZmF1bHRvdHBfbG9naW4iOiJVMkZzZEdWa1gxK3U3eEN3ZDN3YVVNWXBSb0lQY29rN0FDTlhCSDNDRzZ3PSIsImRlZmF1bHRvdHAiOiJVMkZzZEdWa1gxLzlTeHoyU1NNZXFaaWR2UHB5L2hUL2ExZFZjYU8ybXlzPSIsInVzZXJpbnB1dG90cCI6IlUyRnNkR1ZrWDE4MEF2WDRtRDhCcmYvY0tVclJqemg4d3VLdDZFb1F2TDQ9IiwiaWF0IjoxNzE4NjIxMjczLCJleHAiOjE3MjEyMTMyNzN9.71LtdtE6aaG4J8GLTTM_ImzL4Ed4gxwBDespSHwwbZE',
        //'Authorization': 'Bearer ${sp.getString(SESSION_AUTHORIZATIONTOKEN)!}',
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

  Future<Map<String, dynamic>?> getResponse() async {
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

    try {
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 400) {
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
