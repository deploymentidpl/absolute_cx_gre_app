
 import 'package:greapp/config/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static Settings? _settings;
  static SharedPreferences? preferences;

  static Future<Settings?> getInstance() async {
    if (_settings == null) {
      final secureStorage = Settings._();
      await secureStorage._init();
      _settings = secureStorage;
    }
    return _settings;
  }

  Settings._();

  Future _init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static String get authToken => preferences?.getString(SharedPref.token) ?? "";

  static set authToken(String value) => preferences?.setString(SharedPref.token, value);

  static String get unqKey => preferences?.getString(SharedPref.unqKey) ?? "";

  static set unqKey(String value) => preferences?.setString(SharedPref.unqKey, value);

  static String get uid => preferences?.getString(SharedPref.uid) ?? "";

  static set uid(String value) => preferences?.setString(SharedPref.uid, value);

  static String get userName => preferences?.getString(SharedPref.userName) ?? "";

  static set userName(String value) => preferences?.setString(SharedPref.userName, value);

  static String get userRoleId => preferences?.getString(SharedPref.userroleid) ?? "";

  static set userRoleId(String value) => preferences?.setString(SharedPref.userroleid, value);

  static String get userRole => preferences?.getString(SharedPref.userrole) ?? "";

  static set userRole(String value) => preferences?.setString(SharedPref.userrole, value);

 // static LoginDataModel get loginData => LoginDataModel.fromJson(jsonDecode(preferences?.getString(SharedPref.loginData) ?? '{}'));

 // static set loginData(LoginDataModel value) => preferences?.setString(SharedPref.loginData, jsonEncode(value.toJson()));

  static String get adminEmail => preferences?.getString(SharedPref.adminEmail) ?? "";

  static set adminEmail(String value) => preferences?.setString(SharedPref.adminEmail, value);

  static String get adminPassword => preferences?.getString(SharedPref.adminPassword) ?? "";

  static set adminPassword(String value) => preferences?.setString(SharedPref.adminPassword, value);

  static bool get isUserLogin => preferences?.getBool(SharedPref.isUserLogin) ?? false;

  static set isUserLogin(bool value) => preferences?.setBool(SharedPref.isUserLogin, value);

  static void clearKey(String key) {
    preferences?.remove(key);
  }

  static void clear() {
    preferences?.clear();
  }
}
