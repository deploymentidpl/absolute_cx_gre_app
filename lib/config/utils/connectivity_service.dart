import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../style/assets_string.dart';
import '../../style/theme_color.dart';

class ConnectivityService extends GetxService {
  static RxBool hasInternet = RxBool(false);

  // Callbacks for different API calls
  static Map<String, Function> apiCallbacks = <String, Function>{};

  // Keep track of the currently active screen
  static RxString currentScreenId = "".obs;

  // Track whether the no-internet dialog is currently showing
  static RxBool isDialogShowing = false.obs;

  Future<void> initializeConnectivity() async {
    checkInitialConnection();

    Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result);
      // Check for internet connection and call the API callback for the current screen
      if (hasInternet.value) {
        String tempCurrentScreenId = currentScreenId.value;
        Function? callback = apiCallbacks[tempCurrentScreenId];
        if (callback != null) {
          callback();
        }
        // Dismiss the dialog when internet is back
        if (isDialogShowing.value) {
          Get.back();
          isDialogShowing.value = false;
        }
      } else {
        _showNoInternetDialog();
      }
    });
  }

  Future<void> checkInitialConnection() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      _showNoInternetDialog();
    }
  }

  static Future<bool> getConnectionState() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    hasInternet.value = !result.contains(ConnectivityResult.none);
  }

  // Register API callbacks for different screens
  void registerApiCallback(String screenId, Function apiCallback) {
    apiCallbacks[screenId] = apiCallback;
  }

  // Set the currently active screen
  void setCurrentScreenId(String screenId) {
    currentScreenId.value = screenId;
  }

  void _showNoInternetDialog() {
    if (!isDialogShowing.value) {
      showDialog(
        context: Get.context!,
        builder: (context) {
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
      isDialogShowing.value = true;
    }
  }
}
