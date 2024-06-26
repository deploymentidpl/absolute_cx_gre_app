// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD2AmNONwTDGmBTLyx6wWa8wp1R1T5m5_A',
    appId: '1:268320364455:web:4779ceaab7ce5d471d0882',
    messagingSenderId: '268320364455',
    projectId: 'absolutecxgre',
    authDomain: 'absolutecxgre.firebaseapp.com',
    storageBucket: 'absolutecxgre.appspot.com',
    measurementId: 'G-CXDKR61EQE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5f0baUAxI-2-EpDgasEnNV7nySiPpYgE',
    appId: '1:268320364455:android:e764982fb48a76001d0882',
    messagingSenderId: '268320364455',
    projectId: 'absolutecxgre',
    storageBucket: 'absolutecxgre.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNEmDNEyuVEVj8LjtIWISq3YVJGkWYnvQ',
    appId: '1:268320364455:ios:16c88d8e996d68831d0882',
    messagingSenderId: '268320364455',
    projectId: 'absolutecxgre',
    storageBucket: 'absolutecxgre.appspot.com',
    iosBundleId: 'com.absolutecx.greapp',
  );

}