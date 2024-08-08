import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/preference_controller.dart';

@pragma('vm:entry-point')
Future<void> bgHandler(RemoteMessage message) async {
  devPrint("message.notification?.web?.image");
  devPrint(message.notification?.web?.image);
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
      alert: true, // Required to display a heads up notification
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
      String token = (await _firebaseMessaging.getToken(
              vapidKey:
                  "BFJ4f_64N1QPQmGVofZorN_KHdDuHomTE5L0wJpLNA0h4aO_9JYRGxKQ7QKRiR5C4LqugP3BOlfnAGe1x8Qvq5U")) ??
          "";
      devPrint("Token: $token");
      PreferenceController.setString("fcmToken", token);
    } catch (error, s) {
      devPrint("error---------");
      devPrint(error);
      devPrint(s);
    }

    //
    //   FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    //
    //       notificationTapBackground(NotificationResponse(notificationResponseType: NotificationResponseType.selectedNotification,payload: jsonEncode(message?.data)));
    //
    //   });
    //   // FirebaseMessaging.instance.getInitialMessage();
    //
    //   FirebaseMessaging.onBackgroundMessage(bgHandler);
    //
    //   FirebaseMessaging.onMessage.listen((message) {
    //     devPrint("recived noti ios");
    //     handlePushNotification(message);
    //     // NotificationHandler().showPlainNotification(message);
    //   }); /*   FirebaseMessaging.onMessage.listen((message) =>
    //       NotificationHandler().showPlainNotification(message)
    //     ,);*/
    FirebaseMessaging.onMessageOpenedApp.listen(bgHandler);
    FirebaseMessaging.onMessage.listen(bgHandler);
    FirebaseMessaging.onBackgroundMessage(bgHandler);
  }

  // Future<void> getFCMToken() async {
  //   if (kIsWeb) {
  //     token = (await _firebaseMessaging.getToken(
  //             vapidKey:
  //                 "BFJ4f_64N1QPQmGVofZorN_KHdDuHomTE5L0wJpLNA0h4aO_9JYRGxKQ7QKRiR5C4LqugP3BOlfnAGe1x8Qvq5U")) ??
  //         "";
  //   } else {
  //     token = (await _firebaseMessaging.getToken()) ?? "";
  //   }
  //   devPrint("Token: $token");
  //   PreferenceController.setString("fcmToken", token);
  // }

// //   // todo check and remove if not necessary
// Future<String> getAccessToken() async {
//     String scope = "https://www.googleapis.com/auth/firebase.messaging";
//     AutoRefreshingAuthClient client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson({
//       "type": "service_account",
//       "project_id": "ashar-cp-app",
//       "private_key_id": "006deae97a9c7040eb6f131cc73698be5f6f1229",
//       "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDOQi/UCvaHq4Qg\nDPS+3vQlEcWJkEwtGLcGeqtkq41ZXS/BWaa53xPM1ZirpLgIAIu5Hs3SONqj12uS\noq7hfWGEYBWb7FBpJ2gzFMNMDJ0tsOBgr/GqpjoVOdqZsRv3uJ+WHjjT/6BQRVJj\nw0uY6YRytA5Yj53RtILldBL9/eem4IxUTN8ULWSqzSTerCMtH0heu9S7AtR/ji1Q\nJsjkf9vZLT32HoQzq5Tra4609/U1mWmIeowJpd0PrJ4YRzLqcUwAnjBwzZcr9o4j\n5M5MX7yd3faltIyIQ1cW+mEA54R0xvw+26sGbqdBNOJq4KfwtsXMN7sJivRqWa6x\nPptRw4ChAgMBAAECggEAAIj3astkfFGblCG0eNJHO9lh88tmBy/rOZ8T1r0DLtop\nB41d+1lyybM8JCXXPF4T/rTvv73aA1bJtqWpYnhaymcdZzwjsUIi6Q8Cuq3Fspqk\n2ltaeyDXQbrWsFNfSTM3ZsJJT3N4TP0BC7Uz+v+QEmQZLW2h8StQs5urePExqqMl\nSEuV9PdD1qDIZ7OixvN++KoICkGFoocfsUIHoImO9g+Al12FbAIKUyOIEl3amkxk\nN3SpYURAbCHhJeNzzzL0BmWDai5Y/NYb88TYW7QmoDOUcb6uEwz/YNt/AogbZW9R\nKnDpUDfEml1Bd967wdXavTT2FQwUaCvuXg3Qq9mnqQKBgQD0I9XFRB0DFRQdqece\ntsoqk2UGt/y6j2InXYZuYpzW8GvfTVJkYlsmjM5kD2S+MYEiVyclYhIjYSmFT5pG\nwxhR2qENyaUnLJ32yksD13fFZ0VTiw5eJ/fsZYOuvDlITam2RnMuCin9S4OGxr1X\nlZSuuofcJLaKga6LqQF+vhGIlwKBgQDYR0CCZM/sSX4/szO7S8GoGCKLUf06/hab\n9g50wlw+tNt+e3OY/0zrFoxI6vUkt02226x+21TyU7ReZ2UYWWYxVt9NRyOqcyc3\nKDY2Db1OBhkrpoJP6TizMacVnVoDnoLE1CaZZxA6U0Uvx/m15kJavc8PEcMqSIky\nHQvUzG1vhwKBgQDI64DvcsnpknxWmVAi383rUhhPejWcl4nw2bBbwf5PiddNE8Zd\n5PAc/r6QbHa9a+JZj54gzuAci8bu9n8CA2dNXf8zaKLpZXeu9fbcd4QTSpUsVwGB\nDaWkwDqqIC+ISJoF7161IhpCYdYhogeLQAf38H0E+JXd0TIDsBgR5XxqiwKBgEXL\nMJEjsUmCKgCqds5BUzxIlZU6HysTZf5seBvLwPLncFGvyw0bjhnrS9gYIoX3tVeG\nKnNBmncc9f7lBOXHq8fOTf9lLqhJwuT00BG/e1CbfTHt6O2ayJZjNpUuEydJ1s9n\n2xD0BnOb/Z6+vOGrbcxUpmYpiD6z67pFT1Ubp1EvAoGBAME4EeBhVHBJ1oHYjuHp\nmii4ZPdUX4GF02ahjIzjWVAHqdKhBtzVuP1r/Q+l/pVbf16lAgWlZQeQbt7nQeBe\nRVeCK5h0mw/2fUgBbIwNsX4mSBnqofvzn9b0BmZOgLt8sspwHEk6bdvX/eu0TGjV\nxO6q8e5YQPrdC/RvlUGsEpVP\n-----END PRIVATE KEY-----\n",
//       "client_email": "firebase-adminsdk-a2rib@ashar-cp-app.iam.gserviceaccount.com",
//       "client_id": "109392652263044725474",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-a2rib%40ashar-cp-app.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     }), [scope]);
//     return client.credentials.accessToken.data;
// }

// Future<String> getAccessToken() async {
//   String scope = "https://www.googleapis.com/auth/firebase.messaging";
//   AutoRefreshingAuthClient client = await clientViaServiceAccount(
//       ServiceAccountCredentials.fromJson(---your Json---),
//       [scope]);
//   return client.credentials.accessToken.data;
// }
}
