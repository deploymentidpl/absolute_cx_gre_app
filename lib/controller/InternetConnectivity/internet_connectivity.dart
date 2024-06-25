import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';

import '../../config/dev/dev_helper.dart';
import '../../routes/route_name.dart';
import '../../style/theme_color.dart';

class InternetConnectivity {
  final _connectivity = Connectivity();
  RxBool showHideDlg = false.obs;

  Future<void> initConnectivity() async {
    devPrint("call check internet------");
    late ConnectivityResult result;
    try {
      result = (await _connectivity.checkConnectivity()).first;
    } on Exception catch (e) {
      devPrint(e.toString());
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      if (!showHideDlg.value) {
        if (kIsWeb) {
          devPrint("call this---");
          Get.toNamed(RouteNames.kNoInterNet);
        } else {
          showAlertDialog();
        }
      }
    } else {
      if (showHideDlg.value) {
        if (Platform.isAndroid) {
          onRefresh();
          Get.back();
          showHideDlg.value = false;
        } else {}
      }
    }
  }

  void showAlertDialog() {
    showHideDlg.value = true;
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: SimpleDialog(
            backgroundColor: ColorTheme.cTransparent,
            children: [
              Container(
                width: kIsWeb ? Get.width / 2 : Get.width,
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorTheme.cAppTheme,
                  ),
                  shape: BoxShape.rectangle,
                  color: ColorTheme.cWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      child: Image.asset(AssetsString.aNoInternet,
                          color: ColorTheme.cAppTheme, height: 90, width: 80),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "No Internet Connection",
                      style: TextStyle(
                          color: ColorTheme.cAppTheme,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onRefresh() async {
    initConnectivity();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {});
    });
  }
}
