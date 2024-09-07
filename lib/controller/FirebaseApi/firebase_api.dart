import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/preference_controller.dart';

@pragma('vm:entry-point')
Future<void> onMessageOpenedApp(RemoteMessage message) async {
  print("onMessageOpenedApp message.notification?.web?.image");
  print(message.notification?.web?.image);
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: Text((message.notification?.title) ?? ""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text((message.notification?.body) ?? ""),
            Image.network(message.notification?.web?.image ?? "")
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Close"))
        ],
      );
    },
  );
}

@pragma('vm:entry-point')
Future<void> onMessage(RemoteMessage message) async {
  print("onMessage message.notification?.web?.image");
  print(message.notification?.web?.image);
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: Text((message.notification?.title) ?? ""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text((message.notification?.body) ?? ""),
            Image.network(message.notification?.web?.image ?? "")
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Close"))
        ],
      );
    },
  );
}

@pragma('vm:entry-point')
Future<void> bgHandler(RemoteMessage message) async {
  print("message.notification?.web?.image");
  print(message.notification?.web?.image);
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: Text((message.notification?.title) ?? ""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text((message.notification?.body) ?? ""),
            Image.network(message.notification?.web?.image ?? "")
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Close"))
        ],
      );
    },
  );
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static String token = "";

  void fcmSubscribe(String token) {
    _firebaseMessaging.subscribeToTopic(token);
  }

  void fcmUnSubscribe(String token) {
    _firebaseMessaging.unsubscribeFromTopic(token);
  }

  Future<void> initNotification() async {
    devPrint("initNotification called");
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    var val1 = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    devPrint("Notification Permission ----: $val1");
    try {
      String token = await getToken() ?? "";
      devPrint("Token: $token");
      log("Token: $token");
      PreferenceController.setString("fcmToken", token);
    } catch (error, s) {
      devPrint("error---------");
      devPrint(error);
      devPrint(s);
    }

    ///Have created other functions to test where notification is coming from
    /// remove once tested
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onBackgroundMessage(bgHandler);
  }

  Future<String?> getToken({int maxTries = 3}) async {
    if (maxTries > 0) {
      try {
        return (await _firebaseMessaging.getToken(
            vapidKey:
                "BFJ4f_64N1QPQmGVofZorN_KHdDuHomTE5L0wJpLNA0h4aO_9JYRGxKQ7QKRiR5C4LqugP3BOlfnAGe1x8Qvq5U"));
      } catch (error) {
        devPrint(error);
        return await getToken(maxTries: maxTries - 1);
      }
    } else {
      return null;
    }
  }
}
