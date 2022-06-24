import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  static Future<dynamic> _getInstance() async => _prefs = await SharedPreferences.getInstance();

  static Future<String?> get({required String key}) async {
    await _getInstance();
    return _prefs?.getString(key);
  }

  static void set({required String key, required dynamic value}) async {
    await _getInstance();
    _prefs?.setString(key, value);
  }

  static void remove(String key) async {
    await _getInstance();
    _prefs?.remove(key);
  }
}
