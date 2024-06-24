import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceController {
  static SharedPreferences? prefs;

  static Future initPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void clearLoginCredential() {
    if (prefs != null) {
      try {
        prefs!.clear();
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  static bool contains(String key) {
    return prefs?.containsKey(key) ?? false;
  }

  static void setInt(String key, int value) async {
    await prefs?.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return prefs?.getInt(key) ?? defaultValue;
  }

  static void setString(String key, String value) async {
    await prefs?.setString(key, value);
  }

  static String getString(String key, {defaultValue = ''}) {
    return prefs?.getString(key) ?? defaultValue;
  }

  static void setStringList(String key, List<String> value) async {
    await prefs?.setStringList(key, value);
  }

  static List<String> getStringList(String key,  ) {
    return prefs?.getStringList(key) ?? [];
  }

  static void setBool(String key, bool value) async {
    await prefs?.setBool(key, value);
  }

  static bool getBool(String key, {defaultValue = false}) {
    return prefs?.getBool(key) ?? defaultValue;
  }

  static void setDouble(String key, double value) async {
    await prefs?.setDouble(key, value);
  }

  static double getDouble(String key) {
    return prefs?.getDouble(key) ?? 0;
  }

  static void remove(String key) async {
    if (contains(key)) {
      await prefs?.remove(key);
    }
  }


  static Future<bool> getBoolean(String key, {defaultValue = false}) {
    return SharedPreferences.getInstance().then((value) {
    return value.getBool(key)??false; });
  }
}
