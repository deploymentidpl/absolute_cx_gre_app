import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:greapp/controller/FirebaseApi/firebase_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'function.dart';

class DeviceData {
  String updateAppMsg = "";

  Future<Map<String, dynamic>> getDeviceData() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    String os = "";
    String deviceModelName = "";
    String browserName = "";
    String macAddress = "";
    String deviceID = "";
    String osVersion = "";
    String appVersion = "";
    final ipv4 = await Ipify.ipv4();

    try {
      deviceID = FirebaseApi.token;
      log('deviceId ------ ${jsonEncode(deviceID)}');

      PackageInfo info = await PackageInfo.fromPlatform();
      appVersion = info.version;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (kIsWeb) {
        WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        os = "web";
        deviceModelName = webInfo.platform ?? "";
        browserName = webInfo.browserName.name;
        osVersion = webInfo.appVersion.toString();
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        os = "ios";
        osVersion = iosInfo.systemVersion;
        deviceModelName = iosInfo.model;
        macAddress = iosInfo.identifierForVendor ?? "";
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        os = "android";
        osVersion = androidInfo.version.release;
        deviceModelName = androidInfo.model;
        macAddress = androidInfo.id;
      }
    } catch (e) {
      devPrint(e);
    }
    deviceData['app_version'] = appVersion;
    deviceData['device_model_name'] = deviceModelName;
    deviceData['mac_address'] = macAddress;
    deviceData['device_id'] = deviceID;
    deviceData['platform'] = os;
    deviceData['os_version'] = osVersion;
    deviceData['browser_name'] = browserName;
    deviceData['ip_address'] = ipv4;

    return deviceData;
  }
}
